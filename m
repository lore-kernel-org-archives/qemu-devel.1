Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC34C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AD521556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYcA9SDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AD521556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XBV-0006sa-FB
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6X7I-0002v0-Sw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6X7H-0006Hb-Nb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:07:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6X7H-0006Fr-Jh
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582625223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAVFyfs4g5GxcXuqRdZQLMND38l/oAcAlYf10NCJQR8=;
 b=fYcA9SDIuTtr51dbEj9uwutYEJ3ouxL/SrMDt8s+z8CJeSzWq/M9Wr3Kg+nVEC0AXm+9Ht
 TNsVKJnxts4lqsWs1M/lnOnIIOikP4RY9g/napDm5jJGnYKvNvvvANLclscYmvAEFNiLco
 PIiPxPfbMhwmyCeZ3DeQ8lni3HvLOQQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-JrrLN1jiNWC_GxaU0EHR2Q-1; Tue, 25 Feb 2020 05:07:01 -0500
X-MC-Unique: JrrLN1jiNWC_GxaU0EHR2Q-1
Received: by mail-wr1-f72.google.com with SMTP id m15so7014609wrs.22
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hQGPjfoLLazHW3K7+BJ1ZENnkqspNGzw0HjTnAJXqEg=;
 b=l4eB0IAY9tx0AMu26hRSfhfVUnuCD1DoajB2EYbE3BtPA8ZT7LkkU/fsJRVNwfuBPd
 x563EA8zhycwhFXYGEPALb1qEmr2o2zdSRUOz5nWph5GipsRQN+2xqnzZ/36Tb8errZ4
 bGCfDf276qRY4cM+SzcJIh+CpfPLzqBlGTOegVnu6ELw1LxpFpJjXLxAPGnx5qrbDn+E
 HDlnkduE6s5dCRjvb6DYfjrakfV8B4QkeKprlqcldcm2oZojJKma6ytrUuEIjex5z1Wv
 k/C7xbKj3dvnCBAXp1FJgFkQWwZJUkQ5K2B5Wp0hHNgOEYlccppEe26tuvZEYA+/Fenl
 fufg==
X-Gm-Message-State: APjAAAVlDi4JFBzadGdGQ/xFpRuq9f/vc3ef1uvr30wzawq6nBB4jFxi
 48erwViAp4oztUEriR2aWpqsW4DQDhB4Xj638/DdJj37QYajxYfDX2cQAn+9vMetCH4BIAkm7BC
 Cf0SCIypM7nyqZvk=
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4173712wmg.63.1582625220262; 
 Tue, 25 Feb 2020 02:07:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLs/h8mAF1Op5pv4Ayz9cSffiHJ1ZoERiw+LFk22QlNcgChr+JwBfIroUj/z2+iIKIVjbOFA==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr4173615wmg.63.1582625219047; 
 Tue, 25 Feb 2020 02:06:59 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a13sm23608201wrp.93.2020.02.25.02.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 02:06:58 -0800 (PST)
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <158254173238.10132.7761755657862330006@a1bbccc8075a>
 <20200224113903.GD1896567@stefanha-x1.localdomain>
 <d3fa195d-d6cc-438f-517b-676b2642df71@redhat.com>
 <20200225090534.GB4178@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <031a3ba8-eed0-834a-0b5c-5e77d0429f34@redhat.com>
Date: Tue, 25 Feb 2020 11:06:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225090534.GB4178@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 10:05 AM, Stefan Hajnoczi wrote:
> On Mon, Feb 24, 2020 at 12:54:37PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 2/24/20 12:39 PM, Stefan Hajnoczi wrote:
>>> On Mon, Feb 24, 2020 at 02:55:33AM -0800, no-reply@patchew.org wrote:
>>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>>> 1/2 Checking commit f913b2430ad3 (qemu/queue.h: clear linked list poin=
ters on remove)
>>>> ERROR: do not use assignment in if condition
>>>> #65: FILE: include/qemu/queue.h:314:
>>>> +    if (((head)->sqh_first =3D elm->field.sqe_next) =3D=3D NULL)     =
         \
>>>>
>>>> total: 1 errors, 0 warnings, 59 lines checked
>>>
>>> The same pattern is used elsewhere in this file.  This code comes from
>>> BSD and doesn't comply with QEMU's coding style.
>>
>> Checkpatch is right, assigning out of the if statement makes the review
>> easier, and we can avoid the 'elm' null deref:
>=20
> The rest of the file uses if ((a =3D b) =3D=3D NULL), so making it
> inconsistent in this one instance isn't very satisfying.
>=20
>> #define QSIMPLEQ_REMOVE_HEAD(head, field) do { \
>> -    if (((head)->sqh_first =3D (head)->sqh_first->field.sqe_next) =3D=
=3D NULL)\
>> +    typeof((head)->sqh_first) elm =3D (head)->sqh_first; \
>> +    (head)->sqh_first =3D elm->field.sqe_next; \
>> +    if (elm =3D=3D NULL) { \
>=20
> The previous line would have segfaulted if elm was NULL so this check
> doesn't make sense.
>=20
> This macro assumes there is at least one element in the list.

Ah good point, thanks.

>=20
> The point of the check is to fix up the sqh_last pointer in the head
> when the final element is removed from the list.
>=20
>>           (head)->sqh_last =3D &(head)->sqh_first; \
>> +    } else { \
>> +        elm->field.sqe_next =3D NULL; \
>> +    } \
>>   } while (/*CONSTCOND*/0)



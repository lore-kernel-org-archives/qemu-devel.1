Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22993C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E314920781
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJI3Bdoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E314920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGK3x-0005hX-27
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59146)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGK3M-0005H3-4L
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGK3K-0002e9-WF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:11:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGK3K-0002e3-TH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584958286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FjUbpYXVO1sl6JhHGPa5s9+w+dSJztf6iGIkhwsIa9w=;
 b=GJI3Bdojl5Q7LPg9j4i2MePlRHA8S+uGdPkhB4xVqkwxYcj50YbzSILz/hgGX0uolTmzZO
 J646+LLxTICLu7S4psXNzKparAqSVC5u79gb8yRgqqCren2baccPHmCaN2ouy/N5hkfVHT
 NOkNauk3fNe4TsL3J6dhudY19p8WvDA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-OhxdfXySP-my_rAwoLXzPQ-1; Mon, 23 Mar 2020 06:11:20 -0400
X-MC-Unique: OhxdfXySP-my_rAwoLXzPQ-1
Received: by mail-ed1-f72.google.com with SMTP id i61so321739edc.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yMu0X68Z7Sw6bOpprYO5AC24MG+UTtle1fVrDve5dDw=;
 b=YoORAOXi7JIE4t+yLg0odEkW/k8HXprXIFthnKrP/Q/qvkI6Kq6gyaCP/8aekzKRXF
 RcB2kyj5UTeyumNYw4C9Ag3jEss+2G2TF/h3mvTu9Lp1lKyl//jf0dF3+yZXmLTbwkWv
 79qw7uQWHxDLsLd5pttXepyz9sRU1eGWxjUsG0YCdwRgkwfH0Sq7oWUX332H4gXjSQks
 psaTocufS0adI54ivjooO/sHCYZ9y449BkrcNnDCXl63zFL/saRs+d04p55ueqJW9wrM
 wXzGobsBhJwyo5bYOGsnbPn74ILxp5cteVpdnCvIb1Gw15da4kU8dASFLG4tRh/2t65e
 EjwQ==
X-Gm-Message-State: ANhLgQ1ax1cm2JOratjZn/ikKYIR/JnlQ8NCVEZ7vRA9m/3fiZkCMHXb
 LN8Yt7dJd7eGaK5uPtuX2xFR0M5iLKfJFCqh6x0EDBmWkBN0xQAODZsBZfqCYqTtrCWP6ZEyiuy
 QYJ6v+ycsq74qh9U=
X-Received: by 2002:a17:907:20b3:: with SMTP id
 pw19mr19342792ejb.210.1584958279254; 
 Mon, 23 Mar 2020 03:11:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvzR+1OAVR98qnPLU22OqaeHz+dPxIbWw6aitGb5GKHbMgLfpf7T0n1lF0Q9D3PtXY2SZAHlw==
X-Received: by 2002:a17:907:20b3:: with SMTP id
 pw19mr19342762ejb.210.1584958278966; 
 Mon, 23 Mar 2020 03:11:18 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id by11sm554251ejc.89.2020.03.23.03.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 03:11:18 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 2/4] tests/test-util-sockets: Skip test on
 non-x86 Travis containers
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20200318222717.24676-1-philmd@redhat.com>
 <20200318222717.24676-3-philmd@redhat.com>
 <20200320123958.354e6cbb.cohuck@redhat.com>
 <20200323094818.GA3379720@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <de766e0b-35ab-6ccc-aeb5-059af3cf0623@redhat.com>
Date: Mon, 23 Mar 2020 11:11:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323094818.GA3379720@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 10:48 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Mar 20, 2020 at 12:39:58PM +0100, Cornelia Huck wrote:
>> On Wed, 18 Mar 2020 23:27:15 +0100
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>
>>> Similarly to commit 4f370b1098, test-util-sockets fails in
>>> restricted non-x86 Travis containers since they apparently
>>> blacklisted some required system calls there.
>>
>> Is "they" =3D=3D "Travis admins"? Can we get them to remove those calls
>> from the blacklist?
>>
>> (I'm wondering why x86 allows those calls. Probably just because it has
>> been around for longer.)
>=20
> I believe it is due to the different build env architecture for
> the non-x86 arches, which is based on a strict locked down container,
> compared to x86 which IIUC was a full VM.

Indeed, Thomas described:

  "Unfortunately, the builds are running in quite restricted
   LXD containers there, for example it is not possible to
   create huge files there (even if they are just sparse),
   and certain system calls are blocked. So we have to change
   some tests first to stop them failing in such environments."

https://www.mail-archive.com/qemu-devel@nongnu.org/msg659909.html

>=20
> Blacklisting like this is a bit hacky, but a prudent fix in the short
> term.
>=20
> Regards,
> Daniel
>=20



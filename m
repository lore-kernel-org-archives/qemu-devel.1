Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F94BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42D32084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IulRRS/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42D32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6f8h-0000jJ-3d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6f7Q-00085M-E3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6f7O-0006Pc-Rw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6f7N-0006No-PS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582655979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FcHfpyi1H3Bdon/pai9beRfZuEQ6St59ZuZWSL273Hc=;
 b=IulRRS/EvzQWReB98xDUnnq96daHIRx7pvNiG6LCFfGu0ZW3HmWI4bzyxwWMgHBV7dfLau
 kb25/PG1NGqwLAKYeGM9xjE2LuvvUfytO7scGYVI/KE5f/tQJNvXnqsSIv7yk9L3xivXgd
 edg+aTuAnGHiPKwZEkm0HaPJmN51Nts=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-lZAmilhYPESHFHezfqmY9Q-1; Tue, 25 Feb 2020 13:39:36 -0500
X-MC-Unique: lZAmilhYPESHFHezfqmY9Q-1
Received: by mail-wm1-f70.google.com with SMTP id x9so131017wmc.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DpsK3br2aTmaqvqh0bX9APiUG3Vis9teqZi/r2AIoQI=;
 b=e7TuTXUJ35UQUZpFaOL/P4MuydV2QxuY7IfK796brVf9BjaU2OTGJRNxvNLsYL3e9Q
 cLRBVijlIV1/SOLrLbgFHDxfgOXwCnDZsw7GqfxWwnKFOUhjLrWFwUqjpEqMMPL3sL//
 6529XD0aw6QajnuYVzNIPbZneByil7IXsaSEzXsUIwxF8IUlwduz1DjrTmIqHzdxNkIP
 XsH3LRPs+KJyX1KBGW/QbugygNK5tBFxAGHEex7B9lkDBSJa1MI7cKUVnYs60VXSJeTc
 5jy/dvz3WOryWipgUFKjQ6/iXeqbSShh7BDpxhF+2Yt5IRjdiZ+qRNm498kqPfKHnu22
 hLVg==
X-Gm-Message-State: APjAAAUIGRsLf9DgTXEKmpzMaHIWb5eSnasBIpkcwyvArooJEupO7s6i
 nvFDzSNTR5Hnr73h7tesLd+oHKMgcZjFDBWb2u0NiqAQo1aTjIq5gVDMpDlFOGutT2B4NG31Q0x
 6zNems3RvfypBqTE=
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr463697wrq.93.1582655974865;
 Tue, 25 Feb 2020 10:39:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7IUZYi5pUpvD+EwshgRSzUf6G3BAckNlU8TYErxMHmjmFf/cj70YZ3nX1QL4Mik0Svb+juA==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr463670wrq.93.1582655974655;
 Tue, 25 Feb 2020 10:39:34 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id x6sm5267583wmi.44.2020.02.25.10.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 10:39:33 -0800 (PST)
Subject: Re: [PATCH v3 08/19] tests/iotests: be a little more forgiving on the
 size test
To: Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200225124710.14152-1-alex.bennee@linaro.org>
 <20200225124710.14152-9-alex.bennee@linaro.org>
 <0c61c0d2-1ed2-0564-4374-db14511aca34@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff49e8dd-6906-e476-1862-4f5b58837191@redhat.com>
Date: Tue, 25 Feb 2020 19:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0c61c0d2-1ed2-0564-4374-db14511aca34@linux.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 robert.foley@linaro.org, kuhn.chenqun@huawei.com, stefanb@linux.vnet.ibm.com,
 peter.puhov@linaro.org, richard.henderson@linaro.org, f4bug@amsat.org,
 robhenry@microsoft.com, Max Reitz <mreitz@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 7:22 PM, Stefan Berger wrote:
> On 2/25/20 7:46 AM, Alex Benn=C3=A9e wrote:
>> At least on ZFS this was failing as 512 was less than or equal to 512.
>> I suspect the reason is additional compression done by ZFS and however
>> qemu-img gets the actual size.
>>
>> Loosen the criteria to make sure after is not bigger than before and
>> also dump the values in the report.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> =C2=A0 tests/qemu-iotests/214 | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
>> index 3500e0c47a2..6d1324cd157 100755
>> --- a/tests/qemu-iotests/214
>> +++ b/tests/qemu-iotests/214
>> @@ -125,9 +125,9 @@ $QEMU_IO -c "write -P 0xcc $offset $data_size"=20
>> "json:{\
>> =C2=A0 sizeB=3D$($QEMU_IMG info --output=3Djson "$TEST_IMG" |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sed -n '/"actual-=
size":/ s/[^0-9]//gp')
>>
>> -if [ $sizeA -le $sizeB ]
>> +if [ $sizeA -lt $sizeB ]
>> =C2=A0 then
>> -=C2=A0=C2=A0=C2=A0 echo "Compression ERROR"
>> +=C2=A0=C2=A0=C2=A0 echo "Compression ERROR ($sizeA vs $sizeB)"
>> =C2=A0 fi
>=20
> Nit: $sizeA < $sizeB ?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>=20
>=20
>=20
>> =C2=A0 $QEMU_IMG check --output=3Djson "$TEST_IMG" |
>=20
>=20
>=20



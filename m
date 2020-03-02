Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BA1C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C15321D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RldNSO45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C15321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8hji-0000Lu-Io
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8hiq-0007sU-0W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8hip-00028F-2G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:50:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47238
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8hio-000283-V0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583142646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8mBJhHVdcAVUE9oLq1BT7ideKFqwm7FLqkX8oW8qNs=;
 b=RldNSO45If+7oGh5icHDVRglKJ6ndy0tSt47azv6m4zXRvZt3CgzFBheqD9xZXHzdhw/P/
 djmYS4qRA7GtJDLrQnVdxBVmxGJ8II8CkqtIVxNqTbZ5rpYn51ec7wr/nccMQYayuyZs6H
 tbRbBUDk+y3+DWpQWGeFseoJ6RM413I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-bn65j3zUPmG5KoaHqZog0g-1; Mon, 02 Mar 2020 04:50:44 -0500
X-MC-Unique: bn65j3zUPmG5KoaHqZog0g-1
Received: by mail-wr1-f71.google.com with SMTP id y28so5515476wrd.23
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 01:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a4f4PojD3BlLpNDcFzl37Py5rGVa6O2F9R8hLCBC5r4=;
 b=PsnIIsOC/mgRSpTDJKBPIJIn3fr765l8nE+GC44F4gsQYr1PJAmun4FrUlssipjvmL
 bb09a3OmuK4eFFEglYLm0bYC199UDMPtSdVVT5rDpEd2stMapPXQcyBVu69GhXJI6MdR
 ibei0q+XSdxXIXiUBo91mywSJ60rU89BmhfZv5nfxYgoh8zaGZU+U9qiGrYoglHOLxFb
 yv+eZDC+EuEeKjOYgcQ5VNIaNpK/nivRR0GU1xdfNn+PbPNswV27TE7lp0Xnn1OLqDKO
 CcOBGk71JrY+IySZnRc9mmqe8GdMyyjnH/mlRj+bUOCIIfY2bY1Wp4Bs9pkR4NVs5N6N
 wvKg==
X-Gm-Message-State: APjAAAWbvVcDouVDZVSMukPV32aAvDRmSWtPJsPoC5ndC4X+IaZxmops
 SVEoFTOd+AN9SnXBBp2gmJ6Ls50O5+Hke6IVvICNLW4rsAPW3ee8L+faeWWOiq6AG51nxSdL5fZ
 a/BxOLHUB3hZzfzc=
X-Received: by 2002:a1c:994b:: with SMTP id b72mr19918663wme.83.1583142643370; 
 Mon, 02 Mar 2020 01:50:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhofVf7pDv2axhM23+bV2IQzLbeYvDvOKwGBWQ1+DnXUzWyxqJk1R+soP1gHfWLrKdkUmeCQ==
X-Received: by 2002:a1c:994b:: with SMTP id b72mr19918640wme.83.1583142643113; 
 Mon, 02 Mar 2020 01:50:43 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id j20sm15621030wmj.46.2020.03.02.01.50.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 01:50:42 -0800 (PST)
Subject: Re: [PULL 4/9] hw/display/artist: Avoid drawing line when nothing to
 display
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200218193929.11404-1-richard.henderson@linaro.org>
 <20200218193929.11404-5-richard.henderson@linaro.org>
 <20200229093111.GA24534@t470p.stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <886c3773-cda8-fbfe-4535-3874d028f2e3@redhat.com>
Date: Mon, 2 Mar 2020 10:50:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200229093111.GA24534@t470p.stackframe.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/29/20 10:31 AM, Sven Schnelle wrote:
> On Tue, Feb 18, 2020 at 11:39:24AM -0800, Richard Henderson wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20200214001303.12873-5-f4bug@amsat.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/display/artist.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/display/artist.c b/hw/display/artist.c
>> index 97c811b35e..5492079116 100644
>> --- a/hw/display/artist.c
>> +++ b/hw/display/artist.c
>> @@ -579,6 +579,9 @@ static void draw_line(ARTISTState *s, int x1, int y1=
, int x2, int y2,
>>       } else {
>>           dy =3D y1 - y2;
>>       }
>> +    if (!dx || !dy) {
>> +        return;
>> +    }
>>  =20
>>       c1 =3D false;
>>       if (dy > dx) {
>> --=20
>> 2.20.1
>>
>>
>=20
> I noticed that this change causes 1px wide lines to disappear. So i would=
 propose
> to revert that change.

Maybe "if (!dx && !dy) { return; }"?

>=20
> Regards
> Sven
>=20



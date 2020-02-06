Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A045C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447EC206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzZPY3/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447EC206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf3z-0000Gp-DQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izf1D-000351-Cq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:08:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izf1C-0005sE-4i
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:08:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34312
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izf1C-0005pu-0L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580987301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AS0nEzYBOWUX42VgZ6/aCvxTM0F6DjJNAL92beNsEFk=;
 b=ZzZPY3/GDGMfNv+hLelJLybaT8kvJbWTZzgsXfVN14qF3CwKKIJmNJdLTfvpPlubhx/sm8
 XPCNLgrS2W0okQpzHKuxTCgAylOaIVD6X+TBZCXTfrJptH1I4Co0Lw3jzBizsbRb8ARgIU
 jwhr4dF8jK06YRX7F93ASQaLQKM3jvA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-G272hgZ2P4WU7ROomynWsQ-1; Thu, 06 Feb 2020 06:08:16 -0500
Received: by mail-wm1-f69.google.com with SMTP id t17so2615127wmi.7
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nu5Dy5d0X7tVEgM4PbaK9Aq4Ut1lH3ZTznIj6j1nAIk=;
 b=Qo4O5AONC+GzbufFt7jgnpYKrxuXx26T2rfXS60Os+ypfuAW7MMnsndKtyWwzfY4Gr
 y03GLihOsii66e5ti4fgKrCxDhmGGug+zFRlcGvU0om3Q1i0FtSJYkVNpEPIvjmhjheP
 6q75TImW0LhFA+H3py8nZYqm1odDF3EboD3SZfBAGgS4yWvJDaMjIJIgtr1+YuNRHOne
 OTKE3YE4llDRC2ufdwUlNRiA7MF35xc82/Mk0K378ruwtvfpd+KUIUFrjOuOSIoZvjxw
 JXCWctOxozTEd2Qvxu0djWs4y+wGy6yuYilB3RAnUIcpJIkqB2qXzOqdDdUv1SJHU8BP
 RScQ==
X-Gm-Message-State: APjAAAUI66S3vgQ4kITs3A3GlYReVwi+l89fKCllKyXQMiomOs2sEmnl
 1Cr5osiow/On64tQQXMLtjWQsmRSuzoaSbogmJYslJROpAu/etNxCAHhF8+nQ2TaJPpumMeImfE
 VTZVKgb2vqnX1W4A=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr3925373wmh.35.1580987295761; 
 Thu, 06 Feb 2020 03:08:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdotbsdzuJ0QK8GPsLXU10ZT+nTsw0curItafwRoNkY3rDGlXkoT5URdmwyVNG4LK4gAwVjQ==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr3925338wmh.35.1580987295463; 
 Thu, 06 Feb 2020 03:08:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b10sm3872007wrt.90.2020.02.06.03.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:08:14 -0800 (PST)
Subject: Re: [PATCH] mailmap: Add entry about me
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Yu-Chen Lin <npes87184@gmail.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20191206140931.14133-1-npes87184@gmail.com>
 <bd91caac-86c5-54a6-080d-37909b91a656@redhat.com>
Message-ID: <548b2024-f34e-f4cd-f3b9-c4575c918cbe@redhat.com>
Date: Thu, 6 Feb 2020 12:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bd91caac-86c5-54a6-080d-37909b91a656@redhat.com>
Content-Language: en-US
X-MC-Unique: G272hgZ2P4WU7ROomynWsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I suggest changing the subject to:
"mailmap: Add entry for Yu-Chen Lin"

On 12/6/19 3:15 PM, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing qemu-trivial@
>=20
> On 12/6/19 3:09 PM, Yu-Chen Lin wrote:
>> I have two mail address, add entries for
>> showing author and email correctly.
>>
>> Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
>> ---
>> =A0 .mailmap | 3 ++-
>> =A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 3816e4effe..3fbf3902a3 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -151,7 +151,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
>> =A0 Xinhua Cao <caoxinhua@huawei.com>
>> =A0 Xiong Zhang <xiong.y.zhang@intel.com>
>> =A0 Yin Yin <yin.yin@cs2c.com.cn>
>> -yuchenlin <npes87184@gmail.com>
>> +Yu-Chen Lin <npes87184@gmail.com>
>> +Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>

Apparently the mailmap process is getting stricter,
can you Ack-by this patch from your Synology account?

>=20
> Thanks for updating your entry in .mailmap!
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
>> =A0 YunQiang Su <syq@debian.org>
>> =A0 YunQiang Su <ysu@wavecomp.com>
>> =A0 Yuri Pudgorodskiy <yur@virtuozzo.com>
>>



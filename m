Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51280C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8BF214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT+UM1Jg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8BF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgwI-0000aZ-7Z
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izgjb-0000x9-R4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izgja-0002LD-OI
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:58:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izgja-0002Kc-Kh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHAKl8pesUGlBD+BRq3bhs0mKFdOTb/GnYO0Mbr1D10=;
 b=AT+UM1JgKm79YnjeID636F3Hp+rzmN3mBuTXsZ3UDzbBRr+wLwtRCgPNe28WdgGOHZPW1u
 n5WGsoopG85kxhbzZ0AlzELZewWLmu0Wo86kgUMgIFBBcOIBfQXIRiLHKNuUsI76x+U/bU
 gKsjmgpcc8emjq306JAEAKtUtEFdi0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-QnFUUW3pMemKFLSbOXsZag-1; Thu, 06 Feb 2020 07:58:15 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so2594883wma.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 04:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2UUzyxmqnLLpOCeg29AAbMmqKpCwRZYUEkXMgFeju9Y=;
 b=BXSWnBikE752SKDFWmTO44RVtuu787mSVYLRnh8ZP3cV5AJb5Io84++0DuL2zALJf7
 5/x/RqNxv49E6CDg5CUk9mSKQHwj9DqB25b0xCy80shQDihPVGpfqXNK3as6xlNxX1lp
 e/4stRLL9Ke4avCqYjsJN3ZKIfUNjYG/7CQwFiQjSe68YGvVqQO3vmXyOlDk43AC9sun
 bqkWJ7SuQeqTi+7kenoj/P9L1hEVq5H/qbvtLnGeDWmSHolOJ66m63C/0Hhewq7sT2MB
 RF1m7wbiizE+8za3HFhOenmyMlm2KS3affKsHBmUPsJKjN3bQeDLdoSCWl1++VsjKb/d
 1F+Q==
X-Gm-Message-State: APjAAAWm+tjv/2ts5NTET24mWfDbZPkr5aCeIC1ChojF9fR77749+ki3
 XhbqcfsgGX4XBnB/maLQw+OT2IGjk77piBmSnsvJ2H6RPj7XAd3cw4g/25SNjHpcdIfCMvgnPcW
 oXiqvba2KUftvaJI=
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr4488978wmg.103.1580993894345; 
 Thu, 06 Feb 2020 04:58:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqzbmA0OTOLQksvQZ6+QA1/BQE39yf9Hny40zz/AERZZdoPt88kuLpd2/xiNC277dljNgVB2FQ==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr4488962wmg.103.1580993894145; 
 Thu, 06 Feb 2020 04:58:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g79sm3360412wme.17.2020.02.06.04.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 04:58:13 -0800 (PST)
Subject: Re: [PATCH v2] mailmap: Add entry for Yu-Chen Lin
To: Yu-Chen Lin <npes87184@gmail.com>, qemu-devel@nongnu.org
References: <20200206125504.7150-1-npes87184@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0df754cf-c633-25a2-a9a9-194235a445d2@redhat.com>
Date: Thu, 6 Feb 2020 13:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206125504.7150-1-npes87184@gmail.com>
Content-Language: en-US
X-MC-Unique: QnFUUW3pMemKFLSbOXsZag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, yuchenlin@synology.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 1:55 PM, Yu-Chen Lin wrote:
> I have two mail address, add entries for
> showing author and email correctly.
>=20
> Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
> ---
> v1 -> v2:
> * Change subject
>=20
>   .mailmap | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 3816e4effe..3fbf3902a3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -151,7 +151,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
>   Xinhua Cao <caoxinhua@huawei.com>
>   Xiong Zhang <xiong.y.zhang@intel.com>
>   Yin Yin <yin.yin@cs2c.com.cn>
> -yuchenlin <npes87184@gmail.com>
> +Yu-Chen Lin <npes87184@gmail.com>
> +Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>

Since I know both emails belong to you (see the EDK2 similar patch
https://github.com/tianocore/edk2/commit/0ef6fbbd114e89b8d838eade39bc3a6d7e=
c54c3c):
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>   YunQiang Su <syq@debian.org>
>   YunQiang Su <ysu@wavecomp.com>
>   Yuri Pudgorodskiy <yur@virtuozzo.com>
>=20



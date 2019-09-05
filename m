Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88911C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C22620825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C22620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5q9b-0001Yr-DJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 07:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5q8m-000172-RN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5q8l-00058H-TD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:41:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5q8l-00057w-Ns
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:41:27 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80B0D88311
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 11:41:26 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id s5so854016wrv.23
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 04:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jogK2pooooxDVdcy5QWrNeOeciZ6a/zGMh2xAzBYDDI=;
 b=eeU6+mp84TAXSJ5AZP8JTWz1DyDG3tdDpRKZFtnVTsFzzm4SGtdO7Evl7odawoaAjU
 8dcRBNpPZw0hnBhatRbet6+3xW3w+arzS5//MR9021KDoSYxbOIMayQpPpVuqUuNeEnD
 Fq8cgqqXeF7aX8WW/PyuOSLKT0cGsgrDH0JTEkekf7atamp6PPswt4iMDY7VvWw2SvqJ
 7bmK3PIgtqpVsaw85SfJ3p4NFdaZFreA9bWTdXMpviXmCTixB7qgsTKxclvF8Sautcl4
 vyX+wpmW7mUmbYj/TJR/qJ2GyhwNh/6DPT5p5vtL4iPqV6yYzvBMP5LT3TYB+haYshr4
 VKmQ==
X-Gm-Message-State: APjAAAW9yUkcKmSbEsjFEl//S6MeoC7BrfbjRc+jotTd8Ajc60KvV3vJ
 wakn1eBmuqWV56Q7GkMjAu+Te3ibyQ4q/B1NfH8l6oJs0z6+V03wEQSIw4EMB+XHw/GHTwVeqtY
 aQ2BLO72p9WOlIlw=
X-Received: by 2002:adf:ef12:: with SMTP id e18mr2222586wro.65.1567683685331; 
 Thu, 05 Sep 2019 04:41:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNTI7VrajQPG06A/Rm/gFx6yJ4IUlrgUC5sOMecloD3Vm8/Jz+m8xLiv0+edhf9fzeP9mp0w==
X-Received: by 2002:adf:ef12:: with SMTP id e18mr2222567wro.65.1567683685159; 
 Thu, 05 Sep 2019 04:41:25 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id h17sm3551151wme.6.2019.09.05.04.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 04:41:24 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>
References: <20190905113346.2473-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a5f086fb-e918-735b-392d-423f61ef618d@redhat.com>
Date: Thu, 5 Sep 2019 13:41:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190905113346.2473-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] travis.yml: Install libcap-dev for testing
 virito-9p
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"virito-9p" -> "virtio-9p" in subject

On 9/5/19 1:33 PM, Thomas Huth wrote:
> So far we were not testing virtio-9p in Travis yet, since we forgot to
> install libcap-devel. Do it now to get some more test coverage.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 92b00927d4..1d46442020 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -15,6 +15,7 @@ addons:
>        - libaio-dev
>        - libattr1-dev
>        - libbrlapi-dev
> +      - libcap-dev
>        - libcap-ng-dev
>        - libgcc-4.8-dev
>        - libgnutls-dev
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


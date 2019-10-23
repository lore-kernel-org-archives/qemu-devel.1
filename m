Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E725CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A4020663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A4020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFIl-0006x3-Db
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNErK-0007SF-8T
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNErF-0002ZO-95
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNErE-0002YM-LO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 07:31:17 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A318E83F42
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 11:31:15 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id x9so4432248wrq.5
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=S5ORo7ueIwdG8YLniF6bQVN3WnoBHthMXDt9+GQHxkk=;
 b=Z9dbIF0m7P1WYHOjLAvAWwHaaDEIIKntiKtnGT0q1jvVK89kQQ+RQL3gfp7vNpE6f4
 tTpVoj5obA/6WNy0FikaLuwZ3AP341LakxJgpUxRMjBJdqOKPzbFN7ATfmdtJWrLweew
 rV4MsLZoDj9JWjxZsja/IEzzW4nkJIO9e7c4ku13khddb0zX+0L2pONVL1Irr2tp/XCp
 wy1CB82/3ON7S2tTa7BtIUz45cc7MGtQuDNLTu3cwJIzokx8DZX8/4T29c0R4G8pxt0y
 V8cyxck3dpuX6KD0CvL27wrcgP2Z5IsrnQNniYkme4uhpKSWfnWfXfbYlOJEMKy3hjz/
 KHGQ==
X-Gm-Message-State: APjAAAXbDd9feRwT1sXwew95jf9YivaeG8I/kW40tle5Qo9D+NKMhHF1
 yhfwXKN8pYHagiApM5K1a+IGFP/rFffF+R27hOmmxb1lqs0+n19BnPeJ6otFiekrMG0Xmm465yK
 igtf//HcRmrrn4Mo=
X-Received: by 2002:adf:e283:: with SMTP id v3mr8328759wri.20.1571830273838;
 Wed, 23 Oct 2019 04:31:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyo0KTY6CABf0ICFERMQ/kmuK2mVjXteJVzTrQteanPenN7cqC2x4fk4xHK1rUFK+cbXTwnNA==
X-Received: by 2002:adf:e283:: with SMTP id v3mr8328731wri.20.1571830273629;
 Wed, 23 Oct 2019 04:31:13 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u10sm12263977wmj.0.2019.10.23.04.31.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 04:31:13 -0700 (PDT)
Subject: Re: [PATCH v1 08/19] travis.yml: bump Xcode 10 to latest dot release
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <773beb76-0869-aeca-b3ed-cb212d29574d@redhat.com>
Date: Wed, 23 Oct 2019 13:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022191704.6134-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alex,

On 10/22/19 9:16 PM, Alex Benn=C3=A9e wrote:
> As 10.3 is available lets use it. I don't know what Apple's
> deprecation policy is for Xcode because it requires an AppleID to find
> out.

Can you add a link to:
https://docs.travis-ci.com/user/reference/osx/#macos-version

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index f2b679fe701..da6a2063fca 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -247,7 +247,7 @@ matrix:
>       - env:
>           - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-so=
ftmmu,m68k-softmmu,x86_64-softmmu"
>         os: osx
> -      osx_image: xcode10.2
> +      osx_image: xcode10.3
>         compiler: clang
>  =20
>  =20
>=20


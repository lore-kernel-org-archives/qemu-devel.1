Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F2FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412FD20640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412FD20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDFnN-0004ms-RW
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDFj9-00011F-N4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDFj8-0006dV-7v
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDFj7-0006a2-S7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:25:38 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7428389AC5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 22:25:35 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f63so105898wma.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xupB96/vcn6Bs+awANC7azpfq6h7lnk5nM/mYfgeFn0=;
 b=OFJ8dYnVm420emXmoCi/36x49XtToVi4d2fxAyjEhD+R5wBdoc9Fd44HiP3+e80l0n
 8Ef1ZXwrW/LzeQPmVrpfcsxuRn9LQAawMQW9G2ih4JLLeby3HERC8/9zvABDtZUicj4Y
 MFZx0UnDGeeAzBQo1s6IpqEwYtHQ23iqHkiOpvJHS+UIZisEy/Cgnqc9LxY1kLhB7Rf2
 JSi4YeRdZo6+Pv51jDhzf5q2UdDewFk1vvji7u3gn4uU495ddpCW2cckwNCa1NSgFvDY
 bYPqXCHrXGy3b2qWqjuaoUuyKL5tpcGo6SiTVjMFzQm1AvDhNoAt2eBNWy4R1+8TINEk
 ygAQ==
X-Gm-Message-State: APjAAAX1oBaHrsjCvrc9Rtt0QmVTePWBbIKrVbjdd9JKfCpYljtIgz+N
 4Zc/MVoy6lN/O5O0E8ZoE4pVWaxvMu9HenC2FbNbL4tan96XbWrcW+i0suxpJk+ay0xPyjb/U1e
 NusLIeGvGyW8RQBE=
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr301388wme.135.1569450334244; 
 Wed, 25 Sep 2019 15:25:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgVwelZ7Iwyul7zTHPkRriB+oySC7yiQZOXblA0dI+Hn54SZg/vKrKx1vMTqjydcs3HijPfA==
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr301376wme.135.1569450334052; 
 Wed, 25 Sep 2019 15:25:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f143sm415080wme.40.2019.09.25.15.25.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 15:25:33 -0700 (PDT)
Subject: Re: [PATCH v3 22/33] configure: preserve PKG_CONFIG for subdir builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190924210106.27117-1-alex.bennee@linaro.org>
 <20190924210106.27117-23-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bcfde8e9-bd2f-d5f9-ba55-f98545ff7f9a@redhat.com>
Date: Thu, 26 Sep 2019 00:25:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924210106.27117-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
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
Cc: jsnow@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 11:00 PM, Alex Benn=C3=A9e wrote:
> The slirp sub-module complains about not being able to find the glib
> library on cross-compiles because it is using the default pkg-config
> tool (which isn't installed in our cross-build docker images).
> Preserve PKG_CONFIG in our host config and pass it down to slirp.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile  | 6 +++++-
>  configure | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index a0c1430b407..8da33595edd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -510,7 +510,11 @@ capstone/all: .git-submodule-status
> =20
>  .PHONY: slirp/all
>  slirp/all: .git-submodule-status
> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUIL=
D_DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)"=
 CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
> +	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
> +		BUILD_DIR=3D"$(BUILD_DIR)/slirp" 			\
> +		PKG_CONFIG=3D"$(PKG_CONFIG)" 				\

Eh it was that easy... nice.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +		CC=3D"$(CC)" AR=3D"$(AR)" 	LD=3D"$(LD)" RANLIB=3D"$(RANLIB)"	\
> +		CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
> =20
>  # Compatibility gunk to keep make working across the rename of targets
>  # for recursion, to be removed some time after 4.1.
> diff --git a/configure b/configure
> index 397bb476e19..542f6aea3f6 100755
> --- a/configure
> +++ b/configure
> @@ -7302,6 +7302,7 @@ echo "OBJCOPY=3D$objcopy" >> $config_host_mak
>  echo "LD=3D$ld" >> $config_host_mak
>  echo "RANLIB=3D$ranlib" >> $config_host_mak
>  echo "NM=3D$nm" >> $config_host_mak
> +echo "PKG_CONFIG=3D$pkg_config_exe" >> $config_host_mak
>  echo "WINDRES=3D$windres" >> $config_host_mak
>  echo "CFLAGS=3D$CFLAGS" >> $config_host_mak
>  echo "CFLAGS_NOPIE=3D$CFLAGS_NOPIE" >> $config_host_mak
>=20


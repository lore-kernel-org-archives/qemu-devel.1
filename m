Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437BFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E07207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 17:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULzOd9Ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E07207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKnY0-0006uU-Ib
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 13:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKnXK-0006SR-UU
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKnXJ-0005se-Ba
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:56:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35641)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKnXJ-0005sI-5H
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 13:56:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id y21so3754419wmi.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4EbsfDokOIkOLaV0giHdnvonQWEjy7lBJVHzgkXQhWk=;
 b=ULzOd9LdM2RNHdPQylbBlEGOfmCcis/gdL9ZMphjsv+Mz62nlKSIMyfNSmoOS8cCI2
 +UFpd/j83OVptrtUmZs6XPKWMK6VGW0OUdymxBn4kKtNp/vDQOX6gR98VFkD7TOsaWTV
 xsZMCwOrIKreiROLzNUtYjXaGrDZ43JMcrK/kzJKgjyUGgGYN5WYpxElBItpAAbF3gqy
 l3hdsVsfz302mu3NG7ZoX1tAKNdTScDGkj+v9xEc3wowG00qKJPmQBI+8GoGkzNl0ma/
 HiYLCvb0wYXHyucaugbqAqET0sip73LN4Zs/54pVTD+0KxoOlrw8/myml3FbBeV9xCzJ
 dCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4EbsfDokOIkOLaV0giHdnvonQWEjy7lBJVHzgkXQhWk=;
 b=tdmyZ9uD3ks1N2QLlrceeEtyeyIQA5cRvMbZTy2m2YqDtQIj1XshcISUA88J2SSQxv
 vDvJNp1ZAXpp0S/b3izZyGmLLZ5zq9ubmcUdmT7FRt8swmD1agiXCYbt6TD1ywBe+FX5
 A9osvWR+FRMSayP9WqVhidoPXj4KjFuEdnOMJXUF2iFoObTJddsy9C2vmFDRk2uz7THb
 DcPH0BZCDlGJrXUij/O2ytCB59jWFc8sTO2sz1WyTKX3fMl+aOS+tH1NgBc6/gWqFeNN
 2bEHWB0J2t/6fiJKT0R7Y3VDhNeLQseKGrtAC97++FBDm+Ugo46je2k81YNU4PXB6gxQ
 9qjA==
X-Gm-Message-State: APjAAAXDw7w0ZtrcCu/KGOHf8NPmxWTuhIf4DC7e3HUSFdhkGKy+hX8u
 IoTJsScox+AUNxvPIKdYkCGpvQ==
X-Google-Smtp-Source: APXvYqyW59QK69+m8QEIg2sjdFO8Boq9flDOd36/G2xrfuJOexunVN/B5kj2LGFJY0NMb7zU+HHY9Q==
X-Received: by 2002:a7b:c219:: with SMTP id x25mr4736785wmi.143.1571248594991; 
 Wed, 16 Oct 2019 10:56:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s1sm36071637wrg.80.2019.10.16.10.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 10:56:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F5D51FF87;
 Wed, 16 Oct 2019 18:56:33 +0100 (BST)
References: <20191009170701.14756-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/5] travis.yml improvements: Update libraries, build
 with arm64
In-reply-to: <20191009170701.14756-1-thuth@redhat.com>
Date: Wed, 16 Oct 2019 18:56:33 +0100
Message-ID: <874l0860by.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Update / add some libraries that we use in the Travis builds, and
> enable compiling on the aarch64 host, too.

Queued 1-3 to testing/next and I'll have a play with 4/5 but probably
won't include them in the final PR unless they seem solid.

>
> Thomas Huth (5):
>   travis.yml: Add libvdeplug-dev to compile-test net/vde.c
>   travis.yml: Use libsdl2 instead of libsdl1.2, and install
>     libsdl2-image
>   travis.yml: Use newer version of libgnutls and libpng
>   travis.yml: Fix the ccache lines
>   travis.yml: Compile on arm64, too
>
>  .travis.yml | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)


--
Alex Benn=C3=A9e


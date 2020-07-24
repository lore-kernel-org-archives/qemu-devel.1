Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960A0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F38B206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLxOIy/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F38B206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytTe-00044b-MR
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jytL5-00060H-Sj
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:45:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jytL3-0000Oo-VI
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:45:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id r4so4593702wrx.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 01:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i/QIi6Q0bJlXRqgTA081r7ZsRYlAZuwuV7MHiwU6Fsw=;
 b=mLxOIy/glUZx0ROPhuke8Tbjkazph0okQ0fJVitwg+7q8UqNcA/MOjhr2Z3hEJQFdE
 kZoQtYAaNSJXiUR87ko6WS0BanH/UQoqNLGjxrQV493gfGIfYfj9ZB8OPqe0Fk2TeIaZ
 3xUvTfo3cq/+01rc4ZPBV/IaEBGEYOlVFIKKhrzci6YiJprgigg3CPQ2uxGOuNupOL9f
 Uvm3Tk1iTg8DHwDymI1KrHAmYgMrOLn44TvTyD0oTFzFDC121xDkD+dLIEUjTuj288Wj
 CyjtasfC9eVjEUzC6Y4MK9u0ar7FvppCDPRzcosSxyliGVeHAi5hHGQNO/mWT9B0OGJY
 +idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i/QIi6Q0bJlXRqgTA081r7ZsRYlAZuwuV7MHiwU6Fsw=;
 b=QkpeWhnz/xc0DlqiBiz938pNB7VEV9J4RT7IO3GeT62M00MnRlCAeRwWfLsK+r3j+s
 EoMXGBvw0ydujavtlZlEbHMRKCcHNuD9245OyZ2hFUXWTHxhdygWbs7+sHsfRrt0zmPF
 nTkVbjT0xWHuiqsySgHioo1hN7KzMcxiF+33YtCrU1mr8WgFsQYBJSPJ5S0K8qnc4p3M
 OuDjFm/Ju4W+PkArwY3iCser9KH03BqMGu0DOAmc04AcTCH+uSdnP7ZIV1Kwzv/RrISL
 dQkb/wTOUNK7E38x1PDZMn48/d+Y3yCPbDmkMLa+ZbVACX/tDr3Siw8aMaClrDFUTEUk
 rRjg==
X-Gm-Message-State: AOAM532N0V+TgeHjZQ5S7xT/LevZGet8UmJOpS1zMTKTy3YfOSzGZHtB
 ZSXcZ9WmG6pO8ozWfk1Fyf6trg/udXY=
X-Google-Smtp-Source: ABdhPJxWqC9eSjJHMiVbeO02yPmKBTxRJiiAkyB/B0idHcPBSXrK1ahFxOkgNfImb3IhWo556OriKA==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr7522190wrj.336.1595580355830; 
 Fri, 24 Jul 2020 01:45:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y189sm7554248wmd.27.2020.07.24.01.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 01:45:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E554B1FF7E;
 Fri, 24 Jul 2020 09:45:53 +0100 (BST)
References: <20200605165656.17578-1-philmd@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry to review Avocado based
 acceptance tests
In-reply-to: <20200605165656.17578-1-philmd@redhat.com>
Date: Fri, 24 Jul 2020 09:45:53 +0100
Message-ID: <87v9ids3lq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add an entry for to allow reviewers to be notified when acceptance /
> integration tests are added or modified.
> The designated reviewers are not maintainers, subsystem maintainers
> are expected to merge their tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e7d9cb0a5..c2ae2bf390 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2923,6 +2923,14 @@ S: Maintained
>  F: tests/tcg/Makefile
>  F: tests/tcg/Makefile.include
>=20=20
> +Acceptance (Integration) Testing with the Avocado framework
> +W: https://trello.com/b/6Qi1pxVn/avocado-qemu
> +R: Cleber Rosa <crosa@redhat.com>
> +R: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +R: Wainer dos Santos Moschetta <wainersm@redhat.com>
> +S: Odd Fixes
> +F: tests/acceptance/
> +
>  Documentation
>  -------------
>  Build system architecture


--=20
Alex Benn=C3=A9e


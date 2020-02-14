Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3985C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9D20656
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuZLh9FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2eEo-0004CE-PR
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2eE6-0003gt-FI
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2eE5-0005Hs-7x
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:54:02 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2eE5-0005Gx-0k
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:54:01 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so11338185wmi.5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=afzw2W72qcHXR6A8kGYZyq5gSDPLvEkLwUds2milWVY=;
 b=JuZLh9FCpte2OCBWa3dZmprJX0nsyVjHK/tI/7ZYmCB43SGqyCIB2LowBsfkgR9DNe
 MEvfRuI31krSCVDKl/uKEp2KBkHT19X7jUarQEIznNdxDMI+h+gkVcgUGMB+V0clrxdu
 bB2KKs1SaFvJOV5Lf2kuXIciPpRYAe5J8mh8kjzKxZpoU7TcgUYknCL2RYFcxxfuhf4Y
 Xr6dfwTZVyjxueIkOhsS6YyLN6GJJQKBuJBmJNgDxo7FXJRCQstSUh5iwDmhB1k5IkRL
 claw2oBiVrPdjoYrmt+mfAaeJcHK8PGZqy2QAgKLMC+HoJvUTPAMPCKnoi4IOAYxnqDf
 IhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=afzw2W72qcHXR6A8kGYZyq5gSDPLvEkLwUds2milWVY=;
 b=iU37HKDHQUi1Geo/PeRlD+oIEA5IGivNT3gov7fSpc4EMxviogkC02imM0hQopmm1F
 R7dgJcvi0+nqLrfCydyMjQEXER/oL4BX6IJ2fuwks0QCKLiH//RW2836fHIO01RYtcEP
 uvsG7hHG/D02jt8Ojx/Qgl4uhu5nHbY3LPCH1z7XcJOTIgP56mcv/IaxT3XqERIHJjI2
 6CkfInQuEdSoNl0l3u4BXUriFvko/I+YSI3zPAeb2UV8d9Eejp+S7Z7o9EDPXNvdV86n
 g7s+jtodu94sEDUJ47KyA5Z4VVn486QAK0i93LaFit2HSlNk5GEEeeKgHbjoy1v4yRz5
 d5ug==
X-Gm-Message-State: APjAAAWmVuKsiA+ux7/A/bhG7t5a+Fb/tdhIbWcjiWnt8rSJ93IBi0cR
 Q+HATvNpK+fgAH44neE/n8GQbg==
X-Google-Smtp-Source: APXvYqxyDrG+bdgRY6w3Z+13miLVQsN6+PZMZuet29FEt5baU56nlE29Sh1AhP8bOfh9mmFFFfGmfA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr5450204wmb.174.1581699239807; 
 Fri, 14 Feb 2020 08:53:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k8sm7674334wrq.67.2020.02.14.08.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 08:53:58 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A68761FF87;
 Fri, 14 Feb 2020 16:53:57 +0000 (GMT)
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-9-robert.foley@linaro.org>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 08/14] tests/vm: Added configuration file support
In-reply-to: <20200205212920.467-9-robert.foley@linaro.org>
Date: Fri, 14 Feb 2020 16:53:57 +0000
Message-ID: <87r1yxp0t6.fsf@linaro.org>
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Changes to tests/vm/basevm.py to allow accepting a configuration file
> as a parameter. Allows for specifying VM options such as
> cpu, machine, memory, and arbitrary qemu arguments for specifying options
> such as NUMA configuration.
> Also added an example conf_example_aarch64.yml and conf_example_x86.yml.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/Makefile.include         |  2 ++
>  tests/vm/basevm.py                | 29 +++++++++++++++++-
>  tests/vm/conf_example_aarch64.yml | 51 +++++++++++++++++++++++++++++++
>  tests/vm/conf_example_x86.yml     | 50 ++++++++++++++++++++++++++++++
>  4 files changed, 131 insertions(+), 1 deletion(-)
>  create mode 100644 tests/vm/conf_example_aarch64.yml
>  create mode 100644 tests/vm/conf_example_x86.yml
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 778e506755..e9ed33226d 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -35,6 +35,8 @@ vm-help vm-test:
>  	@echo "    V=3D1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU=3D/path/to/qemu		 - Change path to QEMU binary"
>  	@echo "    QEMU_IMG=3D/path/to/qemu-img	 - Change path to qemu-img tool"
> +	@echo "    QEMU_CONFIG=3D/path/conf.yml   - Change path to VM configura=
tion .yml file."
> +	@echo "                                   See conf_example_*.yml for fi=
le format details."
>=20=20
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>=20=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 33004934af..f488d4103c 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -32,6 +32,7 @@ import shutil
>  import multiprocessing
>  import traceback
>  from socket_thread import SocketThread
> +import yaml

So this throws my setup on my Gentoo SynQuacer. Is this meant to be in
the standard library or is this a separate dependency?

--=20
Alex Benn=C3=A9e


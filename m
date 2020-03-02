Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A1C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA12D21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 16:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyalnsTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA12D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8o6M-0005yq-3p
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 11:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8o5e-0005XI-G9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8o5d-0003m4-5b
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:38:46 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8o5c-0003lc-TM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 11:38:45 -0500
Received: by mail-wm1-x342.google.com with SMTP id e26so5714600wme.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 08:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tpEucyLfB4Yl/TQMS7kMYgvJIrBTeRXnajQsrAz2dtc=;
 b=XyalnsTpsv8Yb0LkHliMrNmmbnJ5WeS12ND+6dW7JmONVbaL+A6Lt+wUUwVsZq8qUq
 ssS4WjdDkLgyj48jwN2JpfFHyxjrUm/+NhLlVqX5X3kcXJuK2xSyhCIFkkXZEpUB4jda
 DcmaNXOnsdDqOJrb8XBEsuFTx9SOQYyK9M4RghMGifaSObXDXrws9GIdHpeDfR6H21g3
 0EW/+orbnJh0oM06tsRtl5DUDK1RjQ3Pm15cvXh+F9/uMSe6qbGn5wTrQndFkDLER9V5
 Qx1LMXCP4Y97CzWpDSw24bbXo4Cg41peiaYsHO4rmTuN54IfC2puENgxCAR6aDoh0xUM
 MlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tpEucyLfB4Yl/TQMS7kMYgvJIrBTeRXnajQsrAz2dtc=;
 b=LkJR70KPYMY36l2VS0Bi95ZPazbb7N7wpr7Xw8Gkfa/EChxI6/CtC2jdBHmKTXaXEr
 0b0vhpJIqF9+VB/QRmXpWBfTiKS5isaU6uVNoylBQaFF2jIn9QK8j5RwK6Yv8Wst+JR9
 8+2m1m76uMbvRkNSWSCO1gbPiPNTU6n4LaE0RTRCUR5S6TwzvlmjGFNCEHnTC7xM86lP
 Y0NrMxK20kt3fJ0fZqygigr9Yp5MVgrhpDhEej7MErmtdOQFfTWMIhShAMgM8C4OQB34
 fC1Ofm8WztAAu2t1+ZQYwQ2LxK8J1EQ1vDf+9nDA50FPwopsjqnrc7fVjVRGRqu5UMKa
 BdGw==
X-Gm-Message-State: ANhLgQ32dbXYO+Q9VvhIeXUMujrKvWyDGd7PU5TWOjxHlFtG1eRivH89
 QFmMGcd+yXO5Rm1ggrgLB5KUZw==
X-Google-Smtp-Source: ADFU+vuje43aDPeznRsZPsKViQEAi62tY5I9X5ZDdMb/uob5fVBxGty2juLUBT47zDWqbaGLrY/kUg==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr224639wmc.109.1583167123402;
 Mon, 02 Mar 2020 08:38:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm30606476wrb.23.2020.03.02.08.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 08:38:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 51F691FF87;
 Mon,  2 Mar 2020 16:38:41 +0000 (GMT)
References: <20200219163537.22098-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 00/14] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200219163537.22098-1-robert.foley@linaro.org>
Date: Mon, 02 Mar 2020 16:38:41 +0000
Message-ID: <87fteq90fi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This is version 2 of the patch series to=20
> add support for aarch64 VMs.=20=20
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM
>
> V1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg01180.html
>
> Changes in version 2
> - Most changes relate to the patch: "Add workaround to consume console".
>    - We changed this patch to make it cleaner.
>    - We added a ConsoleSocket, which slots in for the current console soc=
ket
>      with the difference being that we drain this socket in the backgroun=
d on a
>      callback basis.=20=20
>    - We also made the logging of the console to file optional
>  - Relocated the log file path and name. For example:
>    ~/.cache/qemu-vm/ubuntu.aarch64.install.log=20
> - Made one fix for a hang issue we were seeing.
>   - The issue was a timing problem around a reboot where the
>      ubuntu.aarch64 script assumed the reboot guaranteed that=20
>      the next successful command would occur after the reboot.
>    - The fix is to simply make it more deterministic by shutting down the
>      VM and restarting it instead of issuing the reboot.
> - Made a few changes to CentOS VM to update its dependencies properly.
> - We made a few changes related to latin1 vs utf-8.
>   We found in some cases the latin1 is needed for chars coming out of the=
 i
>   socket which do not have a utf-8 equivalent.
>
> Robert Foley (14):
>   tests/vm: use $(PYTHON) consistently
>   tests/vm: Debug mode shows ssh output.
>   tests/vm: increased max timeout for vm boot.
>   tests/vm: give wait_ssh() option to wait for root
>   tests/vm: Added gen_cloud_init_iso() to basevm.py

For now I've pulled the first 5 patches into testing/next as they are
obvious clean-ups.

>   tests/vm: Add workaround to consume console

I still have concerns about this approach but I'm going to give it some
more testing. However I ran into problems testing on my aarch64 box
because of a missing gen-iso-image which makes me think we need to add
some gating via configure for tools and libraries we need.

>   tests/vm: Add configuration to basevm.py
>   tests/vm: Added configuration file support
>   tests/vm: add --boot-console switch
>   tests/vm: Add ability to select QEMU from current build.
>   tests/vm: allow wait_ssh() to specify command
>   tests/vm: Added a new script for ubuntu.aarch64.
>   tests/vm: Added a new script for centos.aarch64.
>   tests/vm: change scripts to use self._config
>
>  python/qemu/console_socket.py     | 162 ++++++++++++++++
>  python/qemu/machine.py            |  12 +-
>  tests/vm/Makefile.include         |  20 +-
>  tests/vm/aarch64vm.py             | 100 ++++++++++
>  tests/vm/basevm.py                | 294 +++++++++++++++++++++++++-----
>  tests/vm/centos                   |  33 +---
>  tests/vm/centos-8-aarch64.ks      |  51 ++++++
>  tests/vm/centos.aarch64           | 224 +++++++++++++++++++++++
>  tests/vm/conf_example_aarch64.yml |  51 ++++++
>  tests/vm/conf_example_x86.yml     |  50 +++++
>  tests/vm/fedora                   |  17 +-
>  tests/vm/freebsd                  |  16 +-
>  tests/vm/netbsd                   |  19 +-
>  tests/vm/openbsd                  |  17 +-
>  tests/vm/ubuntu.aarch64           | 117 ++++++++++++
>  tests/vm/ubuntu.i386              |  37 +---
>  16 files changed, 1069 insertions(+), 151 deletions(-)
>  create mode 100644 python/qemu/console_socket.py
>  create mode 100644 tests/vm/aarch64vm.py
>  create mode 100644 tests/vm/centos-8-aarch64.ks
>  create mode 100755 tests/vm/centos.aarch64
>  create mode 100644 tests/vm/conf_example_aarch64.yml
>  create mode 100644 tests/vm/conf_example_x86.yml
>  create mode 100755 tests/vm/ubuntu.aarch64


--=20
Alex Benn=C3=A9e


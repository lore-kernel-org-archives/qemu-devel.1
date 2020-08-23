Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5553C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36662072D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 10:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7StqTjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36662072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9nVx-0004qz-Rj
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 06:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nV2-0004HZ-H7
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:45:20 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:40901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9nUz-0006nd-H0
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 06:45:19 -0400
Received: by mail-ej1-x632.google.com with SMTP id o18so8291937eje.7
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=ah7k9wLlHC4XGf2283AZ0zNpAcWRa/gMkDTTA/gVMNg=;
 b=f7StqTjJ2daqiRMz3NpymVHxRstW4eTkV89VIj62nAvPyd+0MCM4K+cGh501F3/MxA
 0WEIWUYhM0b4ZMx/PZE/5884fNbu08Kc7LOdwU/3p0dOCc8iqibmsQ4c3/EmNI+LVuog
 JC7iCbAJ0sO6HFK9vkp05L/mkGSYHQXSl8uSzfNzgIBIJBsNjn1Z61AHgL91mTFSKj67
 XSH2SI1V8citiPyXz+Bc8XcNAGELebQmrWLr2yDAjD/UYd1pLvX0ONCoCpUwbhnOQc8Y
 Pv0S3BCBfnFKwoCTInnQWnjEqTxOwK9al8ezrg6gy1+vXLMr77ato4nRQtwLcyEl8ep2
 m5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ah7k9wLlHC4XGf2283AZ0zNpAcWRa/gMkDTTA/gVMNg=;
 b=TAU7U6Z8iQ6++z62JdcgMikUbgReeEPmIcsG47qxknz8634kHzGnUW6pBoJDthwesE
 lJzEhdPUeeEfI01FKdxIrdHHT/JEGZIw/2gslMsQqjGj/sSVETLh6gfrY5rFLY9KcqnN
 Jxv2Qkw7NE4nTtwyzmfiCbje5U4+rnHSkGWcysv0TMX6KU3zWWRAJQNlgtW6RPjhENfN
 5NmDEyPG/qQMU2sBYet8FyTZB7z45ly4KdbsgZI1W9H5gqHVMAuLnCvtkGkPim9tybjw
 jju8/UaUSbcDnagGl0yhgtljAIpUlHwZhtUG8AZNbw/Jvz5W+0LSnGeLpj0XwXqwh5V7
 AVwg==
X-Gm-Message-State: AOAM533g32wFcFbsT8k2n+f5Yw+mVhQr7UqmGHdx7uLttoee6A4Bxz6J
 U7ZMqT6YxEAZTAbEbDC43oLnbcvABMMozYGef/SIq279cYHDL19o
X-Google-Smtp-Source: ABdhPJwpHW/gLjgBIDqRbRI6eVwmelWNjlMpbYA38AwVEb2VekFHciyX31xliYYCieSC8BGsqA2W39Z9d1QRWj8Voe0=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr1014662ejb.4.1598179515715; 
 Sun, 23 Aug 2020 03:45:15 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 11:45:04 +0100
Message-ID: <CAFEAcA-dDW27t7VcV5D=01ckBOD5oerr1XK0an7BemORdyQHHA@mail.gmail.com>
Subject: odd meson failure: Unknown variable "exe_name"
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On my x86-64 Linux box, one of my local build trees turned out not
to work:

$ rm -rf build/x86 && mkdir build/x86 && (cd build/x86 &&
'../../configure'
'--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user'
'--enable-debug' '--cc=ccache gcc' '--audio-drv-list=pa'
'--with-pkgversion=pm215' '--enable-trace-backends=log,dtrace'
'--enable-docs')

fails with
[...]
Program keycodemapdb/tools/keymap-gen found: YES
Program scripts/decodetree.py found: YES
Program ../scripts/modules/module_block.py found: YES
Program nm found: YES
Program scripts/undefsym.sh found: YES
Program scripts/feature_to_c.sh found: YES

../../meson.build:1030:14: ERROR: Unknown variable "exe_name".

A full log can be found at
/home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt

ERROR: meson setup failed


This is the same box that's worked fine for merge testing, so
presumably something about the particular set of configure
options is tripping it up.

thanks
-- PMM


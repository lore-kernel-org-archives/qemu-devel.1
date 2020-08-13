Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46380C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA2A206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSUl9UQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA2A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63tD-0006H0-42
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s8-0004jD-7K
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:44 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:45954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s6-0008U5-DE
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:43 -0400
Received: by mail-pg1-x52a.google.com with SMTP id x6so2105180pgx.12
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yxz0Qaq8AtWOwY+U8QGeL50oM68x15zE4/mb/u2JmxM=;
 b=nSUl9UQ6D2fBmAgkjE41IS+JnJB31/alks/tKSd4wU2aeKaO/faqT9UIcI5JN4Qvyi
 /3y47bGOfD3AGWeWuCvgUAyEcneJ1gAvqed4TLRWvyKBJX6Z2oUvKcssotUc9kZAunSf
 0mqptATD6bGlSmL/U207WSIOKMypoHlOkqGo3SMWwmjbGZKVhNVnRHgcS61OUcv/JYbw
 IJAL8oySIE1pORETuVbjnSoI6jTAitQ1LiyOr6n1uNpBEkdIUVDabE/wU9W4UroEUUgM
 6TyXGV3860MNnxBnx2PDS/iEtkPVVvXmRaDQT+Yof9l0ejfFMXJrmMQGfvk5MUuuqcbr
 vkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yxz0Qaq8AtWOwY+U8QGeL50oM68x15zE4/mb/u2JmxM=;
 b=C2Jj2IeTUBq1m3OKXdiGHN/a0igIU/WYFYtrO/6b3UFDTd7AKbvMW/K3dso1pDg0Gk
 JtW8uxayVeU7RrPYaop1moPPl1a4YtMdJginIzXXNJ/ri+ZCFz/GHJ0kx1NkSDtT3VJo
 A7gQkVvE56SLCscdY4WJLTeqUeAeYz72npSEqI8Ksu6xwogxT21CREwlm0r96IUPpS9M
 Nj75Ha7B2cccvIoy+Y/OqNj4xWtNk9A6sO0AbXzFQ+9+9uk+m86lXwLmsejYCOEMRhSz
 gI9p4qx4eqae3keJ8toXt6O6lEHjfOgHzhPYVvF7XY7btlRrDGbjxgEOMzS8cvxdaLL+
 p43A==
X-Gm-Message-State: AOAM531WjDCtQAk0E+gOjd9+e0+pZSJxtHsUM9e1NtkSYft8ZJNOiWKB
 XhO18Ryfws0qJcNVtXs5rbOLqHnOHCc=
X-Google-Smtp-Source: ABdhPJzDKY8US7itIb12mgghrM90KzXvM4unJGsN9UnF42aaQYy9W2DOM7wBd/tqrrPJkVxEWcKquA==
X-Received: by 2002:a62:d10a:: with SMTP id z10mr2562130pfg.7.1597289140335;
 Wed, 12 Aug 2020 20:25:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/17] crypto/cipher: Class hierarchy cleanups
Date: Wed, 12 Aug 2020 20:25:20 -0700
Message-Id: <20200813032537.2888593-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly this is intended to cleanup the class hierarchy
used for the ciphers.  We currently have multiple levels
of dispatch, and multiple separate allocations.  The final
patches rearrange this to one level of indirect call, and
all memory allocated contiguously.

But on the way there are a number of other misc cleanups.

I know those final patches are somewhat big, but I don't
immediately see how to split them apart.

I noticed this while profiling patches to make ARM PAUTH
use the crypto subsystem.  The qcrypto_cipher_* dispatch
routines were consuming a noticeable portion of the runtime,
and with these changes they were down below 1% where they
ought to be.

While I did not continue with PAUTH using AES, I still think
these are good cleanups.


r~


Richard Henderson (17):
  crypto: Move QCryptoCipher typedef to qemu/typedefs.h
  crypto: Move QCryptoCipherDriver typedef to qemu/typedefs.h
  crypto: Assume blocksize is a power of 2
  crypto: Rename cipher include files to .inc.c
  crypto: Remove redundant includes
  crypto/nettle: Fix xts_encrypt arguments
  crypto: Use the correct const type for driver
  crypto: Allocate QCryptoCipher with the subclass
  crypto: Move cipher->driver init to qcrypto_*_cipher_ctx_new
  crypto: Constify cipher data tables
  crypto/builtin: Remove odd-sized AES block handling
  crypto/builtin: Merge qcrypto_cipher_aes_{ecb,xts}_{en,de}crypt
  crypto/builtin: Move AES_cbc_encrypt into cipher-builtin.inc.c
  crypto/builtin: Split and simplify AES_encrypt_cbc
  crypto/builtin: Split QCryptoCipherBuiltin into subclasses
  crypto/nettle: Split QCryptoCipherNettle into subclasses
  crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses

 crypto/afalgpriv.h                            |   3 +
 crypto/cipherpriv.h                           |   6 +-
 include/crypto/aes.h                          |   4 -
 include/crypto/cipher.h                       |   5 +-
 include/qemu/typedefs.h                       |   2 +
 crypto/aes.c                                  |  51 --
 crypto/cipher-afalg.c                         |  25 +-
 crypto/cipher-builtin.c                       | 532 ------------
 crypto/cipher-builtin.inc.c                   | 425 ++++++++++
 .../{cipher-gcrypt.c => cipher-gcrypt.inc.c}  | 522 ++++++------
 crypto/cipher-nettle.c                        | 733 -----------------
 crypto/cipher-nettle.inc.c                    | 756 ++++++++++++++++++
 crypto/cipher.c                               |  44 +-
 13 files changed, 1477 insertions(+), 1631 deletions(-)
 delete mode 100644 crypto/cipher-builtin.c
 create mode 100644 crypto/cipher-builtin.inc.c
 rename crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c} (51%)
 delete mode 100644 crypto/cipher-nettle.c
 create mode 100644 crypto/cipher-nettle.inc.c

-- 
2.25.1



Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF805C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF4520848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDQ1XqQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF4520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhpU-00053I-Lu
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhof-0003Xb-Lu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhod-000307-Uy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:29 -0400
Received: by mail-pg1-x536.google.com with SMTP id m34so712153pgl.11
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o+wKj1Jv8fml/03sdKVYIYEOnnCMhd3pvDGOCXnWYO8=;
 b=cDQ1XqQPoHGaRI0qavA9lB9PbfUmtXSiGwSumx1v1Gjlpof0VGOzp7oZI0ia+B0+Yn
 x8b/T39k4NO1U9RrlxE9dFL751wNUMkvQAUGH158vEE/MhUFarkquN0dJ4PZ8WxQyo5A
 zvHdxitXEzUizih5/GoYQUcau+QqAJLdOncMirI0qhRJddyxWZG6N3mT11shQhZ65L/n
 W8KI//A/mS2DMrXTnWN5gKtcA3oGPHhA+AxgTOtpIl/OznxPZjszXOb2vwcV3fVT4Scd
 AfTT2LcHicnaYrW4VbkwIsrieFfwzl56ostdzTu3n+0edXwjvT1hIxJg1lrUCH7XNbQn
 VHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o+wKj1Jv8fml/03sdKVYIYEOnnCMhd3pvDGOCXnWYO8=;
 b=XZt4xcAlOHC8aoZ21FLUIceqFxgh2Benqaq61vt+PMB66KidZYQEczB36YJ3FNwmWr
 9CccOIfdD+EGP51W1n1FRCFQHJsbPg8LIAGWcUfnyxgOMrZ9sKOoccSUfcwlqTinM5iZ
 mg41VxSzFkTIxX6jMMJE9rbkucNJVoZ7gHmKzs33j0S8JRdcfmZH8iJie2yTuUC7ZTEE
 wgdbveu1Suw0Bel60Q2nsLMUNfPxDtAoErLk4jDLu3Q0LIwHKkdvYP5Pf6XdIziq1eMx
 eh9dG1dxw9s4DkDvf5MFz5ordXTfCQzITA/X918vYYaE3IRVd3PUMwsGctkIlTuOm6r3
 12dg==
X-Gm-Message-State: AOAM531Wdz37m/9r+T3vxTiaHMk+T1Jc5GHVoKM9cmdSgefmtZ8xTfFm
 t7uFkHp+tjz0h4sa29q1aF9XmoTFQuLDjw==
X-Google-Smtp-Source: ABdhPJzipkwevFDC0UUInWR5bFM2NGvtiTqlu5YiG9iCbBDye6wDU79YkKpYjxdTQCsi14klHXMQag==
X-Received: by 2002:a63:b24b:: with SMTP id t11mr1742974pgo.233.1598634325641; 
 Fri, 28 Aug 2020 10:05:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/16] crypto/cipher: Class hierarchy cleanups
Date: Fri, 28 Aug 2020 10:05:07 -0700
Message-Id: <20200828170523.418603-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Changes in v2:
  * Dropped move of QCryptoCipher typedef.
  * Moved QCryptoCipherDriver typedef to include/crypto/cipher.h.
  * Renamed included files to *.c.inc.
  * Fixed errors with old versions of nettle and gcrypt.

Based-on: <20200828132716.279782-1-berrange@redhat.com>
("crypto: fix build with gcrypt")

which does at least allow *-softmmu builds to complete,
though I still have issues with *-linux-user.


r~


Richard Henderson (16):
  crypto: Assume blocksize is a power of 2
  crypto: Rename cipher include files to .c.inc
  crypto: Remove redundant includes
  crypto/nettle: Fix xts_encrypt arguments
  crypto: Move QCryptoCipherDriver typedef to crypto/cipher.h
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
 include/crypto/cipher.h                       |   4 +-
 crypto/aes.c                                  |  51 --
 crypto/cipher-afalg.c                         |  25 +-
 crypto/cipher-builtin.c                       | 532 ------------
 crypto/cipher-nettle.c                        | 733 -----------------
 crypto/cipher.c                               |  44 +-
 crypto/cipher-builtin.c.inc                   | 435 ++++++++++
 .../{cipher-gcrypt.c => cipher-gcrypt.c.inc}  | 509 ++++++------
 crypto/cipher-nettle.c.inc                    | 760 ++++++++++++++++++
 12 files changed, 1481 insertions(+), 1625 deletions(-)
 delete mode 100644 crypto/cipher-builtin.c
 delete mode 100644 crypto/cipher-nettle.c
 create mode 100644 crypto/cipher-builtin.c.inc
 rename crypto/{cipher-gcrypt.c => cipher-gcrypt.c.inc} (52%)
 create mode 100644 crypto/cipher-nettle.c.inc

-- 
2.25.1



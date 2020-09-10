Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC9C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F08620BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOhB0A1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F08620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJUK-0001bP-40
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTM-0008U4-7R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJTI-0007fe-U8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599732387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P1xB4DDbnDfGlhd8pkFVBNq9oaUwL2IbIXXaBpW4puE=;
 b=GOhB0A1uHa4Sywinw3sEV9Byk74mvWNUGxTNwgUpEJHYO6qBx+TgmA/5RqfF3Umt5nFYws
 NXv6GYKAld7B8/mUd2PCXBO465LZK4zucRUgyh0N5u1xS3ChYy+0g1dQtGmKgZiVoN7h0W
 4SJt+XMEtf55RRWq8/4sWNyYa97yr40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-jiwc_VuENqyMCDmNu_tO3A-1; Thu, 10 Sep 2020 06:06:25 -0400
X-MC-Unique: jiwc_VuENqyMCDmNu_tO3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F38F08018A1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:06:24 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-112-4.ams2.redhat.com
 [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 434861002D5C;
 Thu, 10 Sep 2020 10:06:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Crypto next patches
Date: Thu, 10 Sep 2020 11:06:06 +0100
Message-Id: <20200910100623.1088965-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pu=
ll=3D=0D
-request' into staging (2020-09-08 21:21:13 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/berrange/qemu tags/crypt-perf-pull-request=0D
=0D
for you to fetch changes up to 1b010d9339497b081c3b8ab4f98b2a21f2cae08d:=0D
=0D
  crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses (2020-09-10 11:0=
2:=3D=0D
23 +0100)=0D
=0D
----------------------------------------------------------------=0D
Improve performance of crypto cipher subsystem=0D
=0D
----------------------------------------------------------------=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (1):=0D
  tests: fix output message formatting for crypto benchmarks=0D
=0D
Richard Henderson (16):=0D
  crypto: Assume blocksize is a power of 2=0D
  crypto: Rename cipher include files to .c.inc=0D
  crypto: Remove redundant includes=0D
  crypto/nettle: Fix xts_encrypt arguments=0D
  crypto: Move QCryptoCipherDriver typedef to crypto/cipher.h=0D
  crypto: Use the correct const type for driver=0D
  crypto: Allocate QCryptoCipher with the subclass=0D
  crypto: Move cipher->driver init to qcrypto_*_cipher_ctx_new=0D
  crypto: Constify cipher data tables=0D
  crypto/builtin: Remove odd-sized AES block handling=0D
  crypto/builtin: Merge qcrypto_cipher_aes_{ecb,xts}_{en,de}crypt=0D
  crypto/builtin: Move AES_cbc_encrypt into cipher-builtin.inc.c=0D
  crypto/builtin: Split and simplify AES_encrypt_cbc=0D
  crypto/builtin: Split QCryptoCipherBuiltin into subclasses=0D
  crypto/nettle: Split QCryptoCipherNettle into subclasses=0D
  crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses=0D
=0D
 crypto/aes.c                                  |  51 --=0D
 crypto/afalgpriv.h                            |   3 +=0D
 crypto/cipher-afalg.c                         |  25 +-=0D
 crypto/cipher-builtin.c                       | 532 ------------=0D
 crypto/cipher-builtin.c.inc                   | 435 ++++++++++=0D
 .../{cipher-gcrypt.c =3D3D> cipher-gcrypt.c.inc}  | 503 ++++++------=0D
 crypto/cipher-nettle.c                        | 733 -----------------=0D
 crypto/cipher-nettle.c.inc                    | 760 ++++++++++++++++++=0D
 crypto/cipher.c                               |  44 +-=0D
 crypto/cipherpriv.h                           |   6 +-=0D
 include/crypto/aes.h                          |   4 -=0D
 include/crypto/cipher.h                       |   4 +-=0D
 tests/benchmark-crypto-cipher.c               |  12 +-=0D
 tests/benchmark-crypto-hash.c                 |   4 +-=0D
 tests/benchmark-crypto-hmac.c                 |   7 +-=0D
 15 files changed, 1492 insertions(+), 1631 deletions(-)=0D
 delete mode 100644 crypto/cipher-builtin.c=0D
 create mode 100644 crypto/cipher-builtin.c.inc=0D
 rename crypto/{cipher-gcrypt.c =3D3D> cipher-gcrypt.c.inc} (52%)=0D
 delete mode 100644 crypto/cipher-nettle.c=0D
 create mode 100644 crypto/cipher-nettle.c.inc=0D
=0D
--=3D20=0D
2.26.2=0D
=0D



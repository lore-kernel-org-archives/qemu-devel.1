Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A5BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899D5205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhGSs6hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899D5205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46052 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJNOQ-0001i6-Hg
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 15:17:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJNEd-0001iK-4d
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJNEb-0001ij-V8
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:07:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJNEb-0001hN-KB
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 15:07:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id k19so9848932pgh.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=sSm6UX0R52w8vBHy4v0QRMxvKsGbXKFYR5kOUYsNw4o=;
	b=XhGSs6huRSNQ0c8hS83vp40EA3+vraLPOpg4dD4/IZZFpF8d/0ceiHbO4gyIce1z1V
	cpMBPkjFvwHc1oPyzcqcMilfts/Krdeu1c+KQklTT6bMcEJEdouQC4GMxz8kLt8FBelV
	EB9jB4tbOqMbhBE+Uf3t4ZSYmDL9ugWsQrs9E+quR6vG0o400wxPDyQStTEdourJTrXE
	8wvLPVMMMvZoiYGaPAFeacdlvvYXqcequDbZsfUFDlhZk22+WlUpZ1uLnoUl2xQ/RDi8
	uN7cG0/Ul/vNmMFbV4ulYojDOp1D/IhL2AJzSe/QXY0Nx1kBuyJRv9QvBMbM41z1BwHH
	f9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=sSm6UX0R52w8vBHy4v0QRMxvKsGbXKFYR5kOUYsNw4o=;
	b=bZ6U/DuEDtRSNcrkBFBdAZPvWVIj/50f71fQ/ykTx9j9rvp71vF2SsPVW3kbEXTf4Y
	CuvUFTPDfek1+bW8kk5h/ZsqAnFUHaCo/PTUnEZ2qUqa+R0XJ4TRuPWLfV4nsXcotZ+n
	G/hYazc+n7QfV3ayyI3zm7TN/06GdA3L9OpSuTw1V6eT8NSJ3D5Z7xLnpwlkE2wHguMQ
	QNQk4L0HW7hWyflhZbbmqBBT+P5jHkuY/BSVlTh+h5Zw58mcEvuOvOANSJF79MMiFOhh
	1uTH6dsCdEvxyrs7CR4XaFEeNkKdYDvwfTzBxCBFraBXoF1l2FWKARwIswfSjtDol5lK
	iJvg==
X-Gm-Message-State: APjAAAVKCUrmbYfIj2Pey23c2Qg6dxZndfQ/Jqp+ZId/y8Uthw+fMUTh
	ieqCs0vQBmidbBDGyzUOpi6k+NNhqs0=
X-Google-Smtp-Source: APXvYqyWEf8N47LQsVZCvZAlzleRvZjogAVLG/xskfObYv9kxSccTYPAYhPCSOpQVsyQfX8BwhhBXA==
X-Received: by 2002:a63:c605:: with SMTP id w5mr31599165pgg.355.1556132827966; 
	Wed, 24 Apr 2019 12:07:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147])
	by smtp.gmail.com with ESMTPSA id 8sm30761011pfs.50.2019.04.24.12.07.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 12:07:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 12:07:04 -0700
Message-Id: <20190424190705.12392-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 0/1] util/path: Do not cache all filenames
 at startup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: philmd@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424190704.-uZxb_lwnQqbddp9dUT0yDXPgkiDHxLpFOvPwRcPAtM@z>

Changes for v2:

Drop use of g_canonicalize_filename.

While Daniel pointed out how to add stuff to glib-compat.h,
full canonicalization is overkill for path() in any case.
I also discovered that I'd been testing w/ glib 2.56 and so
hadn't been testing the g_canonicalize_filename case anyway.

Cover from v1:

This is a third variant attempting to fix the problem of
the -L interp_prefix handling not coping well pointing to
a full chroot.

Previous versions include:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06592.html
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07304.html

Both of the other versions keep an open file descriptor to
the directory that is interp_prefix.  While this seems to be
efficient, they also leak a file descriptor into the guest.
This has follow-on effects on the emulation, causing failures
e.g. within the LTP testsuite.

This version uses only string manipulation and access(2).

A plausible criticism of this is the mutex and the cache.
Are they really needed?  I have no idea.  I can imagine
removing that is actually more efficient, not needing a
lock around a shared data structure.


r~


Richard Henderson (1):
  util/path: Do not cache all filenames at startup

 util/path.c | 201 ++++++++++++----------------------------------------
 1 file changed, 47 insertions(+), 154 deletions(-)

-- 
2.17.1



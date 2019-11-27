Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443212075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 04:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="U1VBhXqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443212075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZoqO-0001MA-Am
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 23:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1iZopA-0000Rh-2i
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1iZop6-0002Fk-6d
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:21:06 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31]:37746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1iZop5-0002Em-2M
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 23:21:04 -0500
Received: by mail-yb1-xb31.google.com with SMTP id q7so8539269ybk.4
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 20:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=9uCjUX17RwTpxBDMtbNLOpvkKBrSedOS2hRwHBDHKrk=;
 b=U1VBhXqP/440hG2wsb+SehvMiHJMgyZyvW/qsVe1q4zpi3cMDUyvIQwx0nJponGAXj
 82JYIAXPu0KIGI0rbd4u5XkVJZlmLJM/jB/OZRL8TuQXkf4va2WkQvBhaRQZWLW4x9jU
 r3P13/+VGgvF/Y/lUiEVBeAyVpasv/ugJ3USg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=9uCjUX17RwTpxBDMtbNLOpvkKBrSedOS2hRwHBDHKrk=;
 b=MeDkg/BhTPfSsxDd59QO+y9gvg0svrHa+ZWVXFG3m4p9tqh9sSnqZbz9m/XaAFD/ye
 kHNgtfhnL8KdIIO4DefYFcOvJbeUD9gb1LCfdTBcTKUgD6resEq9Loo0JkaPo+BVPMry
 jQm1YZX4Mx9IjdVjxruR5a8Sm3nIIY+GLIXZwGCrWubvsPBGKXZMp6/W7GSJq12qkMDv
 sxFH8z+oqZVZ/eLgctk+1Uh3YD+c4OKknJRXaLu82qkzgZRfRwK6/OL3gi6Tp1Z4xiRd
 R6BzXvsVpJvs3HmwPxbIlMyLRe5Di9OuS1p7V/zSXNV16fGjPK3hY8YyfRnsl6W8qPTy
 Xb0w==
X-Gm-Message-State: APjAAAX3Yubs7CNDSUZSIIlxnhosI3Hyq56MKXmCzVm/iqks71IUE0o1
 qMP/fet71k966Oy0n6Hv944x6Akpx85WAycKSua1yZeZVcw=
X-Google-Smtp-Source: APXvYqzunGPoa83mRF9g0Hf7forXe9icJb2tRKSKvK+sJ/XH1s+G9N9gCRYnyqZFoqkZ2uTlOXiJdSZYea2nUhybEdQ=
X-Received: by 2002:a25:dfcb:: with SMTP id w194mr30426424ybg.79.1574828460797; 
 Tue, 26 Nov 2019 20:21:00 -0800 (PST)
MIME-Version: 1.0
From: Daniel Cho <danielcho@qnap.com>
Date: Wed, 27 Nov 2019 12:20:44 +0800
Message-ID: <CA+XQNE4eP8tfHB5eV8813bqaE+L5yooBDFCdbMWJPysvev4UKg@mail.gmail.com>
Subject: Network connection with COLO VM
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fd140a05984c52cb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b31
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

--000000000000fd140a05984c52cb
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

Could we ssh to colo VM (means PVM & SVM are starting)?

SSH will connect to colo VM for a while, but it will disconnect with error
*client_loop: send disconnect: Broken pipe*

It seems to colo VM could not keep network session.

Does it be a known issue?

Best Regard,
Daniel Cho

--000000000000fd140a05984c52cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello everyone,=C2=A0<div><br></div><div>Could we ssh to c=
olo VM (means PVM &amp; SVM are starting)?</div><div><br></div><div>SSH wil=
l connect to colo VM for a while, but it will disconnect with error</div><d=
iv><b>client_loop: send disconnect: Broken pipe</b><br></div><div><b><br></=
b></div><div>It seems to colo VM could not keep network session.</div><div>=
<b><br></b></div><div>Does it be a known issue?</div><div><br></div><div>Be=
st Regard,=C2=A0</div><div>Daniel Cho=C2=A0</div></div>

--000000000000fd140a05984c52cb--


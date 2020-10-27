Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42503C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A36206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="WPD7uY5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A36206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHaw-0002Fb-78
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kXHZc-0001lr-Em
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:31:08 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:24951
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kXHZY-0003pq-9C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:31:08 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4CL0hK63bPz8PbN
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 01:32:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=date:from
 :to:subject:message-id:mime-version:content-type
 :content-transfer-encoding; s=default; bh=YBKfFaBgkNIF1SojpPejir
 vg25c=; b=WPD7uY5sjMKhcfJ/9RcBGVyHW/m7kNKkLfG3tDGLy8lqMyI4wpov0B
 xIMflZT6RfCrV2ZlDyxBiyLug7ha9/XDKHnUUH6k1HJa49c9XUidrN24KdkN7Zv4
 cEMWSupd1j3ZpyLi8CjcQw+sWIJshPkeWasWsfoh50UKgK6uZlmt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :subject:message-id:mime-version:content-type
 :content-transfer-encoding; q=dns; s=default; b=ovS08FLxBxtKib+m
 rDt8rfENmV8Bmx7z9AMNPi23+/dj93KeurqFbxWY3knjvJcvKtaAGltF/fVxmkE6
 UhMp5fCYLKRhWRAuPBZY/Zk2AErAHVpAXxZW0R4Ty4Ws1qmU+TB6aZ2eSzUcc+oj
 5fez20S/qKG/2OzkYew8yEdbWyg=
Received: from humpty.home.comstyle.com (unknown [142.114.120.158])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4CL0hK5l7yz8PbK
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 01:32:17 -0400 (EDT)
Date: Tue, 27 Oct 2020 01:30:48 -0400
From: Brad Smith <brad@comstyle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/vm: update openbsd to release 6.8
Message-ID: <20201027053048.GB64546@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

tests/vm: update openbsd to release 6.8

A double dash at the end of a package name removes ambiguity
when the intent is to install a non-FLAVORed package.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 8356646f21..5ffa4f1b37 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
     name =3D "openbsd"
     arch =3D "x86_64"
=20
-    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.is=
o"
-    csum =3D "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9=
436ee3"
+    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.8/amd64/install68.is=
o"
+    csum =3D "47e291fcc2d0c1a8ae0b66329f040b33af755b6adbd21739e20bb5ad56=
f62b6c"
     size =3D "20G"
     pkgs =3D [
         # tools
@@ -36,10 +36,10 @@ class OpenBSDVM(basevm.BaseVM):
         "bash",
         "gmake",
         "gsed",
-        "gettext",
+        "gettext-tools",
=20
         # libs: usb
-        "libusb1",
+        "libusb1--",
=20
         # libs: crypto
         "gnutls",


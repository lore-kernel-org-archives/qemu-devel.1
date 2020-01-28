Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CDAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58BE22522
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O25m5Y4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58BE22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVFl-0005Q7-TW
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3z-00067b-6t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV3y-0007lh-2J
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:11 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV3x-0007jL-Ob
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:54:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id c9so17098217wrw.8
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wXiZrjjqKKBi2hoZC6WKgVZwTnWnq73WbeIvPc+qq/4=;
 b=O25m5Y4uoTD7d+zEwTlE331n1jKq9uwEzD+USodT87J+WVws5iIfnB8o0hgQ+CKFK4
 GwVEyFG03IaZkbUCoD0CpMUdDCAx6oVeE2W6VZhLhyJfD6RYrc9dPn+0ZgsqWRcafupO
 mA0nwwtB6AEHnE00h910W7dqravqgqw8dpbOxTR8zLTR0cJsPeJVmGsHDC3o9x/u39U8
 URdcVL13nymlwN5aBvpSE8UKwxhf9uDBCKOWciUVddyAvWGm3KZnY5lyJgtjVBke0ylj
 vNCzOl0kI8STWjIE5BIabW6bfOqv0PdFGU7uEkG24ifKvKkoxTrg14ZQs1od5lvRNiE8
 VKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wXiZrjjqKKBi2hoZC6WKgVZwTnWnq73WbeIvPc+qq/4=;
 b=Qzg37XDPGrj5q8bNVdog4Z03kG6eAj8q3CVxvB//3e5glzMLJiDvhyR1RhebYSJCiC
 pnkERPIxcuZHXq4iJke0WdPNGlnvbT5ViTymkrHST3+d0qbZKh+IBH7CoXzoXSQZfRh4
 GDgppG3HffzmvDnJRHrY2fRsNWvfU1+oPh/29emuyC7z7Czh154zMZsRW96/mL7I9asn
 cnJl3iW16x06artpT6RN1kp3BlQL1bFZ6holFNIq1hWJrF/qf4OmfgiHCsmc5ViRojF7
 hZx1GXaCYhwiXium2t9Fq1dW/Re57VSgqoSePQVMITGLzjXK+A0sKMu5mqiQ6N2ouTdN
 RMXg==
X-Gm-Message-State: APjAAAUtC7bSGqAXw0Hx2Hq8s1F16NppsY9dlmxU0VR4p7nW0AwQ29sw
 zOen9Hef+sFKleRYed3bKX+1kKYM
X-Google-Smtp-Source: APXvYqxM817iq2z2x/lMG/PLSWWkCZG7l8NUTbmKZFJdMiTT2tUJbroqllwrVqqhca/dXY58syf8Fw==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29044025wro.51.1580234048605; 
 Tue, 28 Jan 2020 09:54:08 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:54:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 008/142] configure: generate Meson cross file
Date: Tue, 28 Jan 2020 18:51:28 +0100
Message-Id: <20200128175342.9066-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/configure b/configure
index e3533b3290..cdc71631e0 100755
--- a/configure
+++ b/configure
@@ -8035,6 +8035,46 @@ echo "# Automatically generated by configure - do not modify" > "$iotests_common
 echo >> "$iotests_common_env"
 echo "export PYTHON='$python'" >> "$iotests_common_env"
 
+cross="config-meson.cross"
+cross_arg=
+
+if test -n "$cross_prefix"; then
+    echo "# Automatically generated by configure - do not modify" > $cross
+    echo "[binaries]" >> $cross
+    echo "c = '$cc'" >> $cross
+    echo "cpp = '$cxx'" >> $cross
+    echo "ar = '$ar'" >> $cross
+    echo "nm = '$nm'" >> $cross
+    echo "pkgconfig = '$pkg_config_exe'" >> $cross
+    echo "ranlib = '$ranlib'" >> $cross
+    echo "strip = '$strip'" >> $cross
+    echo "windres = '$windres'" >> $cross
+
+    echo "[properties]" >> $cross
+    echo "root = '$prefix'" >> $cross
+
+    echo "[host_machine]" >> $cross
+if test "$mingw32" = "yes" ; then
+    echo "system = 'windows'" >> $cross
+fi
+case "$ARCH" in
+    i386|x86_64)
+        echo "cpu_family = 'x86'" >> $cross
+        ;;
+    *)
+        echo "cpu_family = '$ARCH'" >> $cross
+        ;;
+esac
+    echo "cpu = '$cpu'" >> $cross
+if test "$bigendian" = "yes" ; then
+    echo "endian = 'big'" >> $cross
+else
+    echo "endian = 'little'" >> $cross
+fi
+
+    cross_arg="--cross-file=$cross"
+fi
+
 rm -rf meson-private meson-info meson-logs
 NINJA=$PWD/ninjatool $python $meson setup \
 	--prefix "$prefix" \
@@ -8048,6 +8088,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	--localstatedir "$local_statedir" \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
+        $cross_arg \
 	"$PWD" "$source_path"
 
 if test "$?" -ne 0 ; then
-- 
2.21.0




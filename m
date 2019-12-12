Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C4AC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDE32173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6g1EUEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDE32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifO8i-00078J-Ve
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxr-0002hl-QS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNxq-0005k9-OG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:07 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNxq-0005iA-HN
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:53:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so2382306wmf.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5YKl/o+m9GbbKn5dSPHFmGa3ModS1EkXzWqXYztB4ug=;
 b=j6g1EUEjaNfxayYVz9Jva5wqgy/QfZ7PvA9ndjOtI8f9SFI1MMDaHGiwAjiTosC0dk
 O1QfalBPlTuRQ7CvpJAx1PGLvkzBs/htlWUS6b6uHbiICpEc9Er7+Yjs8H1E44Kh7fML
 jzPsZDVyxKboE7KhFqd+/6TXNqxnHI+39axR6Ds9YVXGW+eZSYry8gk8lmki/SzgafF7
 DOrjKBdTb5jzb5kZ1X5BgNQH4rqbjp1IAEEuT/bjjK76geeqOnJdSR5yya8tCAVlm7rE
 HrckiWq42u2dEkQPxpxFr4UAnfPmeF8eSRupW3zm/Ijz50MAQuO2/Vqe/j6DNwgHGhNH
 F1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5YKl/o+m9GbbKn5dSPHFmGa3ModS1EkXzWqXYztB4ug=;
 b=uOTr9sczhNsh/fAGQnPrQN/6qqLNWtO7fIEwrU8KWkVnMYszepuM6EtkRzWoXPWT4k
 Lh6X9qdAgUzPjNOf075nbjHblyk1tY8I/Td8FYKJRKP00xTWRrWM4xKmhTe6FKjcUN9p
 3FDFAZfJJ8/so73/X3H5w9mEVYTaTjM0dtjWeLFSaFyTfF07KbK36RixjdW3N10aW/5b
 ZPKu/pg31T4HMlikALS8H8PW6HnmnQUGJnW7CVHUpewR89vA5kTG4KHrV0ivSRq0345T
 9U0GdQ0TQneM/1F+DGbge9/bo8SwdiUN+NIo7JGBYRDi32swb6T7T3Q1AxsbvJ99Vv8v
 u7Ww==
X-Gm-Message-State: APjAAAVqRjuoQK8b15WJQYzAyfLF0Gb5/6nyldqxEsWxNVAL4SVjVAwe
 s3+unVxgWaWfuqRxFx0VumNpDOYO
X-Google-Smtp-Source: APXvYqw0nLEfQupoh9Ri7KceYGuXe14KPiycUmMGx0F0Rd0noxoK3d4XVBEs/V0QW02zO9GgwhfmvA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr6606036wmi.149.1576155185278; 
 Thu, 12 Dec 2019 04:53:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.53.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:53:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 007/132] meson: enable pie
Date: Thu, 12 Dec 2019 13:50:51 +0100
Message-Id: <1576155176-2464-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 0eb3d70..80055f1 100755
--- a/configure
+++ b/configure
@@ -2075,7 +2075,6 @@ int main(void) { return tls_var; }
 EOF
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
-    LDFLAGS="-pie $LDFLAGS"
     pie="yes"
     if compile_prog "" "-Wl,-z,relro -Wl,-z,now" ; then
       LDFLAGS="-Wl,-z,relro -Wl,-z,now $LDFLAGS"
@@ -7942,6 +7941,7 @@ NINJA=$PWD/ninjatool $python $meson setup \
 	--localstatedir "$local_statedir" \
 	$(test "$strip_opt" = yes && echo --strip) \
 	--buildtype $(if test "$debug" = yes; then echo debug; else echo debugoptimized; fi) \
+        -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         $cross_arg \
 	"$PWD" "$source_path"
 
-- 
1.8.3.1




Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E68C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53B1208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRlOOJu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53B1208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSof-0005wX-2Z
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0003u8-9A
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmP-0001dY-IW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:07 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmO-0001c0-RN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:04 -0400
Received: by mail-yb1-xb44.google.com with SMTP id d2so7077574ybh.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E+nG+A7eIMJ+oEMZ98jk8lnEytaL2DnbYAnCvuy+ey8=;
 b=tRlOOJu/44ZdoANgiGx9LaHAYE+sQ6IlK4nos+/S+iriipl1VVZAxp69FMe8N7Xsn4
 skvNznWNlKeBFNjgmZFP6g+i/XWjDhm0wkHHs4HFqxcnVinR2Cme9NVt8XksfACINudD
 r0HNmTw+wUPeeahIjl7Jlga/mowljVStdbMjKsV0D8oRlDkLRjwgqy1fE5hCr2DZGYja
 7VPMVciQ75wND2JneK95srUXFL3PsrMl3+uhsm4FYoOaFvDfQnDa3py59fuUuJhfILYc
 HroesAq6x61Dvej0sdMGtxAXAzJldq9D1vLhUwD9Pd+qYztGzIAcod2DsGvpYCJq3poM
 2Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E+nG+A7eIMJ+oEMZ98jk8lnEytaL2DnbYAnCvuy+ey8=;
 b=hbz0Sn9B4012Pe3rCWglQ61HO9Mf5Wgu8CSVYUUWdS08YM2LUWyjy4V+htRzQaz2Iu
 lJmBS9Vkbj33LsXvMYmpdhE2djiSMDA0scekAo9l0dcWP30rIymuu3JS5fRgGYQeTyaj
 I44EZfed3v8dsS5AinqpxYE0IYpeNrEDCRSntVIiE+DyMVWgI+GZImn9np15gOGi3JgF
 WNsN/aylFaB0KnalEv5r1cQae0Idd6qLGmY2Ypl3UGAHNQPT5qKLVDeB0MfuQS6QH4Ql
 7DajY2l7Wb3Y+UWwOqnlP0FwbwNrxfC71So6GNXhSOsro1WMwigI9e2H1LzA7X0uxn45
 7ZsQ==
X-Gm-Message-State: APjAAAWrS90tdIT11qY0kJWcUotVrIgUx7S+4Xx8jThrZEsVp0xTEVKo
 HdYW3JRxVOwvPXg5JzMh/Wy/8/Io
X-Google-Smtp-Source: APXvYqxM9T5OCojbabYUp4yv5z8fLTBG83tyvLnCZ8JO27X11qtMLWxRMVStWUqA10Gyi1eIz+hBIg==
X-Received: by 2002:a25:4d5:: with SMTP id 204mr21735719ybe.112.1560920703342; 
 Tue, 18 Jun 2019 22:05:03 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:02 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:41 -0400
Message-Id: <20190619050447.22201-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU RFC PATCH v1 1/7] risugen_common: add insnv,
 randint_constr, rand_fill
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add three common utility functions:

- insnv allows emitting variable-length instructions in little-endian
  or big-endian byte order; it subsumes functionality of former
  insn16() and insn32() functions.

- randint_constr allows generating random integers according to
  several constraints passed as arguments.

- rand_fill uses randint_constr to fill a given hash with
  (optionally constrained) random values.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen_common.pm | 101 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 6 deletions(-)

diff --git a/risugen_common.pm b/risugen_common.pm
index 71ee996..98b9170 100644
--- a/risugen_common.pm
+++ b/risugen_common.pm
@@ -23,7 +23,8 @@ BEGIN {
     require Exporter;
 
     our @ISA = qw(Exporter);
-    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16 $bytecount
+    our @EXPORT = qw(open_bin close_bin set_endian insn32 insn16
+                   $bytecount insnv randint_constr rand_fill
                    progress_start progress_update progress_end
                    eval_with_fields is_pow_of_2 sextract ctz
                    dump_insn_details);
@@ -37,7 +38,7 @@ my $bigendian = 0;
 # (default is little endian, 0).
 sub set_endian
 {
-    $bigendian = @_;
+    ($bigendian) = @_;
 }
 
 sub open_bin
@@ -52,18 +53,106 @@ sub close_bin
     close(BIN) or die "can't close output file: $!";
 }
 
+sub insnv(%)
+{
+    my (%args) = @_;
+
+    # Default to big-endian order, so that the instruction bytes are
+    # emitted in the same order as they are written in the
+    # configuration file.
+    $args{bigendian} = 1 unless defined $args{bigendian};
+
+    while (0 < $args{len}) {
+        my $format;
+        my $len;
+
+        if ($args{len} >= 8) {
+            $format = "Q";
+            $len = 8;
+        } elsif ($args{len} >= 4) {
+            $format = "L";
+            $len = 4;
+        } elsif ($args{len} >= 2) {
+            $format = "S";
+            $len = 2;
+        } else {
+            $format = "C";
+            $len = 1;
+        }
+
+        $format .= ($args{bigendian} ? ">" : "<") if $len > 1;
+
+        my $bitlen = 8 * $len;
+        my $bitmask = (1 << $bitlen) - 1;
+        my $value = ($args{bigendian}
+                     ? ($args{value} >> (8 * $args{len} - $bitlen))
+                     : $args{value});
+
+        print BIN pack($format, $value & $bitmask);
+        $bytecount += $len;
+
+        $args{len} -= $len;
+        $args{value} >>= $bitlen unless $args{bigendian};
+    }
+}
+
 sub insn32($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "N" : "V", $insn);
-    $bytecount += 4;
+    insnv(value => $insn, len => 4, bigendian => $bigendian);
 }
 
 sub insn16($)
 {
     my ($insn) = @_;
-    print BIN pack($bigendian ? "n" : "v", $insn);
-    $bytecount += 2;
+    insnv(value => $insn, len => 2, bigendian => $bigendian);
+}
+
+sub randint_constr(%)
+{
+    my (%args) = @_;
+    my $bitlen = $args{bitlen};
+    my $halfrange = 1 << ($bitlen - 1);
+
+    while (1) {
+        my $value = int(rand(2 * $halfrange));
+        $value -= $halfrange if defined $args{signed} && $args{signed};
+        $value &= ~$args{fixedbitmask} if defined $args{fixedbitmask};
+        $value |= $args{fixedbits} if defined $args{fixedbits};
+
+        if (defined $args{constraint}) {
+            if (!($args{constraint} >> 63)) {
+                $value = $args{constraint};
+            } elsif ($value == ~$args{constraint}) {
+                next;
+            }
+        }
+
+        return $value;
+    }
+}
+
+sub rand_fill($$)
+{
+    my ($target, $constraints) = @_;
+
+    for (keys %{$target}) {
+        my %args = (bitlen => $target->{$_}{bitlen});
+
+        $args{fixedbits} = $target->{$_}{fixedbits}
+            if defined $target->{$_}{fixedbits};
+        $args{fixedbitmask} = $target->{$_}{fixedbitmask}
+            if defined $target->{$_}{fixedbitmask};
+        $args{signed} = $target->{$_}{signed}
+            if defined $target->{$_}{signed};
+
+        $args{constraint} = $constraints->{$_}
+            if defined $constraints->{$_};
+
+        $target->{$_} = randint_constr(%args);
+    }
+
+    return $target;
 }
 
 # Progress bar implementation
-- 
2.20.1



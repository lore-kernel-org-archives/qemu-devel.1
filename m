Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997A8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5555C255C5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV8c0Yn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5555C255C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxZa-00026R-Hn
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxYx-0001fY-UW
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:27:24 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxYu-0006ma-Kb
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 13:27:22 -0400
Received: by mail-ej1-x642.google.com with SMTP id n26so3465906ejx.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4Xe4VHuWZ2LZL1tlis9XbpP+8r2M+56JggY5qFdnH4w=;
 b=VV8c0Yn9v6N5PTSPW78XXZ+XEM4JeqTzWBIgjefbUxsUPQ5qarenNq0CB7mldIdwqx
 Gj2wUN/eTzk6U1QOQfqmGZgj9xvrQQU57ohqfu6udJCW0JYZtCgsRqGxWgRvc9epsqAA
 CZgbtOD6KlOStnRkzotJxh3N5Fr+TvkU+s10Pm1cWTFB6DQGH2O7alDl1LVkkPRyQRZT
 3QoU9waDZUDsUsyE/P7MEYaJxVk+twCXxtoKpm2c9R6l43qTaIKXvysAWTg/SNPpUZij
 RS7iznPjMKNtSe6NluverUNLRtDOdLeaTsthSqytnX1JCyj1HXMCG7qQEEBLJrYAnvpY
 XBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4Xe4VHuWZ2LZL1tlis9XbpP+8r2M+56JggY5qFdnH4w=;
 b=aagdMaF2E02jLArXNoOSAPGbV3JXDRB4yo83XHiqPEMerCdm4EbYtnaVwfOIB+onTI
 7nNJJkizeHoTo/I5kYo3ojetykoCp5fkJzyNAJbsOrJE7hQDMrM2wwiB1CQSnzo+qUHh
 F9FXAZgn3obYzqAMnwP5G53e3ra6Ks1aTJk9exCOk0nQq2/Z+rw2yQECBfwsUQZscua9
 rWENiLZwfgooF7XawtOeycP2QnsDIMe0giRrBJvwaNC0vQ4AdoqD5HM6UQTN4HQJENw2
 qrPZrZJW83G4POfjlvALz3ByD0IjvxIo07hOevPvGO7TTkCNHRvejQzYI6uCddGBbQrp
 Ml+A==
X-Gm-Message-State: AOAM530aZLeDXINBy1tTtph7QDjELacuNGeDHqfredyamP/nBYnvAIjr
 E1zeKxzgCyNF8Qv9U3L/c9/DKrtnmPw=
X-Google-Smtp-Source: ABdhPJzwkvVtlci4EzGm+oc9BzItaUWdb3YY/zAsyMdgb/9B3R7wShSCtZ6lu6lQ8vBpLu45l6JfQA==
X-Received: by 2002:a17:906:7253:: with SMTP id
 n19mr15444846ejk.31.1593451638874; 
 Mon, 29 Jun 2020 10:27:18 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o17sm190196ejb.105.2020.06.29.10.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 10:27:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore invalid
 emails
Date: Mon, 29 Jun 2020 19:27:16 +0200
Message-Id: <20200629172716.20781-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometime emails get rejected and 'bounce'. It might take time
between we report that, a patch is posted, reviewed, merged...

To reduce time spent looking at bouncing emails in one mailbox,
add the feature to simply ignore broken email addresses. The
format is similar to the '.mailmap' file. Add an email address
in your local '.ignoredmailmap. and get_maintainer.pl won't
list it anymore.

This is particularly useful when git-send-email is used with
the --cc-cmd argument, like suggested in QEMU wiki:
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/get_maintainer.pl | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 271f5ff42a..7f7a4ff3ef 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -38,6 +38,7 @@
 my $interactive = 0;
 my $email_remove_duplicates = 1;
 my $email_use_mailmap = 1;
+my $email_use_ignoredmailmap = 1;
 my $output_multiline = 1;
 my $output_separator = ", ";
 my $output_roles = 0;
@@ -365,6 +366,51 @@ sub read_mailmap {
     close($mailmap_file);
 }
 
+my $ignoredmailmap;
+
+read_ignoredmailmap();
+
+sub read_ignoredmailmap {
+    $ignoredmailmap = {
+	names => {},
+	addresses => {}
+    };
+
+    return if (!$email_use_ignoredmailmap || !(-f "${lk_path}.ignoredmailmap"));
+
+    open(my $ignoredmailmap_file, '<', "${lk_path}.ignoredmailmap")
+	or warn "$P: Can't open .ignoredmailmap: $!\n";
+
+    while (<$ignoredmailmap_file>) {
+	s/#.*$//; #strip comments
+	s/^\s+|\s+$//g; #trim
+
+	next if (/^\s*$/); #skip empty lines
+	#entries have one of the following formats:
+	# name1 <mail1>
+	# <mail1>
+
+	if (/^([^<]+)<([^>]+)>$/) {
+	    my $real_name = $1;
+	    my $address = $2;
+
+	    $real_name =~ s/\s+$//;
+	    ($real_name, $address) = parse_email("$real_name <$address>");
+	    $ignoredmailmap->{$address} = 1;
+	} elsif (/^(.+)<([^>]+)>\s*<([^>]+)>$/) {
+	    my $real_name = $1;
+	    my $real_address = $2;
+	    my $wrong_address = $3;
+
+	    $real_name =~ s/\s+$//;
+	    ($real_name, $real_address) =
+		parse_email("$real_name <$real_address>");
+	    $ignoredmailmap->{$real_address} = 1;
+	}
+    }
+    close($ignoredmailmap_file);
+}
+
 ## use the filenames on the command line or find the filenames in the patchfiles
 
 my @files = ();
@@ -1074,6 +1120,10 @@ sub push_email_address {
     if ($address eq "") {
 	return 0;
     }
+    if (exists $ignoredmailmap->{$address}) {
+        #warn("Ignoring address: '" . $address . "'\n");
+        return 0;
+    }
 
     if (!$email_remove_duplicates) {
 	push(@email_to, [format_email($name, $address, $email_usename), $role]);
-- 
2.21.3



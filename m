Received: from eggs.gnu.org ([209.51.188.92]:35813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GI-0002KD-7N
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GG-0003kX-Fs
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:58 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GG-0003Vg-2G
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:56 -0500
Received: by mail-wr1-x431.google.com with SMTP id v13so4716166wrw.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.15.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:15:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:16 +0100
Message-Id: <1549390526-24246-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/76] tap: flush STDOUT on newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This makes it easier to follow what is going on.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tap-driver.pl | 1 +
 scripts/tap-merge.pl  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/scripts/tap-driver.pl b/scripts/tap-driver.pl
index 5e59b5d..6621a5c 100755
--- a/scripts/tap-driver.pl
+++ b/scripts/tap-driver.pl
@@ -313,6 +313,7 @@ sub main ()
   my $iterator = TAP::Parser::Iterator::Stream->new(\*STDIN);
   my $parser = TAP::Parser->new ({iterator => $iterator });
 
+  STDOUT->autoflush(1);
   while (defined (my $cur = $parser->next))
     {
       # Parsing of TAP input should stop after a "Bail out!" directive.
diff --git a/scripts/tap-merge.pl b/scripts/tap-merge.pl
index 59e3fa5..10ccf57 100755
--- a/scripts/tap-merge.pl
+++ b/scripts/tap-merge.pl
@@ -53,6 +53,7 @@ sub main ()
   my $testno = 0;     # Number of test results seen so far.
   my $bailed_out = 0; # Whether a "Bail out!" directive has been seen.
 
+  STDOUT->autoflush(1);
   while (defined (my $cur = $parser->next))
     {
       if ($cur->is_bailout)
-- 
1.8.3.1

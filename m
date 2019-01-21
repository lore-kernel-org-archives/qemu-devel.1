Received: from eggs.gnu.org ([209.51.188.92]:51657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy6-0004Lz-De
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy5-00048d-AA
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:42 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldy5-00047o-1Y
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:41 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v13so24483062wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:40 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:48 +0100
Message-Id: <1548093980-43088-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/49] tap: flush STDOUT on newline
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

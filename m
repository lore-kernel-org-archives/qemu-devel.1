Received: from eggs.gnu.org ([2001:4830:134:3::10]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riverchiang@gmail.com>) id 1edqNT-0002FH-9E
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 23:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riverchiang@gmail.com>) id 1edqNS-0003Qz-9a
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 23:40:07 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riverchiang@gmail.com>)
	id 1edqNS-0003Qh-49
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 23:40:06 -0500
Received: by mail-qt0-x241.google.com with SMTP id a27so13574865qtd.1
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 20:40:05 -0800 (PST)
MIME-Version: 1.0
From: River Chiang <riverchiang@gmail.com>
Date: Mon, 22 Jan 2018 23:40:04 -0500
Message-ID: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Prevent overriding the input file with the output file
 when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

    Signed-off-by: River Chiang <riverchiang@gmail.com>

---------------------------------- qemu-img.c
----------------------------------
index 68b375f998..5ce594ea00 100644
@@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
     if (s.src_num < 1) {
         error_report("Must specify image file name");
         goto fail_getopt;
+    } else if (!strcmp(argv[optind], out_filename)) {
+        error_report("Override the input file with the output file");
+        goto fail_getopt;
     }

Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D2C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D658218A1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 18:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D658218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG62g-0001B5-Ce
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 14:09:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zu-0007nv-SA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG5zt-0004KR-VC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:26 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zt-0004K5-MJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id BDD78BEEA;
	Mon, 15 Apr 2019 20:06:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pbAhRydBs_9k; Mon, 15 Apr 2019 20:06:20 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id E7728BEE9;
	Mon, 15 Apr 2019 20:06:19 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG5zm-0000O9-RV; Mon, 15 Apr 2019 20:06:18 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Mon, 15 Apr 2019 20:06:18 +0200
Message-Id: <20190415180618.1450-2-samuel.thibault@ens-lyon.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
References: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: [Qemu-devel] [PULL 1/1] slirp: Gcc 9 -O3 fix
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
Cc: jan.kiszka@siemens.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	stefanha@redhat.com, Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415180618.fMW91wvF_y6po-leXPZQ7iYnbb40R9GwvFfE-6l7Taw@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Gcc 9 needs some convincing that sopreprbuf really is going to fill
in iov in the call from soreadbuf, even though the failure case
shouldn't happen.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190415121740.9881-1-dgilbert@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/src/socket.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/slirp/src/socket.c b/slirp/src/socket.c
index 4a3c935e25..bb752fdcae 100644
--- a/slirp/src/socket.c
+++ b/slirp/src/socket.c
@@ -171,6 +171,7 @@ int
 soread(struct socket *so)
 {
 	int n, nn;
+	size_t buf_len;
 	struct sbuf *sb =3D &so->so_snd;
 	struct iovec iov[2];
=20
@@ -181,7 +182,8 @@ soread(struct socket *so)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
-	sopreprbuf(so, iov, &n);
+	buf_len =3D sopreprbuf(so, iov, &n);
+	assert(buf_len !=3D 0);
=20
 	nn =3D recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
 	if (nn <=3D 0) {
@@ -257,6 +259,7 @@ int soreadbuf(struct socket *so, const char *buf, int=
 size)
 	 * No need to check if there's enough room to read.
 	 * soread wouldn't have been called if there weren't
 	 */
+	assert(size > 0);
 	if (sopreprbuf(so, iov, &n) < size)
         goto err;
=20
--=20
2.20.1



Received: from eggs.gnu.org ([2001:4830:134:3::10]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cOrKY-0007VI-F6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cOrKV-0004UK-D1
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:34:38 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:50990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1cOrKV-0004TY-6r
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 14:34:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id EA73211D7A21
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 20:34:03 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yvJkhZqccft9 for <qemu-devel@nongnu.org>;
	Wed,  4 Jan 2017 20:34:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id D1C9E11D7A35
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 20:34:03 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SD7L9RXrKKRl for <qemu-devel@nongnu.org>;
	Wed,  4 Jan 2017 20:34:03 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id BF8E511D7A34
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 20:34:03 +0100 (CET)
Date: Wed, 4 Jan 2017 20:34:03 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <356610769.5581597.1483558443751.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] drive_mirror to nbd with tls ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,

I'm currently trying to implemented drive_mirror to nbd with tls.

It's working fine without tls,  but with tls enabled on target,

I don't known how to pass tls-creds to drive_mirror nbd uri ?  

I don't see any option in nbd uri schema.

Currently, I have this error "TLS negotiation required before option 3" with calling drive_mirror to nbd.

Any idea ?

Regards,

Alexandre Derumier

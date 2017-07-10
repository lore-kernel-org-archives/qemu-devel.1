Received: from eggs.gnu.org ([2001:4830:134:3::10]:37203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spleefer90@gmail.com>) id 1dUTDP-0006ej-QJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spleefer90@gmail.com>) id 1dUTDL-0006l9-Ok
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:34:43 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <spleefer90@gmail.com>)
	id 1dUTDL-0006kZ-Ir
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 03:34:39 -0400
Received: by mail-oi0-f48.google.com with SMTP id l130so67763472oib.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 00:34:37 -0700 (PDT)
MIME-Version: 1.0
From: Martin Rys <spleefer90@gmail.com>
Date: Mon, 10 Jul 2017 09:33:36 +0200
Message-ID: <CACbE=3qTtR39sbOcvDhTmVPxOSY+ORjMCKOQcAwDQEX2VbB1YQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] HTTPS on qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi, I don't know which mailing list to use for website things, so I'm
just using devel, hopefully reaching the correct people.

https://www.ssllabs.com/ssltest/analyze.html?d=qemu.org

Qemu.org still uses HTTP (it should redirect from HTTP to HTTPS
instead) and HTTPS is broken, only because the TLS certificate seems
to be self-generated.

You can easily get a free non-wildcard certificate from Let's Encrypt
via certbot and automate certificate renewing with something as easy
as a cron job that calls certbot.

https://letsencrypt.org/

Hopefully I'll see you switch to HTTPS in the future!

Thanks, Martin.

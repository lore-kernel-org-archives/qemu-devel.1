Received: from eggs.gnu.org ([2001:4830:134:3::10]:53825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1fen31-0002UK-Pf
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jannh@google.com>) id 1fen31-0004LL-3L
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:51:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jannh@google.com>) id 1fen30-0004Ki-UB
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 15:51:11 -0400
Received: by mail-oi0-x242.google.com with SMTP id k81-v6so71030902oib.4
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 12:51:09 -0700 (PDT)
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Sun, 15 Jul 2018 21:50:42 +0200
Message-ID: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] insecure git submodule URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>

Hi!

I noticed that when I build QEMU from git for the first time, it pulls
in submodules over the insecure git:// protocol - in other words, as
far as I can tell, if I'm e.g. on an open wifi network while building
QEMU for the first time, even if I cloned the main repository over
https, anyone could smuggle in malicious code as part of e.g. a
submodule's makefile.

I'm not sure what your preferred fix for this is, so I'm not sending a
patch yet. As far as I can tell, the two options are:

 - change .gitmodules to use https for everything
 - change .gitmodules to use relative URLs

If you want, I'll send a patch that does one of these, although it's
probably faster if you just do it yourselves.

Relative URLs would have the advantage that if someone is cloning from
a mirror (in other words, github), the submodules will also
automatically come from the same mirror.

As far as I can tell, the QEMU git server only supports the "dumb" git
protocol when accessed over HTTPS, not the "smart" protocol. I'm not
sure whether that might be why QEMU is currently still using the
insecure git protocol instead of git over HTTPS?

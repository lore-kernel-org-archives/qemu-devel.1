Received: from eggs.gnu.org ([2001:4830:134:3::10]:53772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dvOXt-0006uR-AR
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dvOXn-0001La-Qc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:09 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:44379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dvOXn-0001K4-Kk
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:03:03 -0400
Received: by mail-pf0-x230.google.com with SMTP id e1so609638pfk.1
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:03:01 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Fri, 22 Sep 2017 07:02:31 -0700
Message-Id: <20170922140237.10869-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 0/6] linux-user: refactor socket.h into
 architecture specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, laurent@vivier.eu, riku.voipio@iki.fi

the definitions in socket.h are meant to reflect the ones in linux for each
respective target, but are sometimes difficult to maintain.

hppa (AKA parisc) was initially merged with an independent file that mirrors
more closely the corresponding one in linux but hasn't been updated since.

while testing what should had been a simple change (adding to setsockopt
support for another SO flag) it became obvious that doing this refactor
would help making the code easier to understand and avoid hard to see bugs
(like definitions set to the wrong target as shown for sparc at least)

the changes are somehow mechanical, and I had made an effort to try to identify
what has changed (and hopefully fix a bug), but there is a high probability
something as silly as a typo might have introduced a bug, therefore, testing
for each target is encouraged but not something I could do on my own (being
new to qemu-user and not having access to the corresponding sysroots)

the fact that it is most likely that most socket functions where not working
for sparc, sparc64, mips64 and ppc64 is most likely an indication that more
testing (and regressions) is likely needed around this, so suggestions and
help on that is also needed.

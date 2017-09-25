Received: from eggs.gnu.org ([2001:4830:134:3::10]:44024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf6-0007ga-0M
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf2-0001rq-2b
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:40 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf1-0001rL-Sq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:35 -0400
Received: by mail-pf0-x241.google.com with SMTP id f84so4223214pfj.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:35 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:18 -0700
Message-Id: <20170925231924.31303-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] linux-user: refactor socket.h into architecture
 specific sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi

the definitions in socket.h are meant to reflect the ones in linux for each
respective target, but are sometimes difficult to maintain.

hppa (AKA parisc) was initially merged with an independent file that mirrors
more closely the corresponding one in linux but hasn't been updated since.

this series updates hppa with the latest bits from linux 4.14 and makes sure
all relevant architectures had a sockbits file that would be easy to maintain
going forward.

most of the changes are pretty mechanical and I had made (thanks to Laurent's
tough review) every effort to ensure no value gets changed accidentaly and 
all changes (even the ones where the value remains but is now in a different
base to better match what was used in the linux headers) are documented, so
it should be fairly safe and will fix bugs (mostly for sparc).

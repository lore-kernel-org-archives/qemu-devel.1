Received: from eggs.gnu.org ([209.51.188.92]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEL6k-00086K-Mf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1hEL6j-0007Sz-IE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1hEL6j-0007S1-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:50:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 8so2268242pfr.4
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 14:50:12 -0700 (PDT)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Thu, 11 Apr 2019 00:44:38 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201904110044.38853.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

Please also include this patch in next -rc or final, it fixes 32-bit compilation:

https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)

without it I get 

ui/curses.c: In function 'get_ucs':
ui/curses.c:456:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=format=]
         fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
                         ^
cc1: all warnings being treated as errors
make: *** [ui/curses.o] Error 1
make: *** Waiting for unfinished jobs....

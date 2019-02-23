Received: from eggs.gnu.org ([209.51.188.92]:41658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gxLLX-0004U5-QS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:39:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1gxLLW-0008FZ-Q1
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:39:15 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:44312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1gxLLW-0008Eh-Hu
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:39:14 -0500
Received: by mail-pf1-x433.google.com with SMTP id a3so1813823pff.11
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 16:39:14 -0800 (PST)
Received: from [192.168.1.103] ([176.116.252.109])
	by smtp.gmail.com with ESMTPSA id
	b85sm5945740pfj.56.2019.02.22.16.39.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 22 Feb 2019 16:39:11 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sat, 23 Feb 2019 03:35:59 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201902230335.59138.randrianasulu@gmail.com>
Subject: [Qemu-devel] Build error with git commit
 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 on x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello!

I just pulled latest git

up to 
commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116 (HEAD -> master, origin/master, 
origin/HEAD)
Merge: a05838cb2a 2b6326c0bf
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Fri Feb 22 15:48:04 2019 +0000

    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' 
into staging

    VFIO updates 2019-02-21

     - Workaround kernel overflow bug in vfio type1 DMA unmap
       (Alex Williamson)

     - Refactor vfio container initialization (Eric Auger)

    # gpg: Signature made Fri 22 Feb 2019 05:21:07 GMT
    # gpg:                using RSA key 239B9B6E3BB08B22
    # gpg: Good signature from "Alex Williamson <alex.williamson@redhat.com>" 
[full]
    # gpg:                 aka "Alex Williamson <alex@shazbot.org>" [full]
    # gpg:                 aka "Alex Williamson <alwillia@redhat.com>" [full]
    # gpg:                 aka "Alex Williamson <alex.l.williamson@gmail.com>" 
[full]
    # Primary key fingerprint: 42F6 C04E 540B D1A9 9E7B  8A90 239B 9B6E 3BB0 
8B22

    * remotes/awilliam/tags/vfio-updates-20190221.0:
      hw/vfio/common: Refactor container initialization
      vfio/common: Work around kernel overflow bug in DMA unmap

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
-----------------

and default build with simple ./configure on slackware 14.2 x86-64 box failed 
like this:

root@slax:~/src/qemu# LANG=C make -j 5
        CHK version_gen.h
  CC      qobject/block-qdict.o
  CC      util/thread-pool.o
  CC      util/main-loop.o
  CC      util/qemu-timer.o
  CC      util/iohandler.o
  CC      util/aio-posix.o
qobject/block-qdict.c: In function 'qdict_array_split':
qobject/block-qdict.c:259:9: error: 'subqdict' may be used uninitialized in this 
function [-Werror=maybe-uninitialized]
         qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
         ^
  CC      util/compatfd.o
  CC      util/event_notifier-posix.o
cc1: all warnings being treated as errors
/root/src/qemu/rules.mak:69: recipe for target 'qobject/block-qdict.o' failed
make: *** [qobject/block-qdict.o] Error 1
make: *** Waiting for unfinished jobs....
----------------

 LANG=C gcc --version
gcc (GCC) 5.5.0
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

---------------

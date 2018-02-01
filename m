Received: from eggs.gnu.org ([2001:4830:134:3::10]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehA3c-0001Jm-Sx
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehA3X-0006L5-9c
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehA3X-0006Ky-3R
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 03:17:15 -0500
Date: Thu, 1 Feb 2018 09:17:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180201081711.vu3ou7mdwww365j2@sirius.home.kraxel.org>
References: <20180130051837.8725-1-programmingkidx@gmail.com>
	<20180130094140.67xjf26jcymuz2bb@sirius.home.kraxel.org>
	<167881EE-F694-46C3-A15B-94B1733D2E40@gmail.com>
	<20180131092213.srlhijglevhha6jw@sirius.home.kraxel.org>
	<BCDC8A8F-F8CE-4F71-A11C-CF7078FB6BAF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BCDC8A8F-F8CE-4F71-A11C-CF7078FB6BAF@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new
 logging API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org

> > ldebug() should probably trace points.
> 
> I need help with this. I tried replacing ldebug() with
> "qemu_log_mask(LOG_TRACE,", but that caused a lot of messages to be
> printed to the terminal. It is odd because I thought I had to use "-d
> trace" to make it print. Do you have another suggestion on what to
> replace ldebug() with? 

See docs/devel/tracing.txt

You might also have a look at commit
6aa22a29187e1908f5db738d27c64a9efc8d0bfa as example (adds some trace
points to vnc code).

HTH,
  Gerd

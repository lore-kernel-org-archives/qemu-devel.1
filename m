Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euCo6-00066k-KM
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euCo3-0002Mc-HP
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:51:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37510 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euCo3-0002MY-DB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 02:51:11 -0500
Date: Fri, 9 Mar 2018 08:50:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180309075054.e4bpa4wsl2wak57w@sirius.home.kraxel.org>
References: <20180308083231.20180-1-kraxel@redhat.com>
	<CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
	<20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> Maybe I should move the code to a separate source file so it can be
> built with different compiler flags, without needing #pragma?  I don't
> feel like building all gtk code with -Wno-deprecated-declarations ...

Hmm, that idea doesn't fly, seems per-object cflags don't work for
object files which get linked into a module.

Other ideas anyone?

cheers,
  Gerd

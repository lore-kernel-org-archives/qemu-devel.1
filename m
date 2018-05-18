Received: from eggs.gnu.org ([2001:4830:134:3::10]:41132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZR2-0008Tn-Rs
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZQz-0001iN-Kr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:04:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJZQz-0001iD-H9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:04:13 -0400
Date: Fri, 18 May 2018 09:04:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518070412.4zlrltobjqc54g6b@sirius.home.kraxel.org>
References: <20180515185814.1374-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515185814.1374-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] sdl: Move use of surface pointer below
 check for whether it is NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Anatoly Trosinenko <anatoly.trosinenko@gmail.com>

On Tue, May 15, 2018 at 07:58:14PM +0100, Peter Maydell wrote:
> In commit 2ab858c6c38ee1 we added a use of the 'surf' variable
> in sdl2_2d_update() that was unfortunately placed above the
> early-exit-if-NULL check. Move it to where it ought to be.

Added to ui patch queue.

thanks,
  Gerd

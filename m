Received: from eggs.gnu.org ([2001:4830:134:3::10]:33832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn051-0003YE-Dn
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn04w-0001fM-HD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:18:39 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn04w-0001f5-AR
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:18:34 -0400
Received: by mail-wm0-x241.google.com with SMTP id i76so1270109wme.3
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:18:34 -0700 (PDT)
Date: Wed, 30 Aug 2017 11:18:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830101830.GF24565@stefanha-x1.localdomain>
References: <20170830082702.3011-1-Sergio.G.DelReal@gmail.com>
	<20170830082702.3011-2-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830082702.3011-2-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/13] hvf: add support for
 Hypervisor.framework in the configure script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 03:26:50AM -0500, Sergio Andres Gomez Del Real wrote:
> This patch adds to the configure script the code to support the
> --enable-hvf argument. If the OS is Darwin, it checks for presence of
> HVF in the system. The patch also adds strings related to HVF in the
> file qemu-options.hx.
> QEMU will only support the modern syntax style '-M accel=hvf' no enable
> hvf; the legacy '-enable-hvf' will not be supported.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  configure       | 38 ++++++++++++++++++++++++++++++++++++++
>  qemu-options.hx | 10 +++++-----
>  2 files changed, 43 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

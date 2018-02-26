Received: from eggs.gnu.org ([2001:4830:134:3::10]:51406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEka-0001qg-F6
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqEkU-0006IX-Vy
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eqEkU-0006IF-RN
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:07:06 -0500
Date: Mon, 26 Feb 2018 10:07:03 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180226090703.khkdxu65rtfwocyz@kamzik.brq.redhat.com>
References: <20180223215858.16987-1-wei@redhat.com>
	<20180223215858.16987-2-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223215858.16987-2-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, quintela@redhat.com

On Fri, Feb 23, 2018 at 03:58:55PM -0600, Wei Huang wrote:
> This patch moves the auto detection functions for cross compilation from
> roms/Makefile to rules.mak. So the functions can be shared among Makefiles
> in QEMU.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  roms/Makefile | 24 +++++++-----------------
>  rules.mak     | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 17 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

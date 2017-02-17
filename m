Received: from eggs.gnu.org ([2001:4830:134:3::10]:59474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceWkl-00009r-LD
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceWkh-0006p2-NR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:50:27 -0500
Date: Fri, 17 Feb 2017 08:50:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170217005018.GA21716@lemon.lan>
References: <20170216085857.23501-1-snaipe@diacritic.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216085857.23501-1-snaipe@diacritic.io>
Subject: Re: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Franklin Snaipe Mathieu <snaipe@diacritic.io>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, snaipe@arista.com, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 02/16 08:58, Franklin Snaipe Mathieu wrote:
> +            p = lock_user_string(arg3)
> +            if (!p) {

Please compile test at least, even if it is a trivial patch.

Fam

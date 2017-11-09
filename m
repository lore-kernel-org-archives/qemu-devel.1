Received: from eggs.gnu.org ([2001:4830:134:3::10]:54778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr0b-000351-Cg
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr0X-0005mC-FB
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:52:57 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:58870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eCr0X-0005lc-9T
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 12:52:53 -0500
Date: Thu, 9 Nov 2017 18:52:49 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171109175249.lyma4bfc6ugyvtcv@var.youpi.perso.aquilenet.fr>
References: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
	<20171108225340.10194-1-lepton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108225340.10194-1-lepton@google.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: don't zero ti_i since we access it
 later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <lepton@google.com>
Cc: qemu-devel@nongnu.org

Hello,

Tao Wu, on mer. 08 nov. 2017 14:53:40 -0800, wrote:
> The current code looks buggy, we zero ti_i while we access
> ti_dst/ti_src later.

Mmm, indeed, looking again at how it was introduced, it was too much.

Samuel

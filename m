Received: from eggs.gnu.org ([209.51.188.92]:49654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG604-0007vK-T9
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hG604-0004Q1-6E
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:36 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hG603-0004Oa-Tn
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 14:06:36 -0400
Date: Mon, 15 Apr 2019 20:06:33 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190415180633.pezyl3sxbkahvc6f@function>
References: <20190415121740.9881-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415121740.9881-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] slirp: Gcc 9 -O3 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

Dr. David Alan Gilbert (git), le lun. 15 avril 2019 13:17:40 +0100, a ecrit:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Gcc 9 needs some convincing that sopreprbuf really is going to fill
> in iov in the call from soreadbuf, even though the failure case
> shouldn't happen.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Applied to my tree, thanks!

Samuel

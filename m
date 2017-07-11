Received: from eggs.gnu.org ([2001:4830:134:3::10]:42814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4KN-0000Ip-F5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4KM-0002UG-Nz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:12:23 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:43007)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4KM-0002Ty-Gw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:12:22 -0400
Date: Wed, 12 Jul 2017 01:12:19 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170711231219.6gqmd7wgopo7fyhf@var.youpi.perso.aquilenet.fr>
References: <20170709175422.30185-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170709175422.30185-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] slirp: fork_exec(): Don't close() a
 negative number in fork_exec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, on dim. 09 juil. 2017 18:54:22 +0100, wrote:
> In a fork_exec() error path we try to closesocket(s) when s might
> be a negative number because the thing that failed was the
> qemu_socket() call. Add a guard so we don't do this.
> 
> (Spotted by Coverity: CID 1005727 issue 1 of 2.)

Applied to my tree, thanks!

Samuel

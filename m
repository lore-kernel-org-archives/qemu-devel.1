Received: from eggs.gnu.org ([2001:4830:134:3::10]:44929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4W1-0002kQ-4P
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4W0-0006Jp-CI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:24:25 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:43021)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dV4W0-0006JO-5v
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 19:24:24 -0400
Date: Wed, 12 Jul 2017 01:24:21 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170711232421.twevmetqym67t3ye@var.youpi.perso.aquilenet.fr>
References: <1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496679576-14336-3-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [2/2] slirp: Handle error returns from sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, patches@linaro.org

Peter Maydell, on lun. 05 juin 2017 17:19:36 +0100, wrote:
> diff --git a/slirp/socket.c b/slirp/socket.c
> index a17caa9..84cf13a 100644
> --- a/slirp/socket.c
> +++ b/slirp/socket.c
> @@ -404,7 +404,14 @@ sowrite(struct socket *so)
>  	DEBUG_ARG("so = %p", so);
>  
>  	if (so->so_urgc) {
> -		sosendoob(so);
> +		if (sosendoob(so) < so->so_urgc) {

Mmm, I believe one needs to use a copy of so->so_urgc, since sosendoob()
modifies it in the success case?

Samuel

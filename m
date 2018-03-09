Received: from eggs.gnu.org ([2001:4830:134:3::10]:41545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO6j-0003RX-3j
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO6e-0000cI-9L
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:13 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:49395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1euO6d-0000cA-Vm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:55:08 -0500
References: <20180308104859.3315-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <adbfefe3-1a74-fd45-fb95-0f62b4c0a280@vivier.eu>
Date: Fri, 9 Mar 2018 20:54:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180308104859.3315-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: allows to use "--systemd ALL"
 with qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 08/03/2018 à 11:48, Laurent Vivier a écrit :
> qemu-binfmt-conf.sh when it is used with systemd
> needs to know for which CPU the systemd-binfmt.service
> file must be created (i.e. "--systemd ppc").
> 
> But sometime, for instance for test purpose, we need to
> create an entry for all known architectures.
> This patch entroduce the "ALL" parameter for this purpose.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  scripts/qemu-binfmt-conf.sh | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent

Received: from eggs.gnu.org ([209.51.188.92]:53371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gztbw-000882-7R
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gztbv-0000uz-H7
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:38:44 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:46502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gztbu-0000me-R2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 20:38:43 -0500
Date: Fri, 1 Mar 2019 17:38:10 -0800
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190302013810.wm6uawvud6aiazwg@function>
References: <20190301064809.3074-1-llyzs.vic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301064809.3074-1-llyzs.vic@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: check for ioctlsocket error and
 0-length udp payload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vic Lee <llyzs.vic@gmail.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

Vic Lee, le ven. 01 mars 2019 14:48:09 +0800, a ecrit:
> Sometimes sorecvfrom() is called from slirp.c because revents == G_IO_IN,
> but there is 0 bytes available and recvfrom could be blocking indefinitely.
> This is likely due to 0-length udp payload. This also adds an error
> checking for ioctlsocket.
> 
> Signed-off-by: Vic Lee <llyzs.vic@gmail.com>

Applied to my tree, thanks!

Samuel

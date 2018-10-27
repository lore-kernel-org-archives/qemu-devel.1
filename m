Received: from eggs.gnu.org ([2001:4830:134:3::10]:40083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMWu-0006Di-U2
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gGMWp-0003Z4-S2
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:13:20 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:49890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gGMWp-0003YZ-Lt
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 07:13:15 -0400
Date: Sat, 27 Oct 2018 13:13:13 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181027111313.yfkmujtfuqqeuqxq@function>
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-2-git-send-email-max7255@yandex-team.ru>
	<20181027111141.tpzhv6xcrhxet6li@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027111141.tpzhv6xcrhxet6li@function>
Subject: Re: [Qemu-devel] [PATCH RFC 1/4] slirp: add helper for tcp6 socket
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>, h@function
Cc: qemu-devel@nongnu.org

Samuel Thibault, le sam. 27 oct. 2018 13:11:41 +0200, a ecrit:
> struct socket *
> tcp_listen(Slirp *slirp, uint32_t haddr, u_int hport, uint32_t laddr,
>            u_int lport, int flags)
> {
> 	struct sockaddr_in addr;
> 	struct socket *so;
> 	socklen_t addrsize = sizeof(addr);

Also  memset(&addr, 0, sizeof(addr);

> 	addr.sin_family = AF_INET;
> 	addr.sin_addr.s_addr = haddr;
> 	addr.sin_port = hport;

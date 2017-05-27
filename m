Received: from eggs.gnu.org ([2001:4830:134:3::10]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjMv-0003FM-Gh
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjMs-0001tf-FM
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:35:29 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:43375)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dEjMs-0001tZ-8Q
	for qemu-devel@nongnu.org; Sat, 27 May 2017 17:35:26 -0400
Date: Sat, 27 May 2017 23:35:23 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170527213523.c5ki5dz5zvsr5z46@var.youpi.perso.aquilenet.fr>
References: <CAPXQAKv-sa4e5gNwPkEQzS5yZM61Lxdip+khwzt0NAYhAYiY9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXQAKv-sa4e5gNwPkEQzS5yZM61Lxdip+khwzt0NAYhAYiY9w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] [SLIRP] Fix total IP header length in
 forwarded TCP packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sjors Gielen <sjors@sjorsgielen.nl>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org

Sjors Gielen, on mer. 24 mai 2017 17:51:12 +0000, wrote:
> When forwarding TCP packets, the internal tcpiphdr struct length was wrongly
> used inside the IP header. This commit changes the behaviour to what is used
> by tcp_output.c, using the correct full IP header + payload length.

Indeed, applied, thanks.

Samuel

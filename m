Received: from eggs.gnu.org ([2001:4830:134:3::10]:43167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8Bmz-0001ov-5K
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8Bmv-0003cK-20
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:21 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:33214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d8Bmu-0003bk-S8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:31:16 -0400
Date: Tue, 9 May 2017 22:31:12 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170509203112.czvrdgdghsnnq3ie@var.youpi.perso.aquilenet.fr>
References: <20170509193112.16613-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509193112.16613-1-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v5 0/1] slirp: add SOCKS5 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>

Hello,

Laurent Vivier, on mar. 09 mai 2017 21:31:11 +0200, wrote:
> This patch implements the SOCKS5 client part for "-net user" backend.

Thanks for the changes!

It seems from the bot result that windows doesn't define in_port_t.
Could you post a revised patch which uses sizeof(uint16_t) instead of
sizeof(in_port_t), to trigger the bot again and confirm that this is the
last needed fix for windows?

Samuel

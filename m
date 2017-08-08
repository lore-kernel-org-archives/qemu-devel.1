Received: from eggs.gnu.org ([2001:4830:134:3::10]:52934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1df4Pi-0007bM-D5
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1df4Pd-0006B2-Jn
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:19:14 -0400
Received: from jessie.kos.to ([212.47.231.226]:52156 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1df4Pd-00069q-E3
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:19:09 -0400
Date: Tue, 8 Aug 2017 13:19:04 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170808131904.GA29288@kos.to>
References: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
Subject: Re: [Qemu-devel] [Bug 1709170] [NEW] QEMU fails to honor O_TMPFILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1709170 <1709170@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org, thiago@kde.org

On Mon, Aug 07, 2017 at 08:18:04PM -0000, Thiago Macieira wrote:
> Public bug reported:
> 
> When making a call like
> 
>   open("/tmp", O_TMPFILE | O_RDWR);
> 
> under QEMU, we ged -EISDIR.
> 
> Under any kernel 3.11 or later, we are supposed to get an unnamed file
> in /tmp. In case the filesystem for /tmp does not support unnamed files,
> we are supposed to get EOPNOTSUPP.

Actually, -EISDIR is valid error when underlying system doesn't support O_TMPFILE.
See man openat or the kernel definition for O_TMPFILE.

Regardless, I'm submitting a patch to properly translate the O_TMPFILE.

Riku

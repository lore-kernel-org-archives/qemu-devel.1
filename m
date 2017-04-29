Received: from eggs.gnu.org ([2001:4830:134:3::10]:38765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Rje-000873-Ue
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Rje-0003Jv-7y
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:44:26 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:54816)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4Rje-0003JN-15
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 08:44:26 -0400
Date: Sat, 29 Apr 2017 14:44:21 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170429124421.2qcthvlsiwvtqov2@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB247952CA06D05D5041AA450D9C130@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB247995F01C0EC808ADEA07C49C180@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479950F84BBE26A46F549FA9C110@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<VI1PR0601MB2479D2A56A202E3FD18C6DDF9C1F0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>, MCDONALD Margaret <margaret.mcdonald@hexagon.com>

Hello,

FONNEMANN Mark, on mer. 19 avril 2017 18:11:59 +0000, wrote:
> I have tested 2.9-rc4 and the problem still exists there as well.

FONNEMANN Mark, on lun. 24 avril 2017 23:43:02 +0000, wrote:
> I just confirmed that the problem exists in 2.9 release using qemu-system-i386.exe as well.

FONNEMANN Mark, on mer. 26 avril 2017 18:51:00 +0000, wrote:
> I just verified the problem exists on Linux host as well. I cannot ping the DNS or SMB server and the DNS server does not respond to nslookup requests.

One first thing to note: the DNS or SMB servers can not be pinged, since
that was never implemented (I'll post a patch for that), so there is no
surprise on that end.

Also, your issue happens even with explictly requesting ipv4, so it's
probably not a problem with the v6 updates by themselves.

When running with a Linux host (since that's what I'm most familiar
with), what do you have in /etc/resolv.conf?

Samuel

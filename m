Received: from eggs.gnu.org ([2001:4830:134:3::10]:47946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIXIs-0006nM-To
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gIXIs-0000wn-Ax
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:07:50 -0400
Date: Fri, 2 Nov 2018 12:07:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181102110734.GE7521@dhcp-200-186.str.redhat.com>
References: <20181102085800.21860-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181102085800.21860-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Am 02.11.2018 um 09:58 hat Philippe Mathieu-Daud=E9 geschrieben:
> This definitions are QCow2 specific, there is no need to expose them
> in the global namespace.
>=20
> This partially reverts commit 540b8492618eb.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

If we don't want this globally, I think we also don't want it in qcow2.
Or at least reduce it to only those constants that qcow2 actually uses.

Kevin

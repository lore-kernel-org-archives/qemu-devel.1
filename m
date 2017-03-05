Received: from eggs.gnu.org ([2001:4830:134:3::10]:40862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckQyX-0003R3-Sm
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckQyU-0006VB-QK
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 02:53:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170304185533.10618-1-f4bug@amsat.org>
Date: Sun, 05 Mar 2017 08:52:57 +0100
In-Reply-To: <20170304185533.10618-1-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 4 Mar 2017 15:55:30
	-0300")
Message-ID: <87o9xgcg86.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] easy-to-fix clang warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Cc: qemu-trivial

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> This patchset fixes three easy-to-fix clang warnings.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   usb-ccid: make ccid_write_data_block() cope with null buffers
>   device_tree: fix compiler warnings (clang 5)
>   qga: fix compiler warnings (clang 5)
>
>  device_tree.c                 | 1 +
>  hw/usb/dev-smartcard-reader.c | 8 +++++++-
>  qga/commands-posix.c          | 8 +++++---
>  3 files changed, 13 insertions(+), 4 deletions(-)

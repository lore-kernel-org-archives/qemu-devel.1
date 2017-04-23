Received: from eggs.gnu.org ([2001:4830:134:3::10]:37696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2ChA-0002qt-JI
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 04:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2Ch7-0006xC-Ex
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 04:16:36 -0400
References: <20170407222016.15308-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <d21c06f2-497a-1d2b-ee6c-da0c3948a43d@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 11:16:27 +0300
MIME-Version: 1.0
In-Reply-To: <20170407222016.15308-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 3 easy-to-fix clang warnings,
 1 error code fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

08.04.2017 01:20, Philippe Mathieu-Daud=C3=A9 wrote:
> This patchset fixes three easy-to-fix unrelated clang warnings, so it w=
as
> probably better to send them separately the first time.
>=20
> v2:
>     - hw/usb/dev-smartcard-reader.c: The first patch was treating NULL =
and 0 as
>       errors but those values are legal in some cases, i.e. no (virtual=
)
>       smartcard inserted into the card reader (Gerd Hoffmann's review).
>     - device_tree.c: Added Marc-Andr=C3=A9 Lureau's Reviewed-by.
>     - qga/commands-posix.c: Added a commit to improve failed operation,=
 as
>       suggested by Michael Roth.
>=20
> Philippe Mathieu-Daud=C3=A9 (4):
>   usb-ccid: make ccid_write_data_block() cope with null buffers
>   device_tree: fix compiler warnings (clang 5)
>   qga: fix compiler warnings (clang 5)
>   qga: improve error handling in transfer_memory_block

Applied to -trivial, thanks!

/mjt

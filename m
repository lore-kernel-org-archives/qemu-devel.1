Received: from eggs.gnu.org ([2001:4830:134:3::10]:45877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <craig@rancher.com>) id 1cyO2u-0003WG-Vl
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <craig@rancher.com>) id 1cyO2q-0007QN-Uy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:35:17 -0400
Received: from mail-cys01nam02on0099.outbound.protection.outlook.com
	([104.47.37.99]:32381
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <craig@rancher.com>) id 1cyO2q-0007O7-Lm
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:35:12 -0400
From: Craig Jellick <craig@rancher.com>
Date: Wed, 12 Apr 2017 16:02:46 +0000
Message-ID: <CY4PR11MB162370BEAB5D22F1E647CCE8AA030@CY4PR11MB1623.namprd11.prod.outlook.com>
References: <1489765795-32398-1-git-send-email-craig@rancher.com>,
	<871ssz9j8p.fsf@dusky.pond.sub.org>
In-Reply-To: <871ssz9j8p.fsf@dusky.pond.sub.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add 'none' as type for drive's if option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

Is there an action I need to take for that?

________________________________
From: Markus Armbruster <armbru@redhat.com>
Sent: Tuesday, April 11, 2017 6:17:10 AM
To: Craig Jellick
Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org
Subject: Re: [Qemu-devel] [PATCH] Add 'none' as type for drive's if option

Perhaps this can go via qemu-trivial.

Craig Jellick <craig@rancher.com> writes:

> Signed-off-by: Craig Jellick <craig@rancher.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 99af8ed..8291e64 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -591,7 +591,7 @@ Special files such as iSCSI devices can be specified =
using protocol
>  specific URLs. See the section for "Device URL Syntax" for more informat=
ion.
>  @item if=3D@var{interface}
>  This option defines on which type on interface the drive is connected.
> -Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio.
> +Available types are: ide, scsi, sd, mtd, floppy, pflash, virtio, none.
>  @item bus=3D@var{bus},unit=3D@var{unit}
>  These options define where is connected the drive by defining the bus nu=
mber and
>  the unit id.

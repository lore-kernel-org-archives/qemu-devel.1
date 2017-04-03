Received: from eggs.gnu.org ([2001:4830:134:3::10]:58395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cuzrn-00081S-Pm
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cuzrl-0007Cq-1h
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:09:47 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cuzrk-0007AM-Rx
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 07:09:44 -0400
Received: by mail-wr0-f178.google.com with SMTP id l43so166089893wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 04:09:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
From: Vinzenz Feenstra <vfeenstr@redhat.com>
In-Reply-To: <20170403095438.15423-1-marcandre.lureau@redhat.com>
Date: Mon, 3 Apr 2017 13:09:38 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <86411B81-C6A3-4C4D-AF1A-3619F1DF9CDE@redhat.com>
References: <20170403095438.15423-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qga: improve fsfreeze documentations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

LGTM=20

> On Apr 3, 2017, at 11:54 AM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@redhat.com> wrote:
>=20
> Some users find the fsfreeze behaviour confusing. Add some notes about
> invalid mount points and Windows usage.
>=20
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1436976
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> qga/qapi-schema.json | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index a02dbf2d18..8d901f556a 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -426,7 +426,13 @@
> ##
> # @guest-fsfreeze-freeze:
> #
> -# Sync and freeze all freezable, local guest filesystems
> +# Sync and freeze all freezable, local guest filesystems. If this
> +# command succeeded, you may call @guest-fsfreeze-thaw later to
> +# unfreeze.
> +#
> +# Note: On Windows, the command is implemented with the help of a
> +# Volume Shadow-copy Service DLL helper. The frozen state is limited
> +# for up to 10 seconds by VSS.
> #
> # Returns: Number of file systems currently frozen. On error, all =
filesystems
> # will be thawed.
> @@ -439,10 +445,12 @@
> ##
> # @guest-fsfreeze-freeze-list:
> #
> -# Sync and freeze specified guest filesystems
> +# Sync and freeze specified guest filesystems.
> +# See also @guest-fsfreeze-freeze.
> #
> # @mountpoints: an array of mountpoints of filesystems to be frozen.
> #               If omitted, every mounted filesystem is frozen.
> +#               Invalid mount points are ignored.
> #
> # Returns: Number of file systems currently frozen. On error, all =
filesystems
> # will be thawed.
> --=20
> 2.12.0.191.gc5d8de91d
>=20
>=20

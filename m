Received: from eggs.gnu.org ([2001:4830:134:3::10]:41009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cgunm-0003EY-Hn
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cguni-0007Gj-NN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:55:26 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:46686
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=220d765e8=Paul.Durrant@citrix.com>)
	id 1cguni-0007G3-Dc
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:55:22 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 23 Feb 2017 14:55:19 +0000
Message-ID: <7f9aa3db368b4b98a598c4992c8547a4@AMSPEX02CL03.citrite.net>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
In-Reply-To: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/5] xen: use new xendevicemodel library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
> From: Paul Durrant [mailto:paul.durrant@citrix.com]
> Sent: 23 February 2017 14:54
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>
> Subject: [PATCH 0/5] xen: use new xendevicemodel library
>=20
> My recent patches to Xen [1] introduced a new library to support
> running device models for HVM guests.
> This series ports QEMU onto the new library if it is available in the
> build environment.
>=20

Apologies for the missing reference...

[1] Patches starting with http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dco=
mmit;h=3Db108240265deea37601f1a605910069a837da841

> Paul Durrant (5):
>   xen: make use of xen_xc implicit in xen_common.h inlines
>   xen: rename xen_modified_memory() to xen_hvm_modified_memory()
>   xen: create wrappers for all other uses of xc_hvm_XXX() functions
>   configure: detect presence of libxendevicemodel
>   xen: use libxendevicemodel when available
>=20
>  configure                    |  19 ++++
>  hw/i386/xen/xen_platform.c   |   2 +-
>  hw/xen/xen_backend.c         |   2 -
>  include/exec/ram_addr.h      |   4 +-
>  include/hw/xen/xen.h         |   2 +-
>  include/hw/xen/xen_backend.h |   2 -
>  include/hw/xen/xen_common.h  | 200
> ++++++++++++++++++++++++++++++++-----------
>  xen-common.c                 |  11 +++
>  xen-hvm-stub.c               |   2 +-
>  xen-hvm.c                    |  49 ++++++-----
>  10 files changed, 207 insertions(+), 86 deletions(-)
>=20
> --
> 2.1.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eCmAE-0004ny-Ep
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eCmAB-0001Mh-B1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eCmAB-0001MG-5D
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:42:31 -0500
Date: Thu, 9 Nov 2017 07:42:29 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1014244176.38500883.1510231349539.JavaMail.zimbra@redhat.com>
In-Reply-To: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tpm: Match frontend and backend
 buffer sizes (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>

Hi

----- Original Message -----
> This patch series does away with the hard coded buffer size in the TIS
> frontend and instead retrieves the buffer size from the device that's
> being used. So it gets it from the host device or the external emulator.
> In case the frontend (CRB) cannot support the backend's current buffer si=
ze
> (typically 4k) it can adjust the buffer size the emulator is working with
> so that we will not run into the problem that the backend produces packet=
s
> that the frontend cannot deliver to due mismatching buffer sizes.
>=20
>    Stefan
>=20
> v1->v2:
>   - followed Marc-Andr=C3=A9's suggestions
>=20
>=20
> Stefan Berger (5):
>   tpm: Move getting TPM buffer size to backends
>   tpm: pull tpm_util_request() out of tpm_util_test()
>   tpm: tpm_passthrough: Read the buffer size from the host device
>   tpm: tpm_emulator: get and set buffer size of device
>   tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size

series,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>=20
>  backends/tpm.c               |  11 ++-
>  hw/tpm/tpm_emulator.c        |  83 ++++++++++++++++++++++-
>  hw/tpm/tpm_int.h             |   9 +++
>  hw/tpm/tpm_ioctl.h           |  28 +++++++-
>  hw/tpm/tpm_passthrough.c     |  30 +++++++++
>  hw/tpm/tpm_tis.c             |  18 ++---
>  hw/tpm/tpm_util.c            | 155
>  ++++++++++++++++++++++++++++++++++++++++---
>  hw/tpm/tpm_util.h            |   3 +
>  include/sysemu/tpm_backend.h |  18 ++++-
>  9 files changed, 330 insertions(+), 25 deletions(-)
>=20
> --
> 2.5.5
>=20
>=20

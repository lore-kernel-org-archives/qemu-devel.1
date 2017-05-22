Received: from eggs.gnu.org ([2001:4830:134:3::10]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dCmdZ-0004UN-EJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dCmdW-0007ae-An
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:40:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:19375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dCmdW-0007aE-2f
	for qemu-devel@nongnu.org; Mon, 22 May 2017 08:40:34 -0400
From: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Date: Mon, 22 May 2017 12:40:17 +0000
Message-ID: <D3C33C4430ACA6488F343D1125FCCECC382C63E4@irsmsx110.ger.corp.intel.com>
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Provide support for the software
 TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

Gentle request to review this patchset

> -----Original Message-----
> From: Valluri, Amarnath
> Sent: Tuesday, May 16, 2017 10:58 AM
> To: qemu-devel@nongnu.org
> Cc: Valluri, Amarnath <amarnath.valluri@intel.com>
> Subject: [Qemu-devel][PATCH v4 0/8] Provide support for the software TPM
> emulator
>=20
> Briefly, Theses set of patches introduces:
>   - new TPM backend driver to support software TPM emulators(swtpm(1)).
>   - and few supported fixes/enhancements/cleanup to existing tpm backend
> code.
>=20
>   The similar idea was initiated earliar(2) by Stefan Berger(CCed) with s=
lightly
>   different approach, using CUSE. As swtpm has excellent support for unix
> domain
>   sockets, hence this implementation uses unix domain sockets to
> communicate
>   with
>   swtpm.
>=20
>   When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm'
> and
>   communicates its via Unix domain sockets.
>=20
>   1) https://github.com/stefanberger/swtpm
>   2) https://lists.nongnu.org/archive/html/qemu-devel/2016-
> 01/msg00089.html
>=20
> ** Changes in V2:
> - Made spawnning swtpm optional
> - used QIOChannel instead of plain unix sockets
> - incorporated other fixes pointed in v1 review
>=20
> ** Changes in v3:
> - Addressed review comments made by Stefan Berger and Deniel P Berrange
>=20
> ** Changes in v4:
> - Moved realloc_buffer() to TIS model
> - Made TpmInfo related change backwards compatible.
>=20
> Amarnath Valluri (8):
>   tpm-backend: Remove unneeded member variable from backend class
>   tpm-backend: Move thread handling inside TPMBackend
>   tpm-backend: Initialize and free data members in it's own methods
>   tpm-backend: Made few interface methods optional
>   tmp backend: Add new api to read backend TpmInfo
>   tpm-backend: Move realloc_buffer() implementation to tpm-tis model
>   tpm-passthrough: move reusable code to utils
>   tpm: Added support for TPM emulator
>=20
>  backends/tpm.c                   | 117 +++--
>  configure                        |  15 +-
>  hmp.c                            |  27 +-
>  hw/tpm/Makefile.objs             |   1 +
>  hw/tpm/tpm_emulator.c            | 950
> +++++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_ioctl.h               | 243 ++++++++++
>  hw/tpm/tpm_passthrough.c         | 238 +++-------
>  hw/tpm/tpm_tis.c                 |  14 +-
>  hw/tpm/tpm_util.c                |  25 ++
>  hw/tpm/tpm_util.h                |   4 +
>  include/sysemu/tpm_backend.h     |  96 ++--
>  include/sysemu/tpm_backend_int.h |  41 --
>  qapi-schema.json                 |  41 +-
>  qemu-options.hx                  |  53 ++-
>  tpm.c                            |  38 +-
>  15 files changed, 1545 insertions(+), 358 deletions(-)  create mode 1006=
44
> hw/tpm/tpm_emulator.c  create mode 100644 hw/tpm/tpm_ioctl.h  delete
> mode 100644 include/sysemu/tpm_backend_int.h
>=20
> --
> 2.7.4

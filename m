Received: from eggs.gnu.org ([2001:4830:134:3::10]:58516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsKi-0001Ga-NN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBsKf-0000SL-DY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:05:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBsKf-0000Rd-5E
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 20:05:37 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA714FYj004267
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 20:05:32 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2wbj7a0x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 20:05:31 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 20:05:30 -0500
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 20:05:27 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <bd96f264-3f73-2da6-73bc-d0c73a9e8e07@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/28] TPM: code cleanup (not 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 11/06/2017 01:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>
> Various code cleanups accumulated while doing reviews and implementing
> a CRB device (postponed for later), aiming at a tpm-next development
> branch for after qemu 2.11.

I put all of these now into a tpm-next branch here.

https://github.com/stefanberger/qemu-tpm/commits/tpm-next

This includes 25/28 until I rebase tpm-next on a later 2.11.

All my tests succeeded.

    Stefan


>
> v2: after Stefan review
> - rebased (half of v1 is merged upstream)
> - add & use a DEFINE_PROP_TPMBE()
> - remove tpm_register_model()
> - fix wrong locty_number usage & regression
> - tpm-tis: check that at most one TPM device exists
> - I changed "tpm-passthrough: remove error cleanup from
>    handle_device_opts" to "tpm-passthrough: simplify create()", it is
>    mostly the same patch that Stefan didn't like much but with a
>    different rationale to have code closer to tpm-emulator create().
> - added some signed-offs
>
> Marc-Andr=C3=A9 Lureau (28):
>    tpm-tis: remove unused locty_number
>    tpm: move TpmIf in include/sysemu/tpm.h
>    tpm-backend: store TPMIf interface, improve backend_init()
>    tpm-tis: no longer expose TPMState
>    tpm-be: call request_completed() out of thread
>    tpm-be: report error instead of front-end
>    tpm-be: ask model to the TPM interface
>    tpm: remove unused opened code
>    tpm-passthrough: don't save guessed cancel_path in options
>    tpm-be: update optional function pointers
>    tpm-passthrough: pass TPMPassthruState to handle_device_opts
>    tpm-backend: move set 'id' to common code
>    tpm-passthrough: make it safer to destroy after creation
>    tpm-passthrough: simplify create()
>    tpm-passthrough: workaround a possible race
>    tpm-tis: simplify header inclusion
>    tpm: rename qemu_find_tpm() -> qemu_find_tpm_be()
>    tpm: lookup the the TPM interface instead of TIS device
>    tpm: add TPM interface to lookup TPM version
>    tpm: add tpm_cmd_get_size() to tpm_util
>    acpi: change TPM TIS data conditions
>    tpm-emulator: add a FIXME comment about blocking cancel
>    tpm-tis: remove redundant 'tpm_tis:' in error messages
>    tpm-tis: check that at most one TPM device exists
>    tpm-emulator: protect concurrent ctrl_chr access
>    qdev: add DEFINE_PROP_TPMBE
>    tpm-tis: use DEFINE_PROP_TPMBE
>    tpm: remove tpm_register_model()
>
>   hw/tpm/tpm_int.h                 | 22 +----------
>   hw/tpm/tpm_util.h                |  8 +++-
>   include/hw/qdev-properties.h     |  3 ++
>   include/sysemu/tpm.h             | 48 +++++++++++++++++------
>   include/sysemu/tpm_backend.h     | 32 ++++++----------
>   backends/tpm.c                   | 83 +++++++++++++------------------=
---------
>   hw/core/qdev-properties-system.c | 64 +++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c             | 14 ++++---
>   hw/tpm/tpm_emulator.c            | 59 +++++++++++++++-------------
>   hw/tpm/tpm_passthrough.c         | 66 +++++++++++--------------------=
-
>   hw/tpm/tpm_tis.c                 | 83 +++++++++++++++----------------=
---------
>   tpm.c                            | 34 ++++++----------
>   12 files changed, 255 insertions(+), 261 deletions(-)
>

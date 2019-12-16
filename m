Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C974DC2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8389720717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8389720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igv0U-0002DB-KM
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 13:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1iguzO-0001FP-3y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1iguzJ-0004e5-Lg
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:21:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21314
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1iguzJ-0004ct-DB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:20:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBGIIc3p003972
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 13:20:55 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe2pnxty-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 13:20:55 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBGIJ9RN005972
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 13:20:55 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wwe2pnxta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2019 13:20:55 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBGIEsGk011296;
 Mon, 16 Dec 2019 18:20:54 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03dal.us.ibm.com with ESMTP id 2wvqc6aqwx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2019 18:20:54 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBGIKqWa59048260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2019 18:20:53 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D13C478060;
 Mon, 16 Dec 2019 18:20:52 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FEE77805C;
 Mon, 16 Dec 2019 18:20:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 16 Dec 2019 18:20:52 +0000 (GMT)
Subject: Re: [PATCH] docs/specs/tpm: reST-ify TPM documentation
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191212145944.1921866-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <81eb3253-a1b5-ce23-c11a-299a29ec3f15@linux.ibm.com>
Date: Mon, 16 Dec 2019 13:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212145944.1921866-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_07:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912160154
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xBGIIc3p003972
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 9:59 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   docs/specs/index.rst |   1 +
>   docs/specs/tpm.rst   | 503 ++++++++++++++++++++++++++++++++++++++++++=
+
>   docs/specs/tpm.txt   | 445 --------------------------------------
>   3 files changed, 504 insertions(+), 445 deletions(-)
>   create mode 100644 docs/specs/tpm.rst
>   delete mode 100644 docs/specs/tpm.txt
>
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 984ba44029..de46a8b5e7 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -13,3 +13,4 @@ Contents:
>      ppc-xive
>      ppc-spapr-xive
>      acpi_hw_reduced_hotplug
> +   tpm
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> new file mode 100644
> index 0000000000..2bdf637f55
> --- /dev/null
> +++ b/docs/specs/tpm.rst
> @@ -0,0 +1,503 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +QEMU TPM Device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Guest-side hardware interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +TIS interface
> +-------------
> +
> +The QEMU TPM emulation implements a TPM TIS hardware interface
> +following the Trusted Computing Group's specification "TCG PC Client
> +Specific TPM Interface Specification (TIS)", Specification Version
> +1.3, 21 March 2013. (see the `TIS specification`_, or a later version
> +of it).
> +
> +The TIS interface makes a memory mapped IO region in the area
> +0xfed40000-0xfed44fff available to the guest operating system.
> +
> +QEMU files related to TPM TIS interface:
> + - ``hw/tpm/tpm_tis.c``
> + - ``hw/tpm/tpm_tis.h``
> +
> +CRB interface
> +-------------
> +
> +QEMU also implements a TPM CRB interface following the Trusted
> +Computing Group's specification "TCG PC Client Platform TPM Profile
> +(PTP) Specification", Family "2.0", Level 00 Revision 01.03 v22, May
> +22, 2017. (see the `CRB specification`_, or a later version of it)
> +
> +The CRB interface makes a memory mapped IO region in the area
> +0xfed40000-0xfed40fff (1 locality) available to the guest
> +operating system.
> +
> +QEMU files related to TPM CRB interface:
> + - ``hw/tpm/tpm_crb.c``
> +
> +SPAPR interface
> +---------------
> +
> +pSeries (ppc64) machines offer a tpm-spapr device model.
> +
> +QEMU files related to the SPAPR interface:
> + - ``hw/tpm/tpm_spapr.c``
> +
> +fw_cfg interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The bios/firmware may read the ``"etc/tpm/config"`` fw_cfg entry for
> +configuring the guest appropriately.
> +
> +The entry of 6 bytes has the following content, in little-endian:
> +
> +.. code-block:: c
> +
> +    #define TPM_VERSION_UNSPEC          0
> +    #define TPM_VERSION_1_2             1
> +    #define TPM_VERSION_2_0             2
> +
> +    #define TPM_PPI_VERSION_NONE        0
> +    #define TPM_PPI_VERSION_1_30        1
> +
> +    struct FwCfgTPMConfig {
> +        uint32_t tpmppi_address;         /* PPI memory location */
> +        uint8_t tpm_version;             /* TPM version */
> +        uint8_t tpmppi_version;          /* PPI version */
> +    };
> +
> +ACPI interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT
> +and passes it into the guest through the fw_cfg device. The device
> +description contains the base address of the TIS interface 0xfed40000
> +and the size of the MMIO area (0x5000). In case a TPM2 is used by
> +QEMU, a TPM2 ACPI table is also provided.  The device is described to
> +be used in polling mode rather than interrupt mode primarily because
> +no unused IRQ could be found.
> +
> +To support measurement logs to be written by the firmware,
> +e.g. SeaBIOS, a TCPA table is implemented. This table provides a 64kb
> +buffer where the firmware can write its log into. For TPM 2 only a
> +more recent version of the TPM2 table provides support for
> +measurements logs and a TCPA table does not need to be created.
> +
> +The TCPA and TPM2 ACPI tables follow the Trusted Computing Group
> +specification "TCG ACPI Specification" Family "1.2" and "2.0", Level
> +00 Revision 00.37. (see the `ACPI specification`_, or a later version
> +of it)
> +
> +ACPI PPI Interface
> +------------------
> +
> +QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and
> +TPM 2. This interface requires ACPI and firmware support. (see the
> +`PPI specification`_)
> +
> +PPI enables a system administrator (root) to request a modification to
> +the TPM upon reboot. The PPI specification defines the operation
> +requests and the actions the firmware has to take. The system
> +administrator passes the operation request number to the firmware
> +through an ACPI interface which writes this number to a memory
> +location that the firmware knows. Upon reboot, the firmware finds the
> +number and sends commands to the TPM. The firmware writes the TPM
> +result code and the operation request number to a memory location that
> +ACPI can read from and pass the result on to the administrator.
> +
> +The PPI specification defines a set of mandatory and optional
> +operations for the firmware to implement. The ACPI interface also
> +allows an administrator to list the supported operations. In QEMU the
> +ACPI code is generated by QEMU, yet the firmware needs to implement
> +support on a per-operations basis, and different firmwares may support
> +a different subset. Therefore, QEMU introduces the virtual memory
> +device for PPI where the firmware can indicate which operations it
> +supports and ACPI can enable the ones that are supported and disable
> +all others. This interface lies in main memory and has the following
> +layout:
> +
> + +-------------+--------+--------+------------------------------------=
-------+
> + |  Field      | Length | Offset | Description                        =
       |
> + +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=
=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> + | ``func``    |  0x100 |  0x000 | Firmware sets values for each suppo=
rted   |
> + |             |        |        | operation. See defined values below=
.      |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``ppin``    |   0x1  |  0x100 | SMI interrupt to use. Set by firmwa=
re.    |
> + |             |        |        | Not supported.                     =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``ppip``    |   0x4  |  0x101 | ACPI function index to pass to SMM =
code.  |
> + |             |        |        | Set by ACPI. Not supported.        =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``pprp``    |   0x4  |  0x105 | Result of last executed operation. =
Set by |
> + |             |        |        | firmware. See function index 5 for =
values.|
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``pprq``    |   0x4  |  0x109 | Operation request number to execute=
. See  |
> + |             |        |        | 'Physical Presence Interface Operat=
ion    |
> + |             |        |        | Summary' tables in specs. Set by AC=
PI.    |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``pprm``    |   0x4  |  0x10d | Operation request optional paramete=
r.     |
> + |             |        |        | Values depend on operation. Set by =
ACPI.  |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``lppr``    |   0x4  |  0x111 | Last executed operation request num=
ber.   |
> + |             |        |        | Copied from pprq field by firmware.=
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``fret``    |   0x4  |  0x115 | Result code from SMM function.     =
       |
> + |             |        |        | Not supported.                     =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``res1``    |  0x40  |  0x119 | Reserved for future use            =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + |``next_step``|   0x1  |  0x159 | Operation to execute after reboot b=
y      |
> + |             |        |        | firmware. Used by firmware.        =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> + | ``movv``    |   0x1  |  0x15a | Memory overwrite variable          =
       |
> + +-------------+--------+--------+------------------------------------=
-------+
> +
> +The following values are supported for the ``func`` field. They
> +correspond to the values used by ACPI function index 8.
> +
> + +----------+---------------------------------------------------------=
----+
> + | Value    | Description                                             =
    |
> + +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> + | 0        | Operation is not implemented.                           =
    |
> + +----------+---------------------------------------------------------=
----+
> + | 1        | Operation is only accessible through firmware.          =
    |
> + +----------+---------------------------------------------------------=
----+
> + | 2        | Operation is blocked for OS by firmware configuration.  =
    |
> + +----------+---------------------------------------------------------=
----+
> + | 3        | Operation is allowed and physically present user require=
d.  |
> + +----------+---------------------------------------------------------=
----+
> + | 4        | Operation is allowed and physically present user is not =
    |
> + |          | required.                                               =
    |
> + +----------+---------------------------------------------------------=
----+
> +
> +The location of the table is given by the fw_cfg ``tpmppi_address``
> +field.  The PPI memory region size is 0x400 (``TPM_PPI_ADDR_SIZE``) to
> +leave enough room for future updates.
> +
> +QEMU files related to TPM ACPI tables:
> + - ``hw/i386/acpi-build.c``
> + - ``include/hw/acpi/tpm.h``
> +
> +TPM backend devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TPM implementation is split into two parts, frontend and
> +backend. The frontend part is the hardware interface, such as the TPM
> +TIS interface described earlier, and the other part is the TPM backend
> +interface. The backend interfaces implement the interaction with a TPM
> +device, which may be a physical or an emulated device. The split
> +between the front- and backend devices allows a frontend to be
> +connected with any available backend. This enables the TIS interface
> +to be used with the passthrough backend or the swtpm backend.
> +
> +QEMU files related to TPM backends:
> + - ``backends/tpm.c``
> + - ``include/sysemu/tpm_backend.h``
> + - ``include/sysemu/tpm_backend_int.h``
> +
> +The QEMU TPM passthrough device
> +-------------------------------
> +
> +In case QEMU is run on Linux as the host operating system it is
> +possible to make the hardware TPM device available to a single QEMU
> +guest. In this case the user must make sure that no other program is
> +using the device, e.g., /dev/tpm0, before trying to start QEMU with
> +it.
> +
> +The passthrough driver uses the host's TPM device for sending TPM
> +commands and receiving responses from. Besides that it accesses the
> +TPM device's sysfs entry for support of command cancellation. Since
> +none of the state of a hardware TPM can be migrated between hosts,
> +virtual machine migration is disabled when the TPM passthrough driver
> +is used.
> +
> +Since the host's TPM device will already be initialized by the host's
> +firmware, certain commands, e.g. ``TPM_Startup()``, sent by the
> +virtual firmware for device initialization, will fail. In this case
> +the firmware should not use the TPM.
> +
> +Sharing the device with the host is generally not a recommended usage
> +scenario for a TPM device. The primary reason for this is that two
> +operating systems can then access the device's single set of
> +resources, such as platform configuration registers
> +(PCRs). Applications or kernel security subsystems, such as the Linux
> +Integrity Measurement Architecture (IMA), are not expecting to share
> +PCRs.
> +
> +QEMU files related to the TPM passthrough device:
> + - ``hw/tpm/tpm_passthrough.c``
> + - ``hw/tpm/tpm_util.c``
> + - ``hw/tpm/tpm_util.h``
> +
> +
> +Command line to start QEMU with the TPM passthrough device using the h=
ost's
> +hardware TPM ``/dev/tpm0``:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 -display sdl -accel kvm \
> +  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +  -tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm0 \
> +  -device tpm-tis,tpmdev=3Dtpm0 test.img
> +
> +
> +The following commands should result in similar output inside the VM
> +with a Linux kernel that either has the TPM TIS driver built-in or
> +available as a module:
> +
> +.. code-block:: console
> +
> +  # dmesg | grep -i tpm
> +  [    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> +
> +  # dmesg | grep TCPA
> +  [    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
> +      BXPCTCPA 0000001 BXPC 00000001)
> +
> +  # ls -l /dev/tpm*
> +  crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
> +
> +  # find /sys/devices/ | grep pcrs$ | xargs cat
> +  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> +  ...
> +  PCR-23: 00 00 00 00 00 00 00 00 ...
> +
> +The QEMU TPM emulator device
> +----------------------------
> +
> +The TPM emulator device uses an external TPM emulator called 'swtpm'
> +for sending TPM commands to and receiving responses from. The swtpm
> +program must have been started before trying to access it through the
> +TPM emulator with QEMU.
> +
> +The TPM emulator implements a command channel for transferring TPM
> +commands and responses as well as a control channel over which control
> +commands can be sent. (see the `SWTPM protocol`_ specification)
> +
> +The control channel serves the purpose of resetting, initializing, and
> +migrating the TPM state, among other things.
> +
> +The swtpm program behaves like a hardware TPM and therefore needs to
> +be initialized by the firmware running inside the QEMU virtual
> +machine.  One necessary step for initializing the device is to send
> +the TPM_Startup command to it. SeaBIOS, for example, has been
> +instrumented to initialize a TPM 1.2 or TPM 2 device using this
> +command.
> +
> +QEMU files related to the TPM emulator device:
> + - ``hw/tpm/tpm_emulator.c``
> + - ``hw/tpm/tpm_util.c``
> + - ``hw/tpm/tpm_util.h``
> +
> +The following commands start the swtpm with a UnixIO control channel o=
ver
> +a socket interface. They do not need to be run as root.
> +
> +.. code-block:: console
> +
> +  mkdir /tmp/mytpm1
> +  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +    --log level=3D20
> +
> +Command line to start QEMU with the TPM emulator device communicating
> +with the swtpm (x86):
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 -display sdl -accel kvm \
> +    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +    -device tpm-tis,tpmdev=3Dtpm0 test.img
> +
> +In case a pSeries machine is emulated, use the following command line:
> +
> +.. code-block:: console
> +
> +  qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
> +    -m 1024 -bios slof.bin -boot menu=3Don \
> +    -nodefaults -device VGA -device pci-ohci -device usb-kbd \
> +    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +    -device tpm-spapr,tpmdev=3Dtpm0 \
> +    -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
> +    -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Dd=
rive-virtio-disk0,id=3Dvirtio-disk0 \
> +    -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-di=
sk0
> +
> +In case SeaBIOS is used as firmware, it should show the TPM menu item
> +after entering the menu with 'ESC'.
> +
> +.. code-block:: console
> +
> +  Select boot device:
> +  1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
> +  [...]
> +  5. Legacy option rom
> +
> +  t. TPM Configuration
> +
> +The following commands should result in similar output inside the VM
> +with a Linux kernel that either has the TPM TIS driver built-in or
> +available as a module:
> +
> +.. code-block:: console
> +
> +  # dmesg | grep -i tpm
> +  [    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> +
> +  # dmesg | grep TCPA
> +  [    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
> +      BXPCTCPA 0000001 BXPC 00000001)
> +
> +  # ls -l /dev/tpm*
> +  crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
> +
> +  # find /sys/devices/ | grep pcrs$ | xargs cat
> +  PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> +  ...
> +  PCR-23: 00 00 00 00 00 00 00 00 ...
> +
> +Migration with the TPM emulator
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +The TPM emulator supports the following types of virtual machine
> +migration:
> +
> +- VM save / restore (migration into a file)
> +- Network migration
> +- Snapshotting (migration into storage like QoW2 or QED)
> +
> +The following command sequences can be used to test VM save / restore.
> +
> +In a 1st terminal start an instance of a swtpm using the following com=
mand:
> +
> +.. code-block:: console
> +
> +  mkdir /tmp/mytpm1
> +  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +    --log level=3D20 --tpm2
> +
> +In a 2nd terminal start the VM:
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 -display sdl -accel kvm \
> +    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +    -device tpm-tis,tpmdev=3Dtpm0 \
> +    -monitor stdio \
> +    test.img
> +
> +Verify that the attached TPM is working as expected using applications
> +inside the VM.
> +
> +To store the state of the VM use the following command in the QEMU
> +monitor in the 2nd terminal:
> +
> +.. code-block:: console
> +
> +  (qemu) migrate "exec:cat > testvm.bin"
> +  (qemu) quit
> +
> +At this point a file called ``testvm.bin`` should exists and the swtpm
> +and QEMU processes should have ended.
> +
> +To test 'VM restore' you have to start the swtpm with the same
> +parameters as before. If previously a TPM 2 [--tpm2] was saved, --tpm2
> +must now be passed again on the command line.
> +
> +In the 1st terminal restart the swtpm with the same command line as
> +before:
> +
> +.. code-block:: console
> +
> +  swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> +    --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> +    --log level=3D20 --tpm2
> +
> +In the 2nd terminal restore the state of the VM using the additional
> +'-incoming' option.
> +
> +.. code-block:: console
> +
> +  qemu-system-x86_64 -display sdl -accel kvm \
> +    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> +    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +    -device tpm-tis,tpmdev=3Dtpm0 \
> +    -incoming "exec:cat < testvm.bin" \
> +    test.img
> +
> +Troubleshooting migration
> +-------------------------
> +
> +There are several reasons why migration may fail. In case of problems,
> +please ensure that the command lines adhere to the following rules
> +and, if possible, that identical versions of QEMU and swtpm are used
> +at all times.
> +
> +VM save and restore:
> +
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on VM restore
> +
> + - swtpm command line parameters should be identical
> +
> +VM migration to 'localhost':
> +
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> +
> + - swtpm command line parameters should point to two different
> +   directories on the source and destination swtpm (--tpmstate dir=3D.=
..)
> +   (especially if different versions of libtpms were to be used on the
> +   same machine).
> +
> +VM migration across the network:
> +
> + - QEMU command line parameters should be identical apart from the
> +   '-incoming' option on the destination side
> +
> + - swtpm command line parameters should be identical
> +
> +VM Snapshotting:
> + - QEMU command line parameters should be identical
> +
> + - swtpm command line parameters should be identical
> +
> +
> +Besides that, migration failure reasons on the swtpm level may include
> +the following:
> +
> + - the versions of the swtpm on the source and destination sides are
> +   incompatible
> +
> +   - downgrading of TPM state may not be supported
> +
> +   - the source and destination libtpms were compiled with different
> +     compile-time options and the destination side refuses to accept t=
he
> +     state
> +
> + - different migration keys are used on the source and destination sid=
e
> +   and the destination side cannot decrypt the migrated state
> +   (swtpm ... --migration-key ... )
> +
> +
> +.. _TIS specification:
> +   https://trustedcomputinggroup.org/pc-client-work-group-pc-client-sp=
ecific-tpm-interface-specification-tis/
> +
> +.. _CRB specification:
> +   https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-p=
rofile-ptp-specification/
> +
> +
> +.. _ACPI specification:
> +   https://trustedcomputinggroup.org/tcg-acpi-specification/
> +
> +.. _PPI specification:
> +   https://trustedcomputinggroup.org/resource/tcg-physical-presence-in=
terface-specification/
> +
> +.. _SWTPM protocol:
> +   https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_io=
ctls.pod
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> deleted file mode 100644
> index 9c3e67d8a7..0000000000
> --- a/docs/specs/tpm.txt
> +++ /dev/null
> @@ -1,445 +0,0 @@
> -QEMU TPM Device
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -=3D Guest-side Hardware Interface =3D
> -
> -The QEMU TPM emulation implements a TPM TIS hardware interface followi=
ng the
> -Trusted Computing Group's specification "TCG PC Client Specific TPM In=
terface
> -Specification (TIS)", Specification Version 1.3, 21 March 2013. This
> -specification, or a later version of it, can be accessed from the foll=
owing
> -URL:
> -
> -https://trustedcomputinggroup.org/pc-client-work-group-pc-client-speci=
fic-tpm-interface-specification-tis/
> -
> -The TIS interface makes a memory mapped IO region in the area 0xfed400=
00 -
> -0xfed44fff available to the guest operating system.
> -
> -
> -QEMU files related to TPM TIS interface:
> - - hw/tpm/tpm_tis.c
> - - hw/tpm/tpm_tis.h
> -
> -
> -QEMU also implements a TPM CRB interface following the Trusted Computi=
ng
> -Group's specification "TCG PC Client Platform TPM Profile (PTP)
> -Specification", Family "2.0", Level 00 Revision 01.03 v22, May 22, 201=
7.
> -This specification, or a later version of it, can be accessed from the
> -following URL:
> -
> -https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-prof=
ile-ptp-specification/
> -
> -The CRB interface makes a memory mapped IO region in the area 0xfed400=
00 -
> -0xfed40fff (1 locality) available to the guest operating system.
> -
> -QEMU files related to TPM CRB interface:
> - - hw/tpm/tpm_crb.c
> -
> -
> -pSeries (ppc64) machines offer a tpm-spapr device model.
> -
> -QEMU files related to the SPAPR interface:
> - - hw/tpm/tpm_spapr.c
> -
> -=3D fw_cfg interface =3D
> -
> -The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
> -configuring the guest appropriately.
> -
> -The entry of 6 bytes has the following content, in little-endian:
> -
> -    #define TPM_VERSION_UNSPEC          0
> -    #define TPM_VERSION_1_2             1
> -    #define TPM_VERSION_2_0             2
> -
> -    #define TPM_PPI_VERSION_NONE        0
> -    #define TPM_PPI_VERSION_1_30        1
> -
> -    struct FwCfgTPMConfig {
> -        uint32_t tpmppi_address;         /* PPI memory location */
> -        uint8_t tpm_version;             /* TPM version */
> -        uint8_t tpmppi_version;          /* PPI version */
> -    };
> -
> -=3D ACPI Interface =3D
> -
> -The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT a=
nd passes
> -it into the guest through the fw_cfg device. The device description co=
ntains
> -the base address of the TIS interface 0xfed40000 and the size of the M=
MIO area
> -(0x5000). In case a TPM2 is used by QEMU, a TPM2 ACPI table is also pr=
ovided.
> -The device is described to be used in polling mode rather than interru=
pt mode
> -primarily because no unused IRQ could be found.
> -
> -To support measurement logs to be written by the firmware, e.g. SeaBIO=
S, a TCPA
> -table is implemented. This table provides a 64kb buffer where the firm=
ware can
> -write its log into. For TPM 2 only a more recent version of the TPM2 t=
able
> -provides support for measurements logs and a TCPA table does not need =
to be
> -created.
> -
> -The TCPA and TPM2 ACPI tables follow the Trusted Computing Group speci=
fication
> -"TCG ACPI Specification" Family "1.2" and "2.0", Level 00 Revision 00.=
37. This
> -specification, or a later version of it, can be accessed from the foll=
owing
> -URL:
> -
> -https://trustedcomputinggroup.org/tcg-acpi-specification/
> -
> -=3D=3D ACPI PPI Interface =3D=3D
> -
> -QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TP=
M 2. This
> -interface requires ACPI and firmware support. The specification can be=
 found at
> -the following URL:
> -
> -https://trustedcomputinggroup.org/resource/tcg-physical-presence-inter=
face-specification/
> -
> -PPI enables a system administrator (root) to request a modification to=
 the
> -TPM upon reboot. The PPI specification defines the operation requests =
and the
> -actions the firmware has to take. The system administrator passes the =
operation
> -request number to the firmware through an ACPI interface which writes =
this
> -number to a memory location that the firmware knows. Upon reboot, the =
firmware
> -finds the number and sends commands to the TPM. The firmware writes th=
e TPM
> -result code and the operation request number to a memory location that=
 ACPI can
> -read from and pass the result on to the administrator.
> -
> -The PPI specification defines a set of mandatory and optional operatio=
ns for
> -the firmware to implement. The ACPI interface also allows an administr=
ator to
> -list the supported operations. In QEMU the ACPI code is generated by Q=
EMU, yet
> -the firmware needs to implement support on a per-operations basis, and
> -different firmwares may support a different subset. Therefore, QEMU in=
troduces
> -the virtual memory device for PPI where the firmware can indicate whic=
h
> -operations it supports and ACPI can enable the ones that are supported=
 and
> -disable all others. This interface lies in main memory and has the fol=
lowing
> -layout:
> -
> - +----------+--------+--------+---------------------------------------=
----+
> - |  Field   | Length | Offset | Description                           =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | func     |  0x100 |  0x000 | Firmware sets values for each supporte=
d   |
> - |          |        |        | operation. See defined values below.  =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | ppin     |   0x1  |  0x100 | SMI interrupt to use. Set by firmware.=
    |
> - |          |        |        | Not supported.                        =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | ppip     |   0x4  |  0x101 | ACPI function index to pass to SMM cod=
e.  |
> - |          |        |        | Set by ACPI. Not supported.           =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | pprp     |   0x4  |  0x105 | Result of last executed operation. Set=
 by |
> - |          |        |        | firmware. See function index 5 for val=
ues.|
> - +----------+--------+--------+---------------------------------------=
----+
> - | pprq     |   0x4  |  0x109 | Operation request number to execute. S=
ee  |
> - |          |        |        | 'Physical Presence Interface Operation=
    |
> - |          |        |        | Summary' tables in specs. Set by ACPI.=
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | pprm     |   0x4  |  0x10d | Operation request optional parameter. =
    |
> - |          |        |        | Values depend on operation. Set by ACP=
I.  |
> - +----------+--------+--------+---------------------------------------=
----+
> - | lppr     |   0x4  |  0x111 | Last executed operation request number=
.   |
> - |          |        |        | Copied from pprq field by firmware.   =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | fret     |   0x4  |  0x115 | Result code from SMM function.        =
    |
> - |          |        |        | Not supported.                        =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | res1     |  0x40  |  0x119 | Reserved for future use               =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | next_step|   0x1  |  0x159 | Operation to execute after reboot by  =
    |
> - |          |        |        | firmware. Used by firmware.           =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> - | movv     |   0x1  |  0x15a | Memory overwrite variable             =
    |
> - +----------+--------+--------+---------------------------------------=
----+
> -
> -   The following values are supported for the 'func' field. They corre=
spond
> -   to the values used by ACPI function index 8.
> -
> - +----------+---------------------------------------------------------=
----+
> - | value    | Description                                             =
    |
> - +----------+---------------------------------------------------------=
----+
> - | 0        | Operation is not implemented.                           =
    |
> - +----------+---------------------------------------------------------=
----+
> - | 1        | Operation is only accessible through firmware.          =
    |
> - +----------+---------------------------------------------------------=
----+
> - | 2        | Operation is blocked for OS by firmware configuration.  =
    |
> - +----------+---------------------------------------------------------=
----+
> - | 3        | Operation is allowed and physically present user require=
d.  |
> - +----------+---------------------------------------------------------=
----+
> - | 4        | Operation is allowed and physically present user is not =
    |
> - |          | required.                                               =
    |
> - +----------+---------------------------------------------------------=
----+
> -
> -The location of the table is given by the fw_cfg tpmppi_address field.
> -The PPI memory region size is 0x400 (TPM_PPI_ADDR_SIZE) to leave
> -enough room for future updates.
> -
> -
> -QEMU files related to TPM ACPI tables:
> - - hw/i386/acpi-build.c
> - - include/hw/acpi/tpm.h
> -
> -
> -=3D TPM backend devices =3D
> -
> -The TPM implementation is split into two parts, frontend and backend. =
The
> -frontend part is the hardware interface, such as the TPM TIS interface
> -described earlier, and the other part is the TPM backend interface. Th=
e backend
> -interfaces implement the interaction with a TPM device, which may be a=
 physical
> -or an emulated device. The split between the front- and backend device=
s allows
> -a frontend to be connected with any available backend. This enables th=
e TIS
> -interface to be used with the passthrough backend or the (future) swtp=
m backend.
> -
> -
> -QEMU files related to TPM backends:
> - - backends/tpm.c
> - - include/sysemu/tpm_backend.h
> - - include/sysemu/tpm_backend_int.h
> -
> -
> -=3D=3D The QEMU TPM passthrough device =3D=3D
> -
> -In case QEMU is run on Linux as the host operating system it is possib=
le to
> -make the hardware TPM device available to a single QEMU guest. In this=
 case the
> -user must make sure that no other program is using the device, e.g., /=
dev/tpm0,
> -before trying to start QEMU with it.
> -
> -The passthrough driver uses the host's TPM device for sending TPM comm=
ands
> -and receiving responses from. Besides that it accesses the TPM device'=
s sysfs
> -entry for support of command cancellation. Since none of the state of =
a
> -hardware TPM can be migrated between hosts, virtual machine migration =
is
> -disabled when the TPM passthrough driver is used.
> -
> -Since the host's TPM device will already be initialized by the host's =
firmware,
> -certain commands, e.g. TPM_Startup(), sent by the virtual firmware for=
 device
> -initialization, will fail. In this case the firmware should not use th=
e TPM.
> -
> -Sharing the device with the host is generally not a recommended usage =
scenario
> -for a TPM device. The primary reason for this is that two operating sy=
stems can
> -then access the device's single set of resources, such as platform con=
figuration
> -registers (PCRs). Applications or kernel security subsystems, such as =
the
> -Linux Integrity Measurement Architecture (IMA), are not expecting to s=
hare PCRs.
> -
> -
> -QEMU files related to the TPM passthrough device:
> - - hw/tpm/tpm_passthrough.c
> - - hw/tpm/tpm_util.c
> - - hw/tpm/tpm_util.h
> -
> -
> -Command line to start QEMU with the TPM passthrough device using the h=
ost's
> -hardware TPM /dev/tpm0:
> -
> -qemu-system-x86_64 -display sdl -accel kvm \
> -  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> -  -tpmdev passthrough,id=3Dtpm0,path=3D/dev/tpm0 \
> -  -device tpm-tis,tpmdev=3Dtpm0 test.img
> -
> -The following commands should result in similar output inside the VM w=
ith a
> -Linux kernel that either has the TPM TIS driver built-in or available =
as a
> -module:
> -
> -#> dmesg | grep -i tpm
> -[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> -
> -#> dmesg | grep TCPA
> -[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
> -    BXPCTCPA 0000001 BXPC 00000001)
> -
> -#> ls -l /dev/tpm*
> -crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
> -
> -#> find /sys/devices/ | grep pcrs$ | xargs cat
> -PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> -...
> -PCR-23: 00 00 00 00 00 00 00 00 ...
> -
> -
> -=3D=3D The QEMU TPM emulator device =3D=3D
> -
> -The TPM emulator device uses an external TPM emulator called 'swtpm' f=
or
> -sending TPM commands to and receiving responses from. The swtpm progra=
m
> -must have been started before trying to access it through the TPM emul=
ator
> -with QEMU.
> -
> -The TPM emulator implements a command channel for transferring TPM com=
mands
> -and responses as well as a control channel over which control commands=
 can
> -be sent. The specification for the control channel can be found here:
> -
> -https://github.com/stefanberger/swtpm/blob/master/man/man3/swtpm_ioctl=
s.pod
> -
> -
> -The control channel serves the purpose of resetting, initializing, and
> -migrating the TPM state, among other things.
> -
> -The swtpm program behaves like a hardware TPM and therefore needs to b=
e
> -initialized by the firmware running inside the QEMU virtual machine.
> -One necessary step for initializing the device is to send the TPM_Star=
tup
> -command to it. SeaBIOS, for example, has been instrumented to initiali=
ze
> -a TPM 1.2 or TPM 2 device using this command.
> -
> -
> -QEMU files related to the TPM emulator device:
> - - hw/tpm/tpm_emulator.c
> - - hw/tpm/tpm_util.c
> - - hw/tpm/tpm_util.h
> -
> -
> -The following commands start the swtpm with a UnixIO control channel o=
ver
> -a socket interface. They do not need to be run as root.
> -
> -mkdir /tmp/mytpm1
> -swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> -  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> -  --log level=3D20
> -
> -Command line to start QEMU with the TPM emulator device communicating =
with
> -the swtpm (x86):
> -
> -qemu-system-x86_64 -display sdl -accel kvm \
> -  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> -  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> -  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> -  -device tpm-tis,tpmdev=3Dtpm0 test.img
> -
> -In case a pSeries machine is emulated, use the following command line:
> -
> -qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
> -  -m 1024 -bios slof.bin -boot menu=3Don \
> -  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
> -  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> -  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> -  -device tpm-spapr,tpmdev=3Dtpm0 \
> -  -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
> -  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddri=
ve-virtio-disk0,id=3Dvirtio-disk0 \
> -  -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk=
0
> -
> -
> -In case SeaBIOS is used as firmware, it should show the TPM menu item
> -after entering the menu with 'ESC'.
> -
> -Select boot device:
> -1. DVD/CD [ata1-0: QEMU DVD-ROM ATAPI-4 DVD/CD]
> -[...]
> -5. Legacy option rom
> -
> -t. TPM Configuration
> -
> -
> -The following commands should result in similar output inside the VM w=
ith a
> -Linux kernel that either has the TPM TIS driver built-in or available =
as a
> -module:
> -
> -#> dmesg | grep -i tpm
> -[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> -
> -#> dmesg | grep TCPA
> -[    0.000000] ACPI: TCPA 0x0000000003FFD191C 000032 (v02 BOCHS  \
> -    BXPCTCPA 0000001 BXPC 00000001)
> -
> -#> ls -l /dev/tpm*
> -crw-------. 1 root root 10, 224 Jul 11 10:11 /dev/tpm0
> -
> -#> find /sys/devices/ | grep pcrs$ | xargs cat
> -PCR-00: 35 4E 3B CE 23 9F 38 59 ...
> -...
> -PCR-23: 00 00 00 00 00 00 00 00 ...
> -
> -
> -=3D=3D=3D Migration with the TPM emulator =3D=3D=3D
> -
> -The TPM emulator supports the following types of virtual machine migra=
tion:
> -
> -- VM save / restore (migration into a file)
> -- Network migration
> -- Snapshotting (migration into storage like QoW2 or QED)
> -
> -The following command sequences can be used to test VM save / restore.
> -
> -
> -In a 1st terminal start an instance of a swtpm using the following com=
mand:
> -
> -mkdir /tmp/mytpm1
> -swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> -  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> -  --log level=3D20 --tpm2
> -
> -In a 2nd terminal start the VM:
> -
> -qemu-system-x86_64 -display sdl -accel kvm \
> -  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> -  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> -  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> -  -device tpm-tis,tpmdev=3Dtpm0 \
> -  -monitor stdio \
> -  test.img
> -
> -Verify that the attached TPM is working as expected using applications=
 inside
> -the VM.
> -
> -To store the state of the VM use the following command in the QEMU mon=
itor in
> -the 2nd terminal:
> -
> -(qemu) migrate "exec:cat > testvm.bin"
> -(qemu) quit
> -
> -At this point a file called 'testvm.bin' should exists and the swtpm a=
nd QEMU
> -processes should have ended.
> -
> -To test 'VM restore' you have to start the swtpm with the same paramet=
ers
> -as before. If previously a TPM 2 [--tpm2] was saved, --tpm2 must now b=
e
> -passed again on the command line.
> -
> -In the 1st terminal restart the swtpm with the same command line as be=
fore:
> -
> -swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
> -  --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
> -  --log level=3D20 --tpm2
> -
> -In the 2nd terminal restore the state of the VM using the additional
> -'-incoming' option.
> -
> -qemu-system-x86_64 -display sdl -accel kvm \
> -  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> -  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> -  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> -  -device tpm-tis,tpmdev=3Dtpm0 \
> -  -incoming "exec:cat < testvm.bin" \
> -  test.img
> -
> -
> -Troubleshooting migration:
> -
> -There are several reasons why migration may fail. In case of problems,
> -please ensure that the command lines adhere to the following rules and=
,
> -if possible, that identical versions of QEMU and swtpm are used at all
> -times.
> -
> -VM save and restore:
> - - QEMU command line parameters should be identical apart from the
> -   '-incoming' option on VM restore
> - - swtpm command line parameters should be identical
> -
> -VM migration to 'localhost':
> - - QEMU command line parameters should be identical apart from the
> -   '-incoming' option on the destination side
> - - swtpm command line parameters should point to two different
> -   directories on the source and destination swtpm (--tpmstate dir=3D.=
..)
> -   (especially if different versions of libtpms were to be used on the
> -   same machine).
> -
> -VM migration across the network:
> - - QEMU command line parameters should be identical apart from the
> -   '-incoming' option on the destination side
> - - swtpm command line parameters should be identical
> -
> -VM Snapshotting:
> - - QEMU command line parameters should be identical
> - - swtpm command line parameters should be identical
> -
> -
> -Besides that, migration failure reasons on the swtpm level may include
> -the following:
> -
> - - the versions of the swtpm on the source and destination sides are
> -   incompatible
> -   - downgrading of TPM state may not be supported
> -   - the source and destination libtpms were compiled with different
> -     compile-time options and the destination side refuses to accept t=
he
> -     state
> - - different migration keys are used on the source and destination sid=
e
> -   and the destination side cannot decrypt the migrated state
> -   (swtpm ... --migration-key ... )




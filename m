Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF01FC7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838122080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838122080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho7x6-00038o-H0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40071)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1ho7wq-0002Vq-OD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1ho7wp-0001Pn-E5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1ho7wm-0001Mr-DW; Thu, 18 Jul 2019 11:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAE5530C1E34;
 Thu, 18 Jul 2019 15:03:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-84.ams2.redhat.com
 [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD7A63C20;
 Thu, 18 Jul 2019 15:03:25 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5e6b8a67-8f8a-3e3b-4f42-db2a31c03ad1@redhat.com>
Date: Thu, 18 Jul 2019 17:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190718104837.13905-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 15:03:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/18/19 12:48, Philippe Mathieu-Daud=C3=A9 wrote:
> To avoid incoherent states when the machine resets (see but report

(1) For the PULL request, please fix the typo: s/but/bug/

> below), add the device reset callback.
>=20
> A "system reset" sets the device state machine in READ_ARRAY mode
> and, after some delay, set the SR.7 READY bit.
>=20
> Since we do not model timings, we set the SR.7 bit directly.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 435be1e35c..a1ec1faae5 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -865,6 +865,24 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>      pfl->cfi_table[0x3f] =3D 0x01; /* Number of protection fields */
>  }
> =20
> +static void pflash_cfi01_system_reset(DeviceState *dev)
> +{
> +    PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
> +
> +    /*
> +     * The command 0x00 is not assigned by the CFI open standard,
> +     * but QEMU historically uses it for the READ_ARRAY command (0xff)=
.
> +     */
> +    pfl->cmd =3D 0x00;
> +    pfl->wcycle =3D 0;
> +    memory_region_rom_device_set_romd(&pfl->mem, true);
> +    /*
> +     * The WSM ready timer occurs at most 150ns after system reset.
> +     * This model deliberately ignores this delay.
> +     */
> +    pfl->status =3D 0x80;
> +}
> +
>  static Property pflash_cfi01_properties[] =3D {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>      /* num-blocks is the number of blocks actually visible to the gues=
t,
> @@ -909,6 +927,7 @@ static void pflash_cfi01_class_init(ObjectClass *kl=
ass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    dc->reset =3D pflash_cfi01_system_reset;
>      dc->realize =3D pflash_cfi01_realize;
>      dc->props =3D pflash_cfi01_properties;
>      dc->vmsd =3D &vmstate_pflash;
>=20

(2) Reviewed-by: Laszlo Ersek <lersek@redhat.com>

A *future* improvement (meant just for this surgical reset handler --
not meaning any large cfi01 overhaul!) could be the addition of a trace
point, at the top of pflash_cfi01_system_reset().

But that is strictly "nice to have", and not necessary to include in the
present bugfix.


(3) Using OVMF IA32X64 (including the edk2 SMM stack), I've
regression-tested this patch, on top of v4.1.0-rc1, with KVM. As follows:

(3a) Normal reboot from the UEFI shell ("reset -c" command)

(3b) Normal reboot from the Linux guest prompt ("reboot" command)

(3c1) Reset as part of ACPI S3 suspend/resume
(3c2) then use "efibootmgr -n / -N" to write to pflash (by virtue of
setting / deleting the standardized BootNext UEFI variable)

(3d1) Boot to setup TUI with SB enabled
(3d2) erase Platform Key in setup TUI (disables SB)
(3d3) reboot from within setup TUI
(3d4) proceed to UEFI shell
(3d5) enable SB with EnrollDefaultKeys.efi
(3d6) reboot from UEFI shell
(3d7) proceeed to Linux guest
(3d8) verify SB enablement (dmesg, "mokutil --sb-state")

(As an added exercise, step (3d4) triggered an "FTW" (fault tolerant
write) "reclaim" (basically a defragmentation of the journaled
"filesystem" that the firmware keeps in the flash, as a logical "middle
layer"), and that worked fine too.)

Regression-tested-by: Laszlo Ersek <lersek@redhat.com>


(4) I plan to provide R-t-b in the evening from aarch64 KVM too, using
the edk2 ArmVirtQemu firmware. Only the first two steps from (3) will be
covered (no ACPI S3, no SB).

Thanks!
Laszlo


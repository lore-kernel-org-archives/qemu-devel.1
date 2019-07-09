Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A57C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA9A2082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA9A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknQ3-0007Gs-2u
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hknOU-0006kR-P7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hknOS-0007lb-US
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:30:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hknOL-0007a9-4Z; Tue, 09 Jul 2019 06:30:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B52D130BD1B3;
 Tue,  9 Jul 2019 10:30:30 +0000 (UTC)
Received: from work-vm (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA961608A4;
 Tue,  9 Jul 2019 10:30:24 +0000 (UTC)
Date: Tue, 9 Jul 2019 11:30:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190709103022.GA2766@work-vm>
References: <20190705154639.16591-1-philmd@redhat.com>
 <20190705154639.16591-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190705154639.16591-3-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 09 Jul 2019 10:30:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/9] hw/block/pflash_cfi01: Use the
 correct READ_ARRAY value
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> In the "Read Array Flowchart" the command has a value of 0xFF.
>=20
> In the document [*] the "Read Array Flowchart", the READ_ARRAY
> command has a value of 0xff.
>=20
> Use the correct value in the pflash model.
>=20
> There is no change of behavior in the guest, because:
> - when the guest were sending 0xFF, the reset_flash label
>   was setting the command value as 0x00
> - 0x00 was used internally for READ_ARRAY
>=20
> To keep migration behaving correctly, we have to increase
> the VMState version. When migrating from an older version,
> we use the correct command value.

The problem is that incrementing the version will break backwards
compatibility; so you won't be able to migrate this back to an older
QEMU version; so for example a q35/uefi with this won't be able
to migrate backwards to a 4.0.0 or older qemu.

So instead of bumping the version_id you probably need to wire
the behaviour to a machine type and then on your new type
wire a subsection containing a flag; the reception of that subsection
tells you to use the new/correct semantics.


Dave


> [*] "Common Flash Interface (CFI) and Command Sets"
>     (Intel Application Note 646)
>     Appendix B "Basic Command Set"
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> v3: Handle migrating the 'cmd' field.
>=20
> Since Laszlo stated he did not test migration [*], I'm keeping his
> test tag, because the change with v2 has no impact in the tests
> he ran.
>=20
> Likewise I'm keeping John and Alistair tags, but I'd like an extra
> review for the migration change, thanks!
>=20
> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.html
> ---
>  hw/block/pflash_cfi01.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9e34fd4e82..58cbef0588 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -100,7 +100,7 @@ static int pflash_post_load(void *opaque, int versi=
on_id);
> =20
>  static const VMStateDescription vmstate_pflash =3D {
>      .name =3D "pflash_cfi01",
> -    .version_id =3D 1,
> +    .version_id =3D 2,
>      .minimum_version_id =3D 1,
>      .post_load =3D pflash_post_load,
>      .fields =3D (VMStateField[]) {
> @@ -277,10 +277,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwad=
dr offset,
>          /* This should never happen : reset state & treat it as a read=
 */
>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd)=
;
>          pfl->wcycle =3D 0;
> -        pfl->cmd =3D 0;
> +        pfl->cmd =3D 0xff;
>          /* fall through to read code */
> -    case 0x00:
> -        /* Flash area read */
> +    case 0xff: /* Read Array */
>          ret =3D pflash_data_read(pfl, offset, width, be);
>          break;
>      case 0x10: /* Single byte program */
> @@ -448,8 +447,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x00: /* ??? */
> -            goto reset_flash;
>          case 0x10: /* Single Byte Program */
>          case 0x40: /* Single Byte Program */
>              DPRINTF("%s: Single Byte Program\n", __func__);
> @@ -526,7 +523,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>              if (cmd =3D=3D 0xd0) { /* confirm */
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) { /* read array mode */
> +            } else if (cmd =3D=3D 0xff) { /* Read Array */
>                  goto reset_flash;
>              } else
>                  goto error_flash;
> @@ -553,7 +550,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>              } else if (cmd =3D=3D 0x01) {
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) {
> +            } else if (cmd =3D=3D 0xff) { /* read array mode */
>                  goto reset_flash;
>              } else {
>                  DPRINTF("%s: Unknown (un)locking command\n", __func__)=
;
> @@ -645,7 +642,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>      trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>  }
> =20
> =20
> @@ -761,7 +758,7 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>      }
> =20
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>      pfl->status =3D 0;
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> @@ -1001,5 +998,11 @@ static int pflash_post_load(void *opaque, int ver=
sion_id)
>          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_upd=
ate_cb,
>                                                          pfl);
>      }
> +    if (version_id < 2) {
> +        /* v1 used incorrect value of 0x00 for the READ_ARRAY command.=
 */
> +        if (pfl->cmd =3D=3D 0x00) {
> +            pfl->cmd =3D  0xff;
> +        }
> +    }
>      return 0;
>  }
> --=20
> 2.20.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


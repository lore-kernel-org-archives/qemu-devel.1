Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97DC74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA4B20645
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA4B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlc6E-0002zL-JA
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 12:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlc62-0002UF-CS
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlc60-0005Mq-Tw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:39:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hlc5x-0005HA-KE; Thu, 11 Jul 2019 12:38:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 052553179B76;
 Thu, 11 Jul 2019 16:38:56 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B11C5C230;
 Thu, 11 Jul 2019 16:38:32 +0000 (UTC)
Date: Thu, 11 Jul 2019 17:38:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190711163829.GQ3971@work-vm>
References: <20190711155703.15627-1-philmd@redhat.com>
 <20190711155703.15627-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190711155703.15627-3-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 11 Jul 2019 16:38:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 2/5] hw/block/pflash_cfi01: Use
 the correct READ_ARRAY value
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
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 John Snow <jsnow@redhat.com>
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
> To keep migration with older versions behaving correctly, we
> decide to always migrate the READ_ARRAY as 0x00.
>=20
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
> v4: Handle migrating to older QEMU (Dave)
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
>  hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9e34fd4e82..85bb2132c0 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -96,6 +96,37 @@ struct PFlashCFI01 {
>      bool old_multiple_chip_handling;
>  };
> =20
> +static int pflash_pre_save(void *opaque)
> +{
> +    PFlashCFI01 *s =3D opaque;
> +
> +    /*
> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for t=
he
> +     * READ_ARRAY command. To preserve migrating to these older versio=
n,
> +     * always migrate the READ_ARRAY command as 0x00.
> +     */
> +    if (s->cmd =3D=3D 0xff) {
> +        s->cmd =3D 0x00;
> +    }
> +
> +    return 0;
> +}
> +
> +static int pflash_post_save(void *opaque)
> +{
> +    PFlashCFI01 *s =3D opaque;
> +
> +    /*
> +     * If migration failed, the guest will continue to run.
> +     * Restore the correct READ_ARRAY value.
> +     */
> +    if (s->cmd =3D=3D 0x00) {
> +        s->cmd =3D 0xff;
> +    }

OK, from a migration point of view I think we're OK, as long
as you never have a valid situation where cmd was 0x00 and
it's now suddenly going to become 0xff.

Dave

> +    return 0;
> +}
> +
>  static int pflash_post_load(void *opaque, int version_id);
> =20
>  static const VMStateDescription vmstate_pflash =3D {
> @@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash =3D =
{
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .post_load =3D pflash_post_load,
> +    .pre_save =3D pflash_pre_save,
> +    .post_save =3D pflash_post_save,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT8(wcycle, PFlashCFI01),
>          VMSTATE_UINT8(cmd, PFlashCFI01),
> @@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwad=
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
> @@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x00: /* ??? */
> -            goto reset_flash;
>          case 0x10: /* Single Byte Program */
>          case 0x40: /* Single Byte Program */
>              DPRINTF("%s: Single Byte Program\n", __func__);
> @@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>              if (cmd =3D=3D 0xd0) { /* confirm */
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) { /* read array mode */
> +            } else if (cmd =3D=3D 0xff) { /* Read Array */
>                  goto reset_flash;
>              } else
>                  goto error_flash;
> @@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
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
> @@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
>      trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>  }
> =20
> =20
> @@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>      }
> =20
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>      pfl->status =3D 0;
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> @@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int ve=
rsion_id)
>          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_upd=
ate_cb,
>                                                          pfl);
>      }
> +
> +    /*
> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for t=
he
> +     * READ_ARRAY command.
> +     */
> +    if (pfl->cmd =3D=3D 0x00) {
> +        pfl->cmd =3D 0xff;
> +    }
> +
>      return 0;
>  }
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


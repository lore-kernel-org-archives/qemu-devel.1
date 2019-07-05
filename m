Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3223C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A8B21670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A8B21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjROj-0001x8-0j
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hjRMP-0000dW-2l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hjRMM-0003r2-3G
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hjRME-0003HL-3X; Fri, 05 Jul 2019 12:46:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4408C59442;
 Fri,  5 Jul 2019 16:46:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-244.ams2.redhat.com
 [10.36.116.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4822548D7D;
 Fri,  5 Jul 2019 16:46:35 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190705154639.16591-1-philmd@redhat.com>
 <20190705154639.16591-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7e314f4c-0b3f-245a-c4e5-44c68c2c572f@redhat.com>
Date: Fri, 5 Jul 2019 18:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190705154639.16591-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 16:46:42 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/19 17:46, Philippe Mathieu-Daud=C3=A9 wrote:
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
>=20
> [*] "Common Flash Interface (CFI) and Command Sets"
>     (Intel Application Note 646)
>     Appendix B "Basic Command Set"
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: Handle migrating the 'cmd' field.
>=20
> Since Laszlo stated he did not test migration [*], I'm keeping his
> test tag, because the change with v2 has no impact in the tests
> he ran.

My thinking exactly. Thanks!
Laszlo

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
>=20



Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C350C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7ACF20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7ACF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMX8-0007x6-U1
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hnMWt-0007HW-GG
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hnMWr-0000qi-Nv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:25:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hnMWo-0000mQ-3X; Tue, 16 Jul 2019 08:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 17DDF3082129;
 Tue, 16 Jul 2019 12:25:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B4C7600C4;
 Tue, 16 Jul 2019 12:25:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FB5711386A0; Tue, 16 Jul 2019 14:25:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190715121338.20600-1-philmd@redhat.com>
 <20190715121338.20600-3-philmd@redhat.com>
Date: Tue, 16 Jul 2019 14:25:44 +0200
In-Reply-To: <20190715121338.20600-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 15 Jul 2019 14:13:35
 +0200")
Message-ID: <87o91u2mk7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 16 Jul 2019 12:25:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/5] hw/block/pflash_cfi01: Use the
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe asked me to have a look at this one, so here goes.

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> In the document [*] the "Read Array Flowchart", the READ_ARRAY
> command has a value of 0xff.
>
> Use the correct value in the pflash model.
>
> There is no change of behavior in the guest, because:
> - when the guest were sending 0xFF, the reset_flash label
>   was setting the command value as 0x00
> - 0x00 was used internally for READ_ARRAY

*Groan*

Is this cleanup, or does it fix an observable bug?

> To keep migration with older versions behaving correctly, we
> decide to always migrate the READ_ARRAY as 0x00.
>
> If the CFI open standard decide to assign a new command of value
> 0x00, this model is flawed because it uses this value internally.
> If a guest eventually requires this new CFI feature, a different
> model will be required (or this same model but breaking backward
> migration). So it is safe to keep migrating READ_ARRAY as 0x00.

We could perhaps keep migration working for "benign" device states, with
judicious use of subsections.  We'll cross that bridge when we get to
it.

> [*] "Common Flash Interface (CFI) and Command Sets"
>     (Intel Application Note 646)
>     Appendix B "Basic Command Set"
>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3: Handle migrating the 'cmd' field.
> v4: Handle migrating to older QEMU (Dave)
> v5: Add a paragraph about why this model is flawed due to
>     historically using READ_ARRAY as 0x00 (Dave, Peter).
>
> Since Laszlo stated he did not test migration [*], I'm keeping his
> test tag, because the change with v2 has no impact in the tests
> he ran.
>
> Likewise I'm keeping John and Alistair tags, but I'd like an extra
> review for the migration change, thanks!
>
> [*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.html
> ---
>  hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 48 insertions(+), 9 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9e34fd4e82..85bb2132c0 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -96,6 +96,37 @@ struct PFlashCFI01 {
>      bool old_multiple_chip_handling;
>  };
>=20=20
> +static int pflash_pre_save(void *opaque)
> +{
> +    PFlashCFI01 *s =3D opaque;
> +
> +    /*
> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
> +     * READ_ARRAY command. To preserve migrating to these older version,
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
> +
> +    return 0;
> +}

Uh, this gives me a queasy feeling.  Perhaps David can assuage it.

I figure the intent is to migrate PFlashCFI01 member @cmd value 0xFF as
0x00, for migration compatibility to and from older versions.

You do this by monkey-patching it to 0x00 before migration, and to 0xFF
afterwards.  On the incoming side, you replace 0x00 by 0xFF, in
pflash_post_load() below.

Questions:

* Can anything but the code that sends @cmd see the temporary 0x00 value
  between pflash_pre_save() and pflash_post_save()

* Consider the matrix source \in { old, new } x dest \in { old, new } x
  @cmd on source in { 0x00, 0xFF }.  What does migration put into @cmd
  on dest?  Eight cases:

  source @cmd  ->  wire  ->  dest @cmd
    old  0x00  ->  0x00  ->  old  0x00  (1)
                             new  0xFF  (2)
    old  0xFF  ->  0xFF  ->  old  0xFF  (3)
                             new  0xFF  (4)
    new  0x00  ->  0x00  ->  old  0x00  (5)
                             new  0xFF  (6)
    new  0xFF  ->  0x00  ->  old  0x00  (7)
                             new  0xFF  (8)

  Old -> old (cases 1 and 3) is unaffected by this patch.

  New -> new leaves 0xFF unchanged (8).  It changes 0x00 to 0xFF (6).
  Uh-oh.  Can this happen?  Rephrasing the question: can @cmd ever be
  0x00 with this patch applied?

  Old -> new leaves 0xFF unchanged (4).  It changes 0x00 to 0xFF (2),
  which I think is intentional.

  New -> old leaves 0x00 unchanged (5).  It changes 0xFF to 0x00 (7),
  which I think is intentional.

  Old -> new -> old leaves 0x00 unchanged.  Good.  It changes 0xFF to
  0x00.  Uh-oh.  Can @cmd ever be 0xFF before this patch?

  New -> old -> new leaves 0xFF unchanged.  Good.  It changes 0x00 to
  0xFF.  Same uh-oh as for new -> new.

> +
>  static int pflash_post_load(void *opaque, int version_id);
>=20=20
>  static const VMStateDescription vmstate_pflash =3D {
> @@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash =3D {
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .post_load =3D pflash_post_load,
> +    .pre_save =3D pflash_pre_save,
> +    .post_save =3D pflash_post_save,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT8(wcycle, PFlashCFI01),
>          VMSTATE_UINT8(cmd, PFlashCFI01),
> @@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr=
 offset,
>          /* This should never happen : reset state & treat it as a read */
>          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
>          pfl->wcycle =3D 0;
> -        pfl->cmd =3D 0;
> +        pfl->cmd =3D 0xff;
>          /* fall through to read code */
> -    case 0x00:
> -        /* Flash area read */
> +    case 0xff: /* Read Array */
>          ret =3D pflash_data_read(pfl, offset, width, be);
>          break;

On 0xFF, we no longer zap pfl->wcycle and pfl->cmd.

On 0x00, we do.

We zap pfl->cmd to 0xFF instead of 0x00.  Same below after label
error_flash and reset_flash.  Related: initialization to 0xFF instead of
0x00 in pflash_cfi01_realize().  I *guess* these changes together ensure
pfl->cmd can't become 0x00.  Correct?

>      case 0x10: /* Single byte program */
> @@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>      case 0:
>          /* read mode */
>          switch (cmd) {
> -        case 0x00: /* ??? */
> -            goto reset_flash;

On 0x00, we now use default: goto error_flash.  Can this happen?

>          case 0x10: /* Single Byte Program */
>          case 0x40: /* Single Byte Program */
>              DPRINTF("%s: Single Byte Program\n", __func__);
> @@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              if (cmd =3D=3D 0xd0) { /* confirm */
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) { /* read array mode */
> +            } else if (cmd =3D=3D 0xff) { /* Read Array */
>                  goto reset_flash;
>              } else
>                  goto error_flash;
> @@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
>              } else if (cmd =3D=3D 0x01) {
>                  pfl->wcycle =3D 0;
>                  pfl->status |=3D 0x80;
> -            } else if (cmd =3D=3D 0xff) {
> +            } else if (cmd =3D=3D 0xff) { /* read array mode */

Your new comment is phrased the way you corrected in the previous hunk.
Intentional?

>                  goto reset_flash;
>              } else {
>                  DPRINTF("%s: Unknown (un)locking command\n", __func__);
> @@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
    error_flash:
       qemu_log_mask(LOG_UNIMP, "%s: Unimplemented flash cmd sequence "
                     "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x valu=
e 0x%x)"
                     "\n", __func__, offset, pfl->wcycle, pfl->cmd, value);

    reset_flash:
>      trace_pflash_reset();
>      memory_region_rom_device_set_romd(&pfl->mem, true);
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>  }
>=20=20
>=20=20
> @@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev, Er=
ror **errp)
>      }
>=20=20
>      pfl->wcycle =3D 0;
> -    pfl->cmd =3D 0;
> +    pfl->cmd =3D 0xff;
>      pfl->status =3D 0;
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
> @@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int vers=
ion_id)
>          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_updat=
e_cb,
>                                                          pfl);
>      }
> +
> +    /*
> +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for the
> +     * READ_ARRAY command.
> +     */
> +    if (pfl->cmd =3D=3D 0x00) {
> +        pfl->cmd =3D 0xff;
> +    }
> +
>      return 0;
>  }


Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32324C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB3920880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB3920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnO56-0000uV-9N
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hnO4t-0000RK-Cs
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hnO4m-000887-I1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hnO4h-000859-P1; Tue, 16 Jul 2019 10:04:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45FA8307D914;
 Tue, 16 Jul 2019 14:04:58 +0000 (UTC)
Received: from work-vm (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C00A1001B2C;
 Tue, 16 Jul 2019 14:04:51 +0000 (UTC)
Date: Tue, 16 Jul 2019 15:04:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190716140443.GE2770@work-vm>
References: <20190715121338.20600-1-philmd@redhat.com>
 <20190715121338.20600-3-philmd@redhat.com>
 <87o91u2mk7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o91u2mk7.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 16 Jul 2019 14:04:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
 qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
> Philippe asked me to have a look at this one, so here goes.
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > In the document [*] the "Read Array Flowchart", the READ_ARRAY
> > command has a value of 0xff.
> >
> > Use the correct value in the pflash model.
> >
> > There is no change of behavior in the guest, because:
> > - when the guest were sending 0xFF, the reset_flash label
> >   was setting the command value as 0x00
> > - 0x00 was used internally for READ_ARRAY
>=20
> *Groan*
>=20
> Is this cleanup, or does it fix an observable bug?
>=20
> > To keep migration with older versions behaving correctly, we
> > decide to always migrate the READ_ARRAY as 0x00.
> >
> > If the CFI open standard decide to assign a new command of value
> > 0x00, this model is flawed because it uses this value internally.
> > If a guest eventually requires this new CFI feature, a different
> > model will be required (or this same model but breaking backward
> > migration). So it is safe to keep migrating READ_ARRAY as 0x00.
>=20
> We could perhaps keep migration working for "benign" device states, wit=
h
> judicious use of subsections.  We'll cross that bridge when we get to
> it.
>=20
> > [*] "Common Flash Interface (CFI) and Command Sets"
> >     (Intel Application Note 646)
> >     Appendix B "Basic Command Set"
> >
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > v3: Handle migrating the 'cmd' field.
> > v4: Handle migrating to older QEMU (Dave)
> > v5: Add a paragraph about why this model is flawed due to
> >     historically using READ_ARRAY as 0x00 (Dave, Peter).
> >
> > Since Laszlo stated he did not test migration [*], I'm keeping his
> > test tag, because the change with v2 has no impact in the tests
> > he ran.
> >
> > Likewise I'm keeping John and Alistair tags, but I'd like an extra
> > review for the migration change, thanks!
> >
> > [*] https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg00679.ht=
ml
> > ---
> >  hw/block/pflash_cfi01.c | 57 ++++++++++++++++++++++++++++++++++-----=
--
> >  1 file changed, 48 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> > index 9e34fd4e82..85bb2132c0 100644
> > --- a/hw/block/pflash_cfi01.c
> > +++ b/hw/block/pflash_cfi01.c
> > @@ -96,6 +96,37 @@ struct PFlashCFI01 {
> >      bool old_multiple_chip_handling;
> >  };
> > =20
> > +static int pflash_pre_save(void *opaque)
> > +{
> > +    PFlashCFI01 *s =3D opaque;
> > +
> > +    /*
> > +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for=
 the
> > +     * READ_ARRAY command. To preserve migrating to these older vers=
ion,
> > +     * always migrate the READ_ARRAY command as 0x00.
> > +     */
> > +    if (s->cmd =3D=3D 0xff) {
> > +        s->cmd =3D 0x00;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int pflash_post_save(void *opaque)
> > +{
> > +    PFlashCFI01 *s =3D opaque;
> > +
> > +    /*
> > +     * If migration failed, the guest will continue to run.
> > +     * Restore the correct READ_ARRAY value.
> > +     */
> > +    if (s->cmd =3D=3D 0x00) {
> > +        s->cmd =3D 0xff;
> > +    }
> > +
> > +    return 0;
> > +}
>=20
> Uh, this gives me a queasy feeling.  Perhaps David can assuage it.

See the previous 4 versions of discussion....

> I figure the intent is to migrate PFlashCFI01 member @cmd value 0xFF as
> 0x00, for migration compatibility to and from older versions.
>=20
> You do this by monkey-patching it to 0x00 before migration, and to 0xFF
> afterwards.  On the incoming side, you replace 0x00 by 0xFF, in
> pflash_post_load() below.
>=20
> Questions:
>=20
> * Can anything but the code that sends @cmd see the temporary 0x00 valu=
e
>   between pflash_pre_save() and pflash_post_save()

It is the same pflash data structure; but all CPUs are stopped and we're
just walking the list of devices serialising them; so no nothing should
be seeing that value.
(There is another way to do this, which is to produce a temporary
structure at this point, populate the temporary structure and migrate
that)

Dave

> * Consider the matrix source \in { old, new } x dest \in { old, new } x
>   @cmd on source in { 0x00, 0xFF }.  What does migration put into @cmd
>   on dest?  Eight cases:
>=20
>   source @cmd  ->  wire  ->  dest @cmd
>     old  0x00  ->  0x00  ->  old  0x00  (1)
>                              new  0xFF  (2)
>     old  0xFF  ->  0xFF  ->  old  0xFF  (3)
>                              new  0xFF  (4)
>     new  0x00  ->  0x00  ->  old  0x00  (5)
>                              new  0xFF  (6)
>     new  0xFF  ->  0x00  ->  old  0x00  (7)
>                              new  0xFF  (8)
>=20
>   Old -> old (cases 1 and 3) is unaffected by this patch.
>=20
>   New -> new leaves 0xFF unchanged (8).  It changes 0x00 to 0xFF (6).
>   Uh-oh.  Can this happen?  Rephrasing the question: can @cmd ever be
>   0x00 with this patch applied?
>=20
>   Old -> new leaves 0xFF unchanged (4).  It changes 0x00 to 0xFF (2),
>   which I think is intentional.
>=20
>   New -> old leaves 0x00 unchanged (5).  It changes 0xFF to 0x00 (7),
>   which I think is intentional.
>=20
>   Old -> new -> old leaves 0x00 unchanged.  Good.  It changes 0xFF to
>   0x00.  Uh-oh.  Can @cmd ever be 0xFF before this patch?
>=20
>   New -> old -> new leaves 0xFF unchanged.  Good.  It changes 0x00 to
>   0xFF.  Same uh-oh as for new -> new.
>=20
> > +
> >  static int pflash_post_load(void *opaque, int version_id);
> > =20
> >  static const VMStateDescription vmstate_pflash =3D {
> > @@ -103,6 +134,8 @@ static const VMStateDescription vmstate_pflash =3D=
 {
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .post_load =3D pflash_post_load,
> > +    .pre_save =3D pflash_pre_save,
> > +    .post_save =3D pflash_post_save,
> >      .fields =3D (VMStateField[]) {
> >          VMSTATE_UINT8(wcycle, PFlashCFI01),
> >          VMSTATE_UINT8(cmd, PFlashCFI01),
> > @@ -277,10 +310,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hw=
addr offset,
> >          /* This should never happen : reset state & treat it as a re=
ad */
> >          DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cm=
d);
> >          pfl->wcycle =3D 0;
> > -        pfl->cmd =3D 0;
> > +        pfl->cmd =3D 0xff;
> >          /* fall through to read code */
> > -    case 0x00:
> > -        /* Flash area read */
> > +    case 0xff: /* Read Array */
> >          ret =3D pflash_data_read(pfl, offset, width, be);
> >          break;
>=20
> On 0xFF, we no longer zap pfl->wcycle and pfl->cmd.
>=20
> On 0x00, we do.
>=20
> We zap pfl->cmd to 0xFF instead of 0x00.  Same below after label
> error_flash and reset_flash.  Related: initialization to 0xFF instead o=
f
> 0x00 in pflash_cfi01_realize().  I *guess* these changes together ensur=
e
> pfl->cmd can't become 0x00.  Correct?
>=20
> >      case 0x10: /* Single byte program */
> > @@ -448,8 +480,6 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
> >      case 0:
> >          /* read mode */
> >          switch (cmd) {
> > -        case 0x00: /* ??? */
> > -            goto reset_flash;
>=20
> On 0x00, we now use default: goto error_flash.  Can this happen?
>=20
> >          case 0x10: /* Single Byte Program */
> >          case 0x40: /* Single Byte Program */
> >              DPRINTF("%s: Single Byte Program\n", __func__);
> > @@ -526,7 +556,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
> >              if (cmd =3D=3D 0xd0) { /* confirm */
> >                  pfl->wcycle =3D 0;
> >                  pfl->status |=3D 0x80;
> > -            } else if (cmd =3D=3D 0xff) { /* read array mode */
> > +            } else if (cmd =3D=3D 0xff) { /* Read Array */
> >                  goto reset_flash;
> >              } else
> >                  goto error_flash;
> > @@ -553,7 +583,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
> >              } else if (cmd =3D=3D 0x01) {
> >                  pfl->wcycle =3D 0;
> >                  pfl->status |=3D 0x80;
> > -            } else if (cmd =3D=3D 0xff) {
> > +            } else if (cmd =3D=3D 0xff) { /* read array mode */
>=20
> Your new comment is phrased the way you corrected in the previous hunk.
> Intentional?
>=20
> >                  goto reset_flash;
> >              } else {
> >                  DPRINTF("%s: Unknown (un)locking command\n", __func_=
_);
> > @@ -645,7 +675,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr=
 offset,
>     error_flash:
>        qemu_log_mask(LOG_UNIMP, "%s: Unimplemented flash cmd sequence "
>                      "(offset " TARGET_FMT_plx ", wcycle 0x%x cmd 0x%x =
value 0x%x)"
>                      "\n", __func__, offset, pfl->wcycle, pfl->cmd, val=
ue);
>=20
>     reset_flash:
> >      trace_pflash_reset();
> >      memory_region_rom_device_set_romd(&pfl->mem, true);
> >      pfl->wcycle =3D 0;
> > -    pfl->cmd =3D 0;
> > +    pfl->cmd =3D 0xff;
> >  }
> > =20
> > =20
> > @@ -761,7 +791,7 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
> >      }
> > =20
> >      pfl->wcycle =3D 0;
> > -    pfl->cmd =3D 0;
> > +    pfl->cmd =3D 0xff;
> >      pfl->status =3D 0;
> >      /* Hardcoded CFI table */
> >      /* Standard "QRY" string */
> > @@ -1001,5 +1031,14 @@ static int pflash_post_load(void *opaque, int =
version_id)
> >          pfl->vmstate =3D qemu_add_vm_change_state_handler(postload_u=
pdate_cb,
> >                                                          pfl);
> >      }
> > +
> > +    /*
> > +     * Previous to QEMU v4.1 an incorrect value of 0x00 was used for=
 the
> > +     * READ_ARRAY command.
> > +     */
> > +    if (pfl->cmd =3D=3D 0x00) {
> > +        pfl->cmd =3D 0xff;
> > +    }
> > +
> >      return 0;
> >  }
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


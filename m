Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50633C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2458820651
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2458820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktkK-0002eT-Ro
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hktdw-0005wN-Jv
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hktdv-0000ps-85
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 13:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hktdY-0000GY-Cq; Tue, 09 Jul 2019 13:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7182E30C7467;
 Tue,  9 Jul 2019 17:10:12 +0000 (UTC)
Received: from work-vm (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2201871C7;
 Tue,  9 Jul 2019 17:10:05 +0000 (UTC)
Date: Tue, 9 Jul 2019 18:10:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190709171002.GJ2725@work-vm>
References: <20190705154639.16591-1-philmd@redhat.com>
 <20190705154639.16591-3-philmd@redhat.com>
 <20190709103022.GA2766@work-vm>
 <dd8dd585-9774-78d4-17ee-89b30c81a0c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dd8dd585-9774-78d4-17ee-89b30c81a0c4@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 09 Jul 2019 17:10:12 +0000 (UTC)
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
> Hi David,
>=20
> On 7/9/19 12:30 PM, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> >> In the "Read Array Flowchart" the command has a value of 0xFF.
> >>
> >> In the document [*] the "Read Array Flowchart", the READ_ARRAY
> >> command has a value of 0xff.
> >>
> >> Use the correct value in the pflash model.
> >>
> >> There is no change of behavior in the guest, because:
> >> - when the guest were sending 0xFF, the reset_flash label
> >>   was setting the command value as 0x00
> >> - 0x00 was used internally for READ_ARRAY
> >>
> >> To keep migration behaving correctly, we have to increase
> >> the VMState version. When migrating from an older version,
> >> we use the correct command value.
> >=20
> > The problem is that incrementing the version will break backwards
> > compatibility; so you won't be able to migrate this back to an older
> > QEMU version; so for example a q35/uefi with this won't be able
> > to migrate backwards to a 4.0.0 or older qemu.
> >=20
> > So instead of bumping the version_id you probably need to wire
> > the behaviour to a machine type and then on your new type
> > wire a subsection containing a flag; the reception of that subsection
> > tells you to use the new/correct semantics.
>=20
> I'm starting to understand VMState subsections, but it might be overkill
> for this change...
>=20
>   Subsections
>   -----------
>=20
>   The most common structure change is adding new data, e.g. when adding
>   a newer form of device, or adding that state that you previously
>   forgot to migrate.  This is best solved using a subsection.
>=20
> This is not the case here, the field is already present and migrated.
>=20
> It seems I can use a simple pre_save hook, always migrating the
> READ_ARRAY using the incorrect value:
>=20
> -- >8 --
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -97,12 +97,29 @@ struct PFlashCFI01 {
>      bool incorrect_read_array_command;
>  };
>=20
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

Be careful what happens if migration fails and you continue on the
source - is that OK - or are you going to have to flip that back somehow
(in a post_save).

Another way to do the same is to have a dummy field; tmp_cmd, and the
tmp_cmd is the thing that's actually migrated and filled by pre_save
(or use VMSTATE_WITH_TMP )


>  static int pflash_post_load(void *opaque, int version_id);
>=20
>  static const VMStateDescription vmstate_pflash =3D {
>      .name =3D "pflash_cfi01",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .pre_save =3D pflash_pre_save,
>      .post_load =3D pflash_post_load,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT8(wcycle, PFlashCFI01),
> @@ -1001,5 +1018,14 @@ static int pflash_post_load(void *opaque, int
> version_id)
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
> ---
>=20
> Being simpler and less intrusive (no new property in hw/core/machine.c),
> is this acceptable?

=46rom the migration point of view yes; I don't know enough about pflash
to say if it makes sense;  for example could there ever be a 00 command
really used and then you'd have to distinguish that somehow?

> Thanks,
>=20
> Phil.
>=20
> [...]
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB227C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88939217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88939217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDteS-0000wf-HX
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iDtDY-0002Ry-AK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iDtDV-0000Jw-Of
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iDtDL-0007cO-Hd; Fri, 27 Sep 2019 12:35:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F257E30BBE89;
 Fri, 27 Sep 2019 16:35:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07A06646A1;
 Fri, 27 Sep 2019 16:35:19 +0000 (UTC)
Message-ID: <e00e9b05d0d4f7c1a33c06a5fbd2d32320394b07.camel@redhat.com>
Subject: Re: [PATCH] tests: fix I/O test for hosts defaulting to LUKSv2
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 27 Sep 2019 19:35:17 +0300
In-Reply-To: <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
References: <20190927101155.25896-1-berrange@redhat.com>
 <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 27 Sep 2019 16:35:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-27 at 10:26 -0500, Eric Blake wrote:
> On 9/27/19 5:11 AM, Daniel P. Berrang=C3=A9 wrote:
> > Some distros are now defaulting to LUKS version 2 which QEMU cannot
> > process. For our I/O test that validates interoperability between the
> > kernel/cryptsetup and QEMU, we need to explicitly ask for version 1
> > of the LUKS format.
> >=20
>=20
> Ultimately, it would be nice to get LUKS 2 support in qemu too, but=20
> that's a much bigger job.  This is fine for now.
>=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >   tests/qemu-iotests/149     |  2 +-
> >   tests/qemu-iotests/149.out | 44 +++++++++++++++++++----------------=
---
> >   2 files changed, 23 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> > index 4f363f295f..8ab42e94c6 100755
> > --- a/tests/qemu-iotests/149
> > +++ b/tests/qemu-iotests/149
> > @@ -153,7 +153,7 @@ def cryptsetup_format(config):
> >  =20
> >       (password, slot) =3D config.first_password()
> >  =20
> > -    args =3D ["luksFormat"]
> > +    args =3D ["luksFormat", "--type", "luks1"]
>=20
> On Fedora 29, 'cryptsetup --help | grep -A1 type' shows:
>    -M, --type=3DSTRING               Type of device metadata: luks, pla=
in,
>                                    loopaes, tcrypt
>=20
> but that is just 'luks', not 'luks1'.
>=20
> On CentOS 6 (yeah, I know, not relevenant to qemu any more), --type is=20
> unsupported.  But I didn't check our other range of supported systems.=20
> My point, however, is whether this patch needs to be conditionalized=20
> based on what cryptsetup actually supports.
>=20
> I could not quickly determine if there is some sort of safe no-op=20
> 'cryptsetup --type=3DFOO action /safe/device' that can be used to tell =
if=20
> --type=3DFOO is recognized.
>=20
> Otherwise, this makes sense to me.
>=20

I just tested this on Fedora 28, here it works,


I also see the same message:

[mlevitsk@maximlenovopc ~/USERSPACE/qemu/src/tests/qemu-iotests]$cryptset=
up --help | grep -A1 type
  -M, --type=3DSTRING                     Type of device metadata: luks, =
plain,
                                        loopaes, tcrypt
--
	open <device> [--type <type>] [<name>] - open device as mapping <name>
	close <name> - close device (remove mapping)


I guess the documentation was not updated?

I tested both by running the iotest 149, and by doing manually:

dd if=3D/dev/zero bs=3D4K count=3D1000 of=3D./test
cryptsetup -q -v luksFormat --type luks1 --cipher aes-xts-plain64 --key-s=
ize 512 --hash sha1 --key-slot 0 --key-file - --iter-time 10 ./test


Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




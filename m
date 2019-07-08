Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC7C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0E02064A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 12:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0E02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkT8b-000201-At
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 08:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hkT7f-0001PC-Mb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hkT7c-0007LA-2O
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 08:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hkT7U-0007FF-Fa; Mon, 08 Jul 2019 08:51:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B1D4308429B;
 Mon,  8 Jul 2019 12:51:40 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C23125798D;
 Mon,  8 Jul 2019 12:51:35 +0000 (UTC)
Message-ID: <7eeafe074290d5374b5ad6c0fc81d1c0dea492e1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 08 Jul 2019 15:51:34 +0300
In-Reply-To: <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
 <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
 <5d32c846-1ff6-ec99-af20-8e7a794c4fe2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 08 Jul 2019 12:51:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] block/nvme: don't touch the
 completion entries
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-08 at 14:23 +0200, Max Reitz wrote:
> On 07.07.19 10:43, Maxim Levitsky wrote:
> > On Fri, 2019-07-05 at 13:03 +0200, Max Reitz wrote:
> > > On 03.07.19 17:59, Maxim Levitsky wrote:
> > > > Completion entries are meant to be only read by the host and writ=
ten by the device.
> > > > The driver is supposed to scan the completions from the last poin=
t where it left,
> > > > and until it sees a completion with non flipped phase bit.
> > >=20
> > > (Disclaimer: This is the first time I read the nvme driver, or real=
ly
> > > something in the nvme spec.)
> > >=20
> > > Well, no, completion entries are also meant to be initialized by th=
e
> > > host.  To me it looks like this is the place where that happens:
> > > Everything that has been processed by the device is immediately bei=
ng
> > > re-initialized.
> > >=20
> > > Maybe we shouldn=E2=80=99t do that here but in nvme_submit_command(=
).  But
> > > currently we don=E2=80=99t, and I don=E2=80=99t see any other place=
 where we currently
> > > initialize the CQ entries.
> >=20
> > Hi!
> > I couldn't find any place in the spec that says that completion entri=
es should be initialized.
> > It is probably wise to initialize that area to 0 on driver initializa=
tion, but nothing beyond that.
>=20
> Ah, you=E2=80=99re right, I misread.  I didn=E2=80=99t pay as much atte=
ntion to the
> =E2=80=9C...prior to setting CC.EN to =E2=80=981=E2=80=99=E2=80=9D as I=
 should have.  Yep, and that is
> done in nvme_init_queue().
>=20
> OK, I cease my wrongful protest:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> >=20

Thank you very much!
BTW, the qemu driver does allocate zeroed memory (in nvme_init_queue,=20
"q->queue =3D qemu_try_blockalign0(bs, bytes);"

Thus I think this is all that is needed in that regard.

Note that this patch doesn't fix any real bug I know of,=20
but just makes the thing right in regard to the spec.
Also racing with hardware in theory can have various memory ordering bugs=
,
although in this case the writes are done in=20
entries which controller probably won't touch, but still.

TL;DR - no need in code which does nothing and might cause issues.

Do you want me to resend the series or shall I wait till we decide
what to do with the image creation support? I done fixing all the
review comments long ago, just didn't want to resend the series.
Or shall I drop that patch and resend?

From the urgency standpoint the only patch that really should
be merged ASAP is the one that adds support for block sizes,
because without it, the whole thing crashes and burns on 4K
nvme drives.

Best regards,
	Maxim Levitsky






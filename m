Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D40C0650E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033BF2082F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033BF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk35X-0003ul-8R
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 05:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hk34k-0003Ll-G3
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hk34j-0006Mc-Bk
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hk34c-0006ED-Lm; Sun, 07 Jul 2019 05:03:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31F8C308FBA6;
 Sun,  7 Jul 2019 09:03:05 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9F05D70D;
 Sun,  7 Jul 2019 09:03:00 +0000 (UTC)
Message-ID: <f53af77fcd36c1147642761791162e99ac7fedde.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jul 2019 12:03:00 +0300
In-Reply-To: <fdd3554a-c972-68eb-bac1-058c726df66e@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-5-mlevitsk@redhat.com>
 <fdd3554a-c972-68eb-bac1-058c726df66e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Sun, 07 Jul 2019 09:03:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/6] block/nvme: add support for image
 creation
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

On Fri, 2019-07-05 at 14:09 +0200, Max Reitz wrote:
> On 03.07.19 17:59, Maxim Levitsky wrote:
> > Tesed on a nvme device like that:
> >=20
> > # create preallocated qcow2 image
> > $ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=
=3Dmetadata
> > Formatting 'nvme://0000:06:00.0/1', fmt=3Dqcow2 size=3D10737418240 cl=
uster_size=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff refcount=
_bits=3D16
> >=20
> > # create an empty qcow2 image
> > $ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=
=3Doff
> > Formatting 'nvme://0000:06:00.0/1', fmt=3Dqcow2 size=3D10737418240 cl=
uster_size=3D65536 preallocation=3Doff lazy_refcounts=3Doff refcount_bits=
=3D16
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++=
++
> >  1 file changed, 108 insertions(+)
>=20
> Hm.  I=E2=80=99m not quite sure I like this, because this is not image =
creation.

I fully agree with you, and the whole thing did felt kind of wrong.
I kind of think that bdrv_co_create_opts is kind of outdated for the purp=
ose, especially
with the nvme driver.
I think that it would be better if the bdrv_file_open just supported some=
thing like 'O_CREAT'.

I done this the mostly the same was as the file-posix does this on the bl=
ock devices,
including that 'hack' of zeroing the first sector, for which I really don=
't know if this is the right solution.



>=20
> What we need is a general interface for formatting existing files.  I
> mean, we have that in QMP (blockdev-create), but the problem is that
> this doesn=E2=80=99t really translate to qemu-img create.
>=20
> I wonder whether it=E2=80=99s best to hack something up that makes
> bdrv_create_file() a no-op, or whether we should expose blockdev-create
> over qemu-img.  I=E2=80=99ll see how difficult the latter is, it sounds=
 fun
> (famous last words).
For existing images, the 'bdrv_create_file' is already kind of a nop, oth=
er that zeroing the first sector,
which kind of makes sense, but probably best done on higher level than in=
 each driver.

So these are my thoughts about this, thanks for the review!

Best regards,
	Maxim Levitsky



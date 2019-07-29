Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E495C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E3D206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 14:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E3D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs6zX-0007Fk-NV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 10:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35988)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hs6z5-0006jd-86
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hs6z4-0007DD-B6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hs6z2-0007BO-5P; Mon, 29 Jul 2019 10:50:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A440308FC47;
 Mon, 29 Jul 2019 14:50:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED1A10016E9;
 Mon, 29 Jul 2019 14:50:36 +0000 (UTC)
Message-ID: <17b1a45e4377cb5a54b67ac7429b0924742468af.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Date: Mon, 29 Jul 2019 17:50:35 +0300
In-Reply-To: <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
References: <20190722172616.28797-1-mreitz@redhat.com>
 <20190722172616.28797-3-mreitz@redhat.com>
 <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 29 Jul 2019 14:50:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 2/5] block/nvme: support larger
 that 512 bytes sector devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-29 at 14:16 +0100, Peter Maydell wrote:
> On Mon, 22 Jul 2019 at 18:26, Max Reitz <mreitz@redhat.com> wrote:
> > 
> > From: Maxim Levitsky <mlevitsk@redhat.com>
> > 
> > Currently the driver hardcodes the sector size to 512,
> > and doesn't check the underlying device. Fix that.
> > 
> > Also fail if underlying nvme device is formatted with metadata
> > as this needs special support.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Message-id: 20190716163020.13383-3-mlevitsk@redhat.com
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > +static int64_t nvme_get_blocksize(BlockDriverState *bs)
> > +{
> > +    BDRVNVMeState *s = bs->opaque;
> > +    assert(s->blkshift >= BDRV_SECTOR_BITS);
> > +    return 1 << s->blkshift;
> > +}
> 
> Hi -- Coverity points out here that we calculate the
> "1 << s->blkshift" as a 32-bit shift, but then return an
> int64_t type (CID 1403771).
> 
> Can the blkshift ever really be 31 or more ?

In theory, in the spec it is a 8 bit field, in practice, it should not be larger
that 12, because at least Linux doesn't support at all block devices that have
larger that 4K block size.

Best regards,
	Maxim Levitsky

> 
> The types here seem weird anyway -- we return an int64_t,
> but the only user of this is nvme_probe_blocksizes(),
> which uses the value only to set BlockSizes::phys and ::log,
> both of which are of type "uint32_t". That leads me to think
> that the right return type for the function is uint32_t.
> 
> PS: this is the only Coverity issue currently outstanding so
> if it's a trivial fix it might be nice to put it into rc3.
> 
> thanks
> -- PMM
> 




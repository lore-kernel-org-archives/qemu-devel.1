Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A320C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10554206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10554206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7To-0007Z1-BB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hs79H-0007df-Jf
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hs79G-0006kQ-Cq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hs799-0006Xr-1M; Mon, 29 Jul 2019 11:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D6EF30C1325;
 Mon, 29 Jul 2019 15:01:06 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1735D9C3;
 Mon, 29 Jul 2019 15:01:04 +0000 (UTC)
Message-ID: <a3b01bf8158a2c4759a527662982c58e5c2494d0.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 18:01:03 +0300
In-Reply-To: <e8da41f1-8e8c-c9b2-b34f-545c6e2c2ce0@redhat.com>
References: <20190722172616.28797-1-mreitz@redhat.com>
 <20190722172616.28797-3-mreitz@redhat.com>
 <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
 <e8da41f1-8e8c-c9b2-b34f-545c6e2c2ce0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 29 Jul 2019 15:01:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/5] block/nvme: support larger that 512
 bytes sector devices
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

On Mon, 2019-07-29 at 15:25 +0200, Max Reitz wrote:
> On 29.07.19 15:16, Peter Maydell wrote:
> > On Mon, 22 Jul 2019 at 18:26, Max Reitz <mreitz@redhat.com> wrote:
> > > 
> > > From: Maxim Levitsky <mlevitsk@redhat.com>
> > > 
> > > Currently the driver hardcodes the sector size to 512,
> > > and doesn't check the underlying device. Fix that.
> > > 
> > > Also fail if underlying nvme device is formatted with metadata
> > > as this needs special support.
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > Message-id: 20190716163020.13383-3-mlevitsk@redhat.com
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > +static int64_t nvme_get_blocksize(BlockDriverState *bs)
> > > +{
> > > +    BDRVNVMeState *s = bs->opaque;
> > > +    assert(s->blkshift >= BDRV_SECTOR_BITS);
> > > +    return 1 << s->blkshift;
> > > +}
> > 
> > Hi -- Coverity points out here that we calculate the
> > "1 << s->blkshift" as a 32-bit shift, but then return an
> > int64_t type (CID 1403771).
> > 
> > Can the blkshift ever really be 31 or more ?
> > 
> > The types here seem weird anyway -- we return an int64_t,
> > but the only user of this is nvme_probe_blocksizes(),
> > which uses the value only to set BlockSizes::phys and ::log,
> > both of which are of type "uint32_t". That leads me to think
> > that the right return type for the function is uint32_t.
> > 
> > PS: this is the only Coverity issue currently outstanding so
> > if it's a trivial fix it might be nice to put it into rc3.
> 
> Maxim, what do you think?

Fully agree with that.

> 
> How about we let nvme_identify() limit blkshift to something sane and
> then return a uint32_t here?
> 
> In theory it would be limited by page_size, and that has a maximum value
> of 2^27.  In practice, though, that limit is checked by another 32-bit
> shift...

2^27 is the maximum NVME page size, but in theory, but only in theory,
you can have blocks larger that a page size, you will just have to give the controller
more that one page, even when you read a single block.

But like I said in the other mail, Linux doesn't support at all block size > cpu page size which is almost always 4K,
thus 12 is the practical limit for the block size these days, and of course both 27 and 31 is well above this.

So I'll send a patch to fix this today or tomorrow.

Best regards,
	Maxim Levitsky

> Max
> 




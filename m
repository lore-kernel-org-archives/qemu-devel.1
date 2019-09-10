Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9944C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC40D207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC40D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7e5h-00086l-Vn
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7e4A-0006s3-AY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7e49-0000Bo-BP
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:12:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7e47-0000AY-6p; Tue, 10 Sep 2019 07:12:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F68A800DEB;
 Tue, 10 Sep 2019 11:12:06 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 046B65D9D6;
 Tue, 10 Sep 2019 11:12:01 +0000 (UTC)
Message-ID: <0c3a04b8b7aaae75230e1b37c5b2fae7800fec4a.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Date: Tue, 10 Sep 2019 14:12:00 +0300
In-Reply-To: <20190909105655.GE17606@localhost.localdomain>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
 <20190906173201.7926-3-mlevitsk@redhat.com>
 <3ac8c65d-4bca-372c-d863-1f794292f5cb@redhat.com>
 <20190909105655.GE17606@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 10 Sep 2019 11:12:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH 2/3] block/qcow2: fix the
 corruption when rebasing luks encrypted files
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-09 at 12:56 +0200, Kevin Wolf wrote:
> Am 06.09.2019 um 21:17 hat Eric Blake geschrieben:
> > > -        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
> > > +        assert((guest_offset & ~BDRV_SECTOR_MASK) == 0);
> > > +        assert((host_offset & ~BDRV_SECTOR_MASK) == 0);
> > >          assert((bytes & ~BDRV_SECTOR_MASK) == 0);
> > 
> > Pre-existing, but we could use QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE) for
> > slightly more legibility than open-coding the bit operation.
> > 
> > Neat trick about power-of-2 alignment checks:
> > 
> > assert(QEMU_IS_ALIGNED(offset_in_cluster | guest_offset |
> >                        host_offset | bytes, BDRV_SECTOR_SIZE));
> > 
> > gives the same result in one assertion.  (I've used it elsewhere in the
> > code base, but I'm not opposed to one assert per variable if you think
> > batching is too dense.)
> 
> A possible downside of this is that if a user reports an assertion
> failure, you can't tell any more which of the variables ended up in a
> bad state.
> 
> If you're lucky, you can still tell in gdb at least if the bug is
> reproducible, but I wouldn't be surprised if in release builds, half of
> the variables were actually optimised away, so that even this wouldn't
> work.
Agreed. I guess I'll keep the separate asserts anyway after all, even though
I prefer shorter code.


Best regards,
	Maxim Levitsky





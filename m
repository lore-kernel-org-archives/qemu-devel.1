Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B642C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FB22074B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="h5czAFxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FB22074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ba-0003sq-Pl
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kO0TN-0004Gh-DV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:26:21 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kO0TL-0001S0-4v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=qYgzZrvpyPxCSKcgAfCn/Un5ciUE/MnPCt0dtkTv94E=; b=h5czAFxzPuYbGPoMdrTk1RgOK/
 gv1vEsqZtcYQQ5F6SLEDByWlo/Dy4RVaz4R9Dftjp3a5z2yZ4/hICbU1lTgdclEVOt1iZLT5vU+mh
 ulLTpers62Hh1Hv82b/PSdAryC4Zy3gATzmM9KEDjoTGCBLG/7Kt9a5XOyFKh6q8FIYHPpkY2i1QF
 kZNmcpwkXzn48RG5pG7v/HS24M8B5jtqtxAmqYrKvWbXXtOq9E8qYsfts5aOSfHP4LZQnQm+bt0Hy
 PPZ/e55RfxRLvbNY9LbkwqlwU2PYhpwFPx98S0HkvakmD5KKAVFUCByKmDpfabuP8fFliSsbLw9KI
 RwcWLojw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
Date: Thu, 01 Oct 2020 17:26:13 +0200
Message-ID: <4474985.DjIeONRcyu@silver>
In-Reply-To: <bbfcbc42-a7f4-926f-78ef-badcb7c023af@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <12227378.mPQFScNTDJ@silver>
 <bbfcbc42-a7f4-926f-78ef-badcb7c023af@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 11:26:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 1. Oktober 2020 16:04:39 CEST Paolo Bonzini wrote:
> >> You're right, this is in fact also a problem for virtio-blk and virtio-
net:
> >>     /* FIXME: every test using these two nodes needs to setup a
> >>     
> >>      * -drive,id=drive0 otherwise QEMU is not going to start.
> >>      * Therefore, we do not include "produces" edge for virtio
> >>      * and pci-device yet.
> >>     
> >>     */
> >>     
> >>     /* FIXME: every test using these nodes needs to setup a
> >>     
> >>      * -netdev socket,id=hs0 otherwise QEMU is not going to start.
> >>      * Therefore, we do not include "produces" edge for virtio
> >>      * and pci-device yet.
> >>      */
> >> 
> >> I still think we should do it like this, because it's closer to the way
> >> that libqos will work long term.
> > 
> > Could you please elaborate why that long term plan bites with the working
> > solution I provided? [patches 1 and 2]
> 
> Because the long term plan is to have a socket/plug mechanism for
> backends where the device can provide a default backend to plug.

Ok, obviously I don't know the details of that future socket/plug plan, but 
what I could also imagine for the long-term: allowing to optionally define 
'config' nodes as subnodes of devices. Maybe that's similar to what you had in 
mind with that socket/plug model.

> The suggested solution is all good for *a different use case*, namely to
> test the same device with different options.  It is just wrong for the
> purpose of selecting a frontend.
> 
> It occurred to me that you could also add a default backend to the
> command line with "-fsdev" (in the libqos driver), and use -set in the
> test to override it.  This is ugly (-set is ugly!) but it would let you
> keep the tests, so it would probably be the best solution.

Ok, I'll have a look at that '*-set' alternative tomorrow.

But on doubt: I will simply disable those the implied pci and virtio tests for 
the time being.

I need the 'local' backend tests and have to move on; they are of much more 
value than those 2 implied pci and virtio tests.

Best regards,
Christian Schoenebeck




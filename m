Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E272208E4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fIaoc7gU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E272208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZIsS-0007lU-KR
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 14:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZIrT-0007Cd-Ia
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:17:55 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:45591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kZIrR-0000vC-52
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7SpEP3Nn5KYdAwaVncvg+43PvrnVQau3AK/m0QlgX5A=; b=fIaoc7gUYi6DWEWVrLjCXG6oZ9
 hbpd+Ma+0cyhUK2dJ7zZ1Ua0dkGf653Nrhpaq+w7WnE3rcyIbGVjCq7xzQFlI11Y7hoLizl7LDYIz
 rXbxSW9vMtkfqs/kJzRKO1v8DGMEChHeYVUDQIdNFRa07VNIf5QW0V0XprD9obQwCbmFyL41hN5dY
 a09kbILxZNCnP5RU5zM0/Xug1OOX++9Q0k5aHInFrNkgrsQtyHDo943RO76tbrPy5jGj0VlUPOjqm
 PjLn4Khrn/CysbwNH+iR1+enWZKvPNCO9EbiR0qI1Y/wyyxnyHCCtPfMXfx7t5E/HPsWA94zI11Y1
 y7wNyNzw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 0/2] 9pfs: test suite fixes
Date: Sun, 01 Nov 2020 20:17:50 +0100
Message-ID: <2977702.F8LXnbqENp@silver>
In-Reply-To: <061f1d9c-86d8-76b9-b868-59749542d9a2@ilande.co.uk>
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
 <061f1d9c-86d8-76b9-b868-59749542d9a2@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 14:14:18
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

On Sonntag, 1. November 2020 19:02:28 CET Mark Cave-Ayland wrote:
> On 01/11/2020 15:12, Christian Schoenebeck wrote:
> > Fixes test failures with the 9pfs 'local' tests as discussed with latest
> > 9P PR. See the discussion of that PR v2 (Fri, Oct 30th) for details.
> > 
> > In conjunction with Peter Xu's two migration patches (fixing occasional
> > lockups of migration tests) overall situation appears to be smooth now:
> > https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/
> > 
> > v2->v3:
> >    - Make the two functions for creating and removing the 9pfs test
> >    directory
> >    
> >      public [NEW patch 1].
> >    
> >    - Place the constructor and destructor functions in virtio-9p-test.c,
> >    not
> >    
> >      in virtio-9p.c, because the latter location would cause the
> >      constructor
> >      to be executed whenever libqos is loaded, which would break other,
> >      completely unrelated tests suites that just link to libqos [patch 2].
> >    
> >    - Previous patch 2 (coverity fix) is already queued, no changes, hence
> >    
> >      omitted in this v3.
> > 
> > v1->v2:
> >    - Added Greg's tested-by tag [patch 1].
> >    
> >    - Log an info-level message if mkdir() failed [patch 2].
> >    
> >    - Update commit log message about coverity being the reporter and
> >    
> >      details of the coverity report [patch 2].
> > 
> > Christian Schoenebeck (2):
> >    tests/9pfs: make create/remove test dir public
> >    tests/9pfs: fix test dir for parallel tests
> >   
> >   tests/qtest/libqos/virtio-9p.c | 20 ++++++++++----------
> >   tests/qtest/libqos/virtio-9p.h | 10 ++++++++++
> >   tests/qtest/virtio-9p-test.c   | 12 ++++++++++++
> >   3 files changed, 32 insertions(+), 10 deletions(-)
> 
> FWIW one thing I've noticed recently is that my builds for
> qemu-system-sparc64 have started giving this warning about a missing
> "qtest-9p-local" directory during make check:
> 
> ...
> ...
> Running test QAPI schema regression tests
> Running test qtest-sparc64/endianness-test
> Running test qtest-sparc64/prom-env-test
> Running test qtest-sparc64/boot-serial-test
> Running test qtest-sparc64/cdrom-test
> Running test qtest-sparc64/device-introspect-test
> Running test qtest-sparc64/machine-none-test
> Running test qtest-sparc64/qmp-test
> Running test qtest-sparc64/qmp-cmd-test
> Running test qtest-sparc64/qom-test
> Running test qtest-sparc64/test-hmp
> Running test qtest-sparc64/qos-test
> rm: cannot remove '/home/build/src/qemu/git/qemu/build/qtest-9p-local': No
> such file or directory
>    TEST    iotest-qcow2: 001
>    TEST    iotest-qcow2: 002
>    TEST    iotest-qcow2: 003
>    TEST    iotest-qcow2: 004
>    TEST    iotest-qcow2: 005
> ...
> ...
> 
> Would this get resolved by the changes to the test directory in this
> patchset? The build is a simple configure run with
> "--target-list=sparc64-softmmu".
> 
> 
> ATB,
> 
> Mark.

Yes, that should be resolved with the next 9p PR as well, additionally with 
the following patch that is:
https://github.com/cschoenebeck/qemu/commit/603cc76a6069

Thanks for the feedback!

Best regards,
Christian Schoenebeck




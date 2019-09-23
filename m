Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51480C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB4620578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="IRX/pGiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB4620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOzk-0001aa-Rq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCOyp-00016a-CZ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCOyo-0002YA-1L
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:06:19 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:47003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iCOyn-0002Xq-Hy
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=22llBNfbndwaBYScXQgsW3NF+ilPPdgJ2hH4eHOYNcY=; b=IRX/pGiYL+mrU+OqsydwJHYHBy
 O90OO0MyEuI3tGgaw2EELUqIvcx4mFs56JvGvJmRAg3xQHOs1A7jQWiUGGoj1naI0hBt0zUrBCEST
 W41Bj+U/6i6NUQjuVfZ3Uev0lLAP6dFnPuWqWI25kt0fT48+A5j/AbIvFudGzNGVNG88HRwvKJtqt
 rrRP0Dl2S7oS5hO4vlVg+r5pKDHGT4kXmVibxC/mwlAOJvZQSZ6qoaHmUxRlHhze7kxh4tDUMfnGk
 evXgwTtPmV/2EY+LJivO0MMRaf93xvz5xblKSk328zWqPc/Xur3B83jNQ7clAea1HKGouiXXm7dRW
 p91t+j78zMYWiIF7VR1XPRk3hUZs7YuMJSLLILurUE4IpAcfT5ZNs2AVtR9I6DxwM6v2sGiUX1wDb
 tL+4ynz48iWiR2wmIU2pSjCNfpFUHwJRMKZm0sQLgqqD9wIxPPMUGZYbnC8KkY5Qzd6CZ8Fw47gcQ
 DVKKVcec6iLJECra3H9SQzyrVW6fsI5WITWBhTaUbKpAq7Ksqjw+Fc90JLyBwe4l2U5NypIHlOuRE
 7InwIRDhz7IQOfvIHtUo/PaHNgUzNmiIO/AP2q9NQk/DmEtdO7lkWO83OHEJHfNJ+UZc2qzPCYEad
 SZ7lMxZ+LtX+7hIx3vO9JAFnYNQHue1s2Pu4qOhRE=;
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Date: Mon, 23 Sep 2019 16:06:13 +0200
Message-ID: <2537302.ZFCiNNprIf@silver>
In-Reply-To: <20190923145611.7ca240e8@bahia.lan>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2376196.qMJLftDnS9@silver> <20190923145611.7ca240e8@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Christian Schoenebeck via <qemu-devel@nongnu.org>

On Montag, 23. September 2019 14:56:11 CEST Greg Kurz wrote:
> On Mon, 23 Sep 2019 11:50:46 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Freitag, 13. September 2019 19:01:57 CEST Greg Kurz wrote:
> > > So I did some changes in 1/3 and pushed everything to 9p-next.
> > 
> > I've reviewed your changes. Some notes:
> > 
> > Patch 1:
> > https://github.com/gkurz/qemu/commit/9295011c5a961603959b966c8aa6ad9840fe6
> > db2> 
> > * Typo 1:
> > 	error_append_hint(&local_err, "Valide options are: multidevs="
> > 	
> > 	Valide -> Valid
> > 
> > * Typo 2 in log comment:
> > 	[groug: - Moved "multidevs" parsing the local backend.
> > 	->
> > 	[groug: - Moved "multidevs" parsing to the local backend.
> 
> Fixed.

Thanks! Saw it, looks fine now.

> > > I'll do some
> > > more manual testing and issue a PR when I'm confident enough.
> > 
> > That would be highly appreciated! So far I am the only one ever having
> > tested this patch set at all!
> 
> Just to clarify, I won't thoroughly test it. My main concern is that it
> doesn't break things. 

So in other words you are only going to test the default behaviour
--multidevs=warn?

If yes, and since that would mean I was the only person ever having tested the 
actual fix, shouldn't --multidevs=remap|forbid better be marked as 
experimental (docs and runtime warning) for now? Maybe that would also 
anticipate receiving feedback from people actually using it later on.

> I usually rely on this:
> 
> https://www.tuxera.com/community/posix-test-suite/

Well, that website is far from being too verbose of what that test suite 
actually encompasses.

> > > It would be nice to have some sort of automated test for that in 'make
> > > check'. My first thought is to simulate a cross-device setup with the
> > > synth
> > > backend, because it might be difficult to do this on a real filesystem
> > > without requiring elevated privileges.
> > 
> > Hmm, since I neither haven't used the synth backend before, nor added qemu
> > test cases so far, I am yet missing the complete picture here. My initial
> > suggested approach would have been using loopback devices for simulating
> > two file systems, but yes that's probably not viable due to required
> > permissions. How would the synth backend help here? I mean you would need
> > to simulate specific inode numbers and device numbers in some way for the
> > test cases.
> The synth backend allows to simulate anything you want, provided you
> code it of course :)
> 
> It is currently used to run some 9p protocol conformance tests. Have a
> look at the backend code to get the idea.
> 
> hw/9pfs/9p-synth.h
> hw/9pfs/9p-synth.c
> 
> and the test program:
> 
> tests/virtio-9p-test.c
> 
> It currently doesn't care for st_dev/st_ino at all, but I guess
> it shouldn't be that hard to add the necessary bits.

I see. Well, I will look at it, but that will definitely not be one of my 
current high priority tasks that would happen in the next few weeks (simply 
due to my work load).




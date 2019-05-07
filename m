Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC591C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B417B2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 16:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KiunDHIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B417B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2mf-0003Oa-Fr
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 12:17:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hO2lQ-0002kv-Sb
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hO2lN-0001Mq-MS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:19 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hO2lK-0001Km-Nu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 12:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n+I9NZiFb9xYfcfZUKi5n0GzFpkn/gg6KmHZWplTBRg=;
	b=KiunDHItx2dkmBkHicxbxfdBkr
	bmlSqeCEWaz83Wh/gjtPspQiNe9u+BZYZTjQd1lyytRjOjIGuqBPqF4QnjTKMRNx5stMa/iYPE7IU
	B9pP3fbPp9DHxUAXVr5p4aweIq0Yp/E+lCnRcoRhGL25DA7JKty01AlMhZrU8qQu6mJ9r3DN1I3V/
	kkFdnmBGBgxYxhprcedHvtlbbkKhDR5Pvt8xcDoPRwEuOuTG+DkPg4JutoGZHemkWlmBy0OmCaoHG
	KcZhyfoPES3qR95iFAw9j3UAoDGrdNB5pRv96bEZAXOnN7/z3M394Ygw8EYZKWJGm6SomJQC9cgZ0
	XLR37WH+5RmT69m4gz/CmS3VnSh/ef762a9EqrZ8nicNzh3Fdrkxp7bBwBByQH5e85/Yw6yL48qBm
	qwbTDludQVvQkWNIXGqEAx2OSsvJBvggE8Rau5ZJCDLrjMwtrIcZaho4DoiiNvZ34OMXLE2DH4p5I
	osAaRhU8c1/+PYoJlENMhHzKY7FhcWK/OeCzUG6SW8vs0UyGUiu2IDo0ioUvd/fqmZa1jYJtsbSZj
	0WoVvIJ16T0/Jcov7UYC9dsuxUbwv/i+Ngdq+r7uGnKB6NNTS1o8GsZNKJLk2OLZtNjeulfuLnp24
	2BqjS1uETZ9mh38IQOnvic0JEFRsPqUn7Ol6K3M4s=;
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 18:16:08 +0200
Message-ID: <1714809.tFt2Qa06yj@silver>
In-Reply-To: <20190507174239.59ad26d1@bahia.lan>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<3336211.WybC1Bzqah@silver> <20190507174239.59ad26d1@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 7. Mai 2019 17:42:39 CEST Greg Kurz wrote:
> > Sorry that I caused a bit of confusion, You were actually commenting
> > mostly on v2 of the patch set, where my email client replaced the message
> > IDs and hence screwed threading.
> > 
> > This is v3 that I sent yesterday and which has correct threading:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01143.html
> 
> For a reason yet to be investigated, I haven't received it yet...

Here are the archive links for latest v3 patch set [5(+1) patches total]:

[PATCH v3 0/5] 9p: Fix file ID collisions:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01143.html

[PATCH v3 1/5] 9p: mitigates most QID path collisions:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01142.html

[PATCH v3 2/5] 9P: trivial cleanup of QID path collision mitigation:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01140.html

[PATCH v3 3/5] 9p: persistency of QID path beyond reboots / suspensions:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01144.html

[PATCH v3 4/5] 9p: use variable length suffixes for inode mapping:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01141.html

[PATCH v3 5/5] 9p: adds virtfs 'vii' device parameter
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01138.html

And the optional libvirt patch:

[libvirt patch] qemu: adds support for virtfs 9p argument 'vii':
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01223.html

> > Please just have a glimpse on that v3 thread, and before I address the
> > details that you requested (I have reviewed them all already and will
> > address them), I would like you to ask you for a coarse feedback on
> > design/features first.
> > Because there are some things where I am unresolved on design level yet:
> I'll try but probably not before next week.

No problem, take your time!

Best regards,
Christian Schoenebeck


Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EE4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D266C2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="j8T/QTgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D266C2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUdz-0004Sl-PQ
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYUcB-0003af-IH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:38:48 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:57921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYUc6-0002JY-N8
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=2ZzEwn26CPfQ9tcZcekNgeTUl44Ct8FkhKL0mOrciYo=; b=j8T/QTgUUZ5OlHNuwj4QannSMa
 VTuijCxJRyjuCfaDhU/gnLfjyCeS3UBEXr/c4+Bk3YevFEd9a+5w8vMz44umPemBlc9tbCfF4dCAO
 SMoxcPY3lKp/WPWCg9ONvpauHbCJU+b0K1gbBymn66ER14koi55dVx74o1uhGgkZc0lYf3fsHI9nz
 ZSVutzZcF1tLweIlEF1RD+5hDi2J9Nt86M67f40fcDDUYADApDHWlOLnXeHsxC58mRr3AyRVjW5J2
 oOtREz75Vkua4oZHm3N9CK6nFYBj+7m1gof5IeiN6OVFbmVNbZBdriVi1AIWjh+EOIL1HagyKhLcd
 t0+2F8RA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/2] 9pfs: test suite fixes
Date: Fri, 30 Oct 2020 14:38:38 +0100
Message-ID: <2966378.E1T83bONKy@silver>
In-Reply-To: <20201030142315.183f9d91@bahia.lan>
References: <cover.1604061839.git.qemu_oss@crudebyte.com>
 <20201030142315.183f9d91@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
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

On Freitag, 30. Oktober 2020 14:23:15 CET Greg Kurz wrote:
> On Fri, 30 Oct 2020 13:43:59 +0100
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > Fixes two bugs with the 9pfs 'local' tests as discussed with latest 9P PR
> > (2020-10-23). See the discussion of that PR for details.
> > 
> > v1->v2:
> >   - Added Greg's tested-by tag [patch 1].
> >   
> >   - Log an info-level message if mkdir() failed [patch 2].
> >   
> >   - Update commit log message about coverity being the reporter and
> >   
> >     details of the coverity report [patch 2].
> > 
> > Christian Schoenebeck (2):
> >   tests/9pfs: fix test dir for parallel tests
> >   tests/9pfs: fix coverity error in create_local_test_dir()
> >  
> >  tests/qtest/libqos/virtio-9p.c | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> Series,
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks for review and testing. I appreciate it.

Best regards,
Christian Schoenebeck




Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9C9C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41982076A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41982076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvyH-0003rX-Fp
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUvvz-0002bX-PI
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:00:31 -0400
Received: from 8.mo52.mail-out.ovh.net ([46.105.37.156]:37650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUvvx-0004Uf-8q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:00:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.194])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 5F5BA1FFB16;
 Tue, 20 Oct 2020 20:00:26 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 20 Oct
 2020 20:00:25 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0041681b01f-8d78-49f1-b86c-6ec5444a596f,
 1DF5E91C91B319FFB92086F2F245FA8D0BCC998A) smtp.auth=groug@kaod.org
Date: Tue, 20 Oct 2020 20:00:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 0/5] tests/9pfs: Code refactoring
Message-ID: <20201020200024.3b29da07@bahia.lan>
In-Reply-To: <2043652.ohusmZrI9R@silver>
References: <160320977352.266767.5622969302437522296.stgit@bahia.lan>
 <2043652.ohusmZrI9R@silver>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 57cd6a19-0077-455e-8351-baa5482e1d8f
X-Ovh-Tracer-Id: 2718485327985613210
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueffteeuffekveffhfffueejkeeitdfgjedvtdelgfettdffgfffieeijefftdevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.37.156; envelope-from=groug@kaod.org;
 helo=8.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 14:00:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 19:23:19 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 20. Oktober 2020 18:09:07 CEST Greg Kurz wrote:
> > Some code refactoring to have a clear distinction between top level
> > test functions and helper functions.
> > 
> > v2: - use "do_" prefix instead of "do_fs_"
> > 
> > ---
> > 
> > Greg Kurz (5):
> >       tests/9pfs: Factor out do_version() helper
> >       tests/9pfs: Turn fs_readdir_split() into a helper
> >       tests/9pfs: Set alloc in fs_create_dir()
> >       tests/9pfs: Factor out do_attach() helper
> >       tests/9pfs: Turn fs_mkdir() into a helper
> > 
> > 
> >  tests/qtest/virtio-9p-test.c |   62
> > +++++++++++++++++++++++------------------- 1 file changed, 34
> > insertions(+), 28 deletions(-)
> > 
> > --
> > Greg
> 
> Queued on 9p.next:
> https://github.com/cschoenebeck/qemu/commits/9p.next
> 
> I just tweaked the order of the patches to prevent intermediate compiler 
> errors.
> 

Oops, sorry... thanks ! :)

> Thanks!
> 
> Best regards,
> Christian Schoenebeck
> 
> 



Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07705C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D13208B6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 19:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D13208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZJ6W-000433-WD
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 14:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZJ4j-0003H6-Nx
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:31:37 -0500
Received: from 2.mo52.mail-out.ovh.net ([178.33.105.233]:35314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kZJ4h-0002jg-EY
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 14:31:37 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.132])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 742162006A5;
 Sun,  1 Nov 2020 20:31:30 +0100 (CET)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Sun, 1 Nov 2020
 20:31:29 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0064fb7f3c9-0e30-4752-8f54-e40249670e75,
 510A72FFAFC78B4C24D608C8B6637C1151DF677A) smtp.auth=groug@kaod.org
Date: Sun, 1 Nov 2020 20:31:28 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v3 2/2] tests/9pfs: fix test dir for parallel tests
Message-ID: <20201101203128.40a013ad@bahia.lan>
In-Reply-To: <2531717.KjLcWJ8QnQ@silver>
References: <cover.1604243521.git.qemu_oss@crudebyte.com>
 <7746f42d8f557593898d3d9d8e57c46e872dfb4f.1604243521.git.qemu_oss@crudebyte.com>
 <20201101184444.0da77d03@bahia.lan> <2531717.KjLcWJ8QnQ@silver>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: c8142b01-62f8-4e66-a304-107674fc2b11
X-Ovh-Tracer-Id: 941815274138605978
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrleelgdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueffteeuffekveffhfffueejkeeitdfgjedvtdelgfettdffgfffieeijefftdevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.105.233; envelope-from=groug@kaod.org;
 helo=2.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 14:31:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Sun, 01 Nov 2020 20:14:16 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Sonntag, 1. November 2020 18:44:44 CET Greg Kurz wrote:
> > On Sun, 1 Nov 2020 15:37:12 +0100
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > Use mkdtemp() to generate a unique directory for the 9p 'local' tests.
> > > 
> > > This fixes occasional 9p test failures when running 'make check -jN' if
> > > QEMU was compiled for multiple target architectures, because the
> > > individual
> > > architecture's test suites would run in parallel and interfere with each
> > > other's data as the test directory was previously hard coded and hence the
> > > same directory was used by all of them simultaniously.
> > > 
> > > This also requires a change how the test directory is created and deleted:
> > > As the test path is now randomized and virtio_9p_register_nodes() being
> > > called in a somewhat undeterministic way, that's no longer an appropriate
> > > place to create and remove the test directory. Use a constructor and
> > > destructor function for creating and removing the test directory instead.
> > > Unfortunately libqos currently does not support setup/teardown callbacks
> > > to handle this more cleanly.
> > > 
> > > The constructor functions needs to be in virtio-9p-test.c, not in
> > > virtio-9p.c, because in the latter location it would cause all apps that
> > > link to libqos (i.e. entirely unrelated test suites) to create a 9pfs
> > > test directory as well, which would even break other test suites.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > 
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> Thanks for the overtime, on a Sunday!
> 
> Queued on 9p.next:
> https://github.com/cschoenebeck/qemu/commits/9p.next
> 
> And this one with Peter Xu's patches on top, just for testing:
> https://github.com/cschoenebeck/qemu/commits/9p.experimental.2
> 
> > I could run 'make check -j' with 4 archs (ppc64, x86_64, aarch64, s390x)
> > on a POWER9 system with 128 cpus, for ~1 hour without seeing any failure.
> > 
> > Tested-by: Greg Kurz <groug@kaod.org>
> 
> OO Sounds like having advantages working for IBM. Respect. I start to get envy 
> as these beasts are running towards PCIe 6, while we regular x86 users would 
> already be glad having PCIe 4.
> 

I work for Red Hat now but yes, this allows easier access to bigger systems.

> I give it some more spinning hours this time, just to be sure, before sending 
> the PR tomorrow morning. But I think it's all right now.
> 

Cool ! :)

> Thanks!
> 
> Best regards,
> Christian Schoenebeck
> 
> 



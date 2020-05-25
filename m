Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F681C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DA92071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DA92071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdDVI-0001k2-7z
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdDTR-0000eB-TM
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:49:01 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:41132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdDTQ-00015Y-Ke
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:49:01 -0400
Received: from player730.ha.ovh.net (unknown [10.108.42.239])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2B10E8F499
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 15:48:57 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 1B8CE1287D9A5;
 Mon, 25 May 2020 13:48:49 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0020ab24613-3a4c-4649-8b8b-0ee358aa14d6,22A89661A4361147AF88D80C9EA00EFFECB1F326)
 smtp.auth=groug@kaod.org
Date: Mon, 25 May 2020 15:48:47 +0200
From: Greg Kurz <groug@kaod.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 0/3] revert 9pfs reply truncation, wait for free room
 to reply
Message-ID: <20200525154847.3e862973@bahia.lan>
In-Reply-To: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14756325657592371633
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeeuvdetgfefueekkeegueekhfeukeehteffveelvdefvedvgfevtefhgefhvefhnecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.42.102; envelope-from=groug@kaod.org;
 helo=4.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 09:48:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: anthony.perard@citrix.com, qemu_oss@crudebyte.com, qemu-devel@nongnu.org,
 paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 12:26:18 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> Hi all,
> 
> This short series reverts commit 16724a173049ac29c7b5ade741da93a0f46edff
> becauses it is the cause for https://bugs.launchpad.net/bugs/1877688.
> 
> The original issue addressed by 16724a173049ac29c7b5ade741da93a0f46edff
> is solved differently in this series by using qemu_coroutine_yield() to
> wait for the client to free more data from the ring before sending the
> reply.
> 
> Cheers,
> 
> Stefano
> 

I wasn't really involved in the review of these patches, but I've
done some testing with virtio-9p which show no regression. I
assume you have done some testing on the Xen side as well. So
I've pushed the series to 9p-next. I shall send a PR in a day
or so.

Cheers,

--
Greg

> Changes in v2:
> - add comments on barriers
> - add patch to increase ring size to the max allowed



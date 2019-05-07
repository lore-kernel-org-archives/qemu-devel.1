Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F61C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC8721019
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC8721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwQE-0007rs-NI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:30:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwOS-0006gV-0s
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwOR-0004J4-3i
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:12 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:42089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNwOQ-0004Hi-UO
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:28:11 -0400
Received: from player795.ha.ovh.net (unknown [10.108.57.153])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 78A991127D6
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 11:28:08 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player795.ha.ovh.net (Postfix) with ESMTPSA id 2BEE456DA660;
	Tue,  7 May 2019 09:28:05 +0000 (UTC)
Date: Tue, 7 May 2019 11:28:04 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507112804.23cde966@bahia.lan>
In-Reply-To: <1926077.q6xKvCkoZ9@silver>
References: <1926077.q6xKvCkoZ9@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5739837727215294784
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.216
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9p: Fix file ID collisions
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
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 03 May 2019 18:20:39 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Hi!
> 
> This is v2 of a proposed patch set for fixing file ID collisions with 9pfs.
> 
> Patch 1 to 3 are identical to the previous version. New in this v2 is patch 4
> which introduces variable length suffixes for inode mapping instead of fixed
> length prefixes.
> 
> Also: patch 4 disables file ID persistency at compile time by default for now,
> since I am yet unresolved about details of that persistency.
> 
> Christian Schoenebeck (4):
>   9p: mitigates most QID path collisions
>   9P: trivial cleanup of QID path collision mitigation
>   9p: persistency of QID path beyond reboots / suspensions
>   9p: use variable length suffixes for inode mapping
> 
>  fsdev/9p-marshal.h   |    6 +-
>  hw/9pfs/9p.c         | 1145 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/9pfs/9p.h         |  167 ++++++++
>  hw/9pfs/trace-events |   14 +-
>  4 files changed, 1296 insertions(+), 36 deletions(-)
> 

Hmm... this series comes unthreaded again because the cover has:

Message-ID: <1926077.q6xKvCkoZ9@silver>

while the patches have:

In-Reply-To: <cover.1556896526.git.qemu_oss@crudebyte.com>

Maybe consider using git send-email or stgit mail to have proper
threading for free.

Cheers,

--
Greg


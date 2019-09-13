Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0462FC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 17:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB491206BB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 17:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB491206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8oyg-0004JX-Ul
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 13:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i8oxa-0003rN-7B
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 13:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i8oxX-0007ro-Ib
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 13:02:13 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:52625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i8oxU-0007pO-Fl
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 13:02:09 -0400
Received: from player789.ha.ovh.net (unknown [10.109.159.222])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id A645E1434D1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 19:02:05 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 9D30D9C0E2A6;
 Fri, 13 Sep 2019 17:01:59 +0000 (UTC)
Date: Fri, 13 Sep 2019 19:01:57 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190913190157.651fc3a6@bahia.lan>
In-Reply-To: <cover.1567680121.git.qemu_oss@crudebyte.com>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14667379562961475904
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.59.63
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Sep 2019 12:42:01 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> This is v7 of a proposed patch set for fixing file ID collisions with 9pfs.
> 

So I did some changes in 1/3 and pushed everything to 9p-next. I'll do some
more manual testing and issue a PR when I'm confident enough.

It would be nice to have some sort of automated test for that in 'make check'.
My first thought is to simulate a cross-device setup with the synth backend,
because it might be difficult to do this on a real filesystem without requiring
elevated privileges.

> v6->v7:
> 
>   * Rebased to https://github.com/gkurz/qemu/commits/9p-next
>     (SHA1 7fc4c49e91).
> 
>   * Be pedantic and abort with error on wrong value for new command line
>     argument 'multidevs'.
> 
>   * Adjusted patches to qemu code style guidelines.
> 
>   * Fixed potential crash in qp_table_destroy() on error path.
> 
>   * Use dedicated hash table init functions (qpd_table_init(),
>     qpf_table_init(), qpp_table_init()):
>     https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00144.html
> 
>   * Use warn_report_once() instead of error_report_once() for issues
>     interpreted merely as being warnings, not errors.
> 
>   * Simplified hash table destruction (due to simplified error path
>     introduced by SHA1 7fc4c49e91).
> 
>   * Dropped capturing root_ino for now:
>     https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00146.html
> 
>   * Don't update proxy docs, since new command line argument 'multidevs' is
>     limited to the local backend for now.
> 
>   * Mention in docs that readdir() is currently not blocked by
>     'multidevs=forbid'.
> 
>   * Rename qid_path_prefixmap() -> qid_path_suffixmap() in patch 3
>     (due to the semantic change of that function by that patch).
> 
> Christian Schoenebeck (3):
>   9p: Added virtfs option 'multidevs=remap|forbid|warn'
>   9p: stat_to_qid: implement slow path
>   9p: Use variable length suffixes for inode remapping
> 
>  fsdev/file-op-9p.h      |   5 +
>  fsdev/qemu-fsdev-opts.c |   7 +-
>  fsdev/qemu-fsdev.c      |  17 ++
>  hw/9pfs/9p.c            | 456 ++++++++++++++++++++++++++++++++++++++--
>  hw/9pfs/9p.h            |  59 ++++++
>  qemu-options.hx         |  26 ++-
>  vl.c                    |   7 +-
>  7 files changed, 552 insertions(+), 25 deletions(-)
> 



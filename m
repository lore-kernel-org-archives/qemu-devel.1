Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4904C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909C22082F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909C22082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDQ4-00011y-R9
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jlDIf-0007er-Hf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:14:57 -0400
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:50200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jlDId-0001K1-AP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:14:57 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.240])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id B320F1BFB9C
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 17:14:45 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id D09BE136F4EEA;
 Tue, 16 Jun 2020 15:14:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003d4a0efd5-a534-45b8-8147-0892b4cc63e6,6D1193CAFB0197A83E26607BB2BE83A43F9AE14F)
 smtp.auth=groug@kaod.org
Date: Tue, 16 Jun 2020 17:14:40 +0200
From: Greg Kurz <groug@kaod.org>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH 72/78] 9p: Lock directory streams with a CoMutex
Message-ID: <20200616171440.172f1173@bahia.lan>
In-Reply-To: <20200616141547.24664-73-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
 <20200616141547.24664-73-mdroth@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16277416429476288924
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudejtddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.108.172; envelope-from=groug@kaod.org;
 helo=9.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:14:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing co-maintainer Christian Schoenebeck.

Christian,

If there are some more commits you think are worth being cherry picked
for QEMU 4.2.1, please inform Michael before freeze on 2020-06-22.

Cheers,

--
Greg

On Tue, 16 Jun 2020 09:15:41 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> From: Greg Kurz <groug@kaod.org>
> 
> Locking was introduced in QEMU 2.7 to address the deprecation of
> readdir_r(3) in glibc 2.24. It turns out that the frontend code is
> the worst place to handle a critical section with a pthread mutex:
> the code runs in a coroutine on behalf of the QEMU mainloop and then
> yields control, waiting for the fsdev backend to process the request
> in a worker thread. If the client resends another readdir request for
> the same fid before the previous one finally unlocked the mutex, we're
> deadlocked.
> 
> This never bit us because the linux client serializes readdir requests
> for the same fid, but it is quite easy to demonstrate with a custom
> client.
> 
> A good solution could be to narrow the critical section in the worker
> thread code and to return a copy of the dirent to the frontend, but
> this causes quite some changes in both 9p.c and codir.c. So, instead
> of that, in order for people to easily backport the fix to older QEMU
> versions, let's simply use a CoMutex since all the users for this
> sit in coroutines.
> 
> Fixes: 7cde47d4a89d ("9p: add locking to V9fsDir")
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Message-Id: <158981894794.109297.3530035833368944254.stgit@bahia.lan>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> (cherry picked from commit ed463454efd0ac3042ff772bfe1b1d846dc281a5)
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/9pfs/9p.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 3904f82901..069c86333f 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -186,22 +186,22 @@ typedef struct V9fsXattr
>  
>  typedef struct V9fsDir {
>      DIR *stream;
> -    QemuMutex readdir_mutex;
> +    CoMutex readdir_mutex;
>  } V9fsDir;
>  
>  static inline void v9fs_readdir_lock(V9fsDir *dir)
>  {
> -    qemu_mutex_lock(&dir->readdir_mutex);
> +    qemu_co_mutex_lock(&dir->readdir_mutex);
>  }
>  
>  static inline void v9fs_readdir_unlock(V9fsDir *dir)
>  {
> -    qemu_mutex_unlock(&dir->readdir_mutex);
> +    qemu_co_mutex_unlock(&dir->readdir_mutex);
>  }
>  
>  static inline void v9fs_readdir_init(V9fsDir *dir)
>  {
> -    qemu_mutex_init(&dir->readdir_mutex);
> +    qemu_co_mutex_init(&dir->readdir_mutex);
>  }
>  
>  /*



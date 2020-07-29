Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033942065E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033942065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oGv-0002gb-At
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0oFu-00021z-EX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:44:34 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:38174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k0oFs-0006TC-Gg
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 11:44:34 -0400
Received: from player731.ha.ovh.net (unknown [10.108.35.185])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1D5A11E2B63
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 17:44:29 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 6575A149AAD6F;
 Wed, 29 Jul 2020 15:44:28 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0040b480f68-dc9c-4cd2-9e0c-2c738a26bf0c,A40F6FE0CFFE28C23AB4AFBB3D5D665E11D39731)
 smtp.auth=groug@kaod.org
Date: Wed, 29 Jul 2020 17:44:27 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v8 2/7] 9pfs: make v9fs_readdir_response_size() public
Message-ID: <20200729174427.4f4d2e35@bahia.lan>
In-Reply-To: <3668ebc7d5b929a0e4f1357457060d96f50f76f4.1596012787.git.qemu_oss@crudebyte.com>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
 <3668ebc7d5b929a0e4f1357457060d96f50f76f4.1596012787.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11050989062082697536
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.58.226; envelope-from=groug@kaod.org;
 helo=3.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 11:44:30
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

On Wed, 29 Jul 2020 10:11:15 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Rename function v9fs_readdir_data_size() -> v9fs_readdir_response_size()
> and make it callable from other units. So far this function is only
> used by 9p.c, however subsequent patches require the function to be
> callable from another 9pfs unit. And as we're at it; also make it clear
> for what this function is used for.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 10 ++++++++--
>  hw/9pfs/9p.h |  1 +
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 2ffd96ade9..7a228c4828 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2313,7 +2313,13 @@ out_nofid:
>      pdu_complete(pdu, err);
>  }
>  
> -static size_t v9fs_readdir_data_size(V9fsString *name)
> +/**
> + * Returns size required in Rreaddir response for the passed dirent @p name.
> + *
> + * @param name - directory entry's name (i.e. file name, directory name)
> + * @returns required size in bytes
> + */
> +size_t v9fs_readdir_response_size(V9fsString *name)
>  {
>      /*
>       * Size of each dirent on the wire: size of qid (13) + size of offset (8)
> @@ -2348,7 +2354,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
>          }
>          v9fs_string_init(&name);
>          v9fs_string_sprintf(&name, "%s", dent->d_name);
> -        if ((count + v9fs_readdir_data_size(&name)) > max_count) {
> +        if ((count + v9fs_readdir_response_size(&name)) > max_count) {
>              v9fs_readdir_unlock(&fidp->fs.dir);
>  
>              /* Ran out of buffer. Set dir back to old position and return */
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index ee2271663c..561774e843 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -419,6 +419,7 @@ void v9fs_path_init(V9fsPath *path);
>  void v9fs_path_free(V9fsPath *path);
>  void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...);
>  void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
> +size_t v9fs_readdir_response_size(V9fsString *name);
>  int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
>                        const char *name, V9fsPath *path);
>  int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,



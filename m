Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4168AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134B72071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134B72071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNjh-0005b7-9u
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnNfT-0007dQ-E5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:43:27 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:48882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnNfQ-0007F8-O1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:43:27 -0400
Received: from player734.ha.ovh.net (unknown [10.110.171.212])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id CD69125A2B1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 16:43:21 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 1FA7813796292;
 Mon, 22 Jun 2020 14:43:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00392a1cec4-e548-4159-80de-9f92e98c7a14,6D3CA472F13BA58F0C95800BF735BE34A93B107C)
 smtp.auth=groug@kaod.org
Date: Mon, 22 Jun 2020 16:43:17 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 03/22] Clean up some calls to ignore Error objects the
 right way
Message-ID: <20200622164317.679021ee@bahia.lan>
In-Reply-To: <20200622104250.1404835-4-armbru@redhat.com>
References: <20200622104250.1404835-1-armbru@redhat.com>
 <20200622104250.1404835-4-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14089792909325539726
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekvddgkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepteekgeejiedvteeufeekfffhtddtgfegkeekkefgleefheejgfehtdelheeivefhnecuffhomhgrihhnpehinhgvthdrhhhoshhtnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.75.36; envelope-from=groug@kaod.org;
 helo=2.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 10:43:22
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
Cc: "Daniel
 P . Berrange" <berrange@redhat.com>, Jerome Forissier <jerome@forissier.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 12:42:31 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Receiving the error in a local variable only to free it is less clear
> (and also less efficient) than passing NULL.  Clean up.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Jerome Forissier <jerome@forissier.org>
> CC: Greg Kurz <groug@kaod.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Acked-by: Greg Kurz <groug@kaod.org> # for 9pfs

>  chardev/char-socket.c | 6 ++----
>  hw/9pfs/9p.c          | 6 ++----
>  hw/arm/virt.c         | 4 +---
>  hw/ppc/spapr_drc.c    | 4 +---
>  ui/vnc.c              | 3 +--
>  5 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index afebeec5c3..b0cae97960 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -815,22 +815,20 @@ static void tcp_chr_tls_init(Chardev *chr)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
>      QIOChannelTLS *tioc;
> -    Error *err = NULL;
>      gchar *name;
>  
>      if (s->is_listen) {
>          tioc = qio_channel_tls_new_server(
>              s->ioc, s->tls_creds,
>              s->tls_authz,
> -            &err);
> +            NULL);
>      } else {
>          tioc = qio_channel_tls_new_client(
>              s->ioc, s->tls_creds,
>              s->addr->u.inet.host,
> -            &err);
> +            NULL);
>      }
>      if (tioc == NULL) {
> -        error_free(err);
>          tcp_chr_disconnect(chr);
>          return;
>      }
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 45a788f6e6..9755fba9a9 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1399,7 +1399,6 @@ static void coroutine_fn v9fs_attach(void *opaque)
>      size_t offset = 7;
>      V9fsQID qid;
>      ssize_t err;
> -    Error *local_err = NULL;
>  
>      v9fs_string_init(&uname);
>      v9fs_string_init(&aname);
> @@ -1437,9 +1436,8 @@ static void coroutine_fn v9fs_attach(void *opaque)
>          error_setg(&s->migration_blocker,
>                     "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
>                     s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
> -        err = migrate_add_blocker(s->migration_blocker, &local_err);
> -        if (local_err) {
> -            error_free(local_err);
> +        err = migrate_add_blocker(s->migration_blocker, NULL);
> +        if (err < 0) {
>              error_free(s->migration_blocker);
>              s->migration_blocker = NULL;
>              clunk_fid(s, fid);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index caceb1e4a0..29b9d5b2e6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -217,11 +217,9 @@ static bool cpu_type_valid(const char *cpu)
>  
>  static void create_kaslr_seed(VirtMachineState *vms, const char *node)
>  {
> -    Error *err = NULL;
>      uint64_t seed;
>  
> -    if (qemu_guest_getrandom(&seed, sizeof(seed), &err)) {
> -        error_free(err);
> +    if (qemu_guest_getrandom(&seed, sizeof(seed), NULL)) {
>          return;
>      }
>      qemu_fdt_setprop_u64(vms->fdt, node, "kaslr-seed", seed);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 2689104295..951bcdf2c0 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -1163,16 +1163,14 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
>      drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>  
>      if (!drc->fdt) {
> -        Error *local_err = NULL;
>          void *fdt;
>          int fdt_size;
>  
>          fdt = create_device_tree(&fdt_size);
>  
>          if (drck->dt_populate(drc, spapr, fdt, &drc->fdt_start_offset,
> -                              &local_err)) {
> +                              NULL)) {
>              g_free(fdt);
> -            error_free(local_err);
>              rc = SPAPR_DR_CC_RESPONSE_ERROR;
>              goto out;
>          }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 12a12714e1..0702a76cce 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -458,9 +458,8 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
>      Error *err = NULL;
>      SocketAddress *addr;
>  
> -    addr = qio_channel_socket_get_local_address(ioc, &err);
> +    addr = qio_channel_socket_get_local_address(ioc, NULL);
>      if (!addr) {
> -        error_free(err);
>          return prev;
>      }
>  



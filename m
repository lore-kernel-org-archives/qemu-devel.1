Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE69C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B2F22276
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2F22276
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTkB-0007XC-5K
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUTeY-0004K3-6v
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:48:38 -0400
Received: from 9.mo51.mail-out.ovh.net ([46.105.48.137]:48822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUTeO-0000c4-LP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:48:33 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.97])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id D6B38231FCE;
 Mon, 19 Oct 2020 13:48:24 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 19 Oct
 2020 13:48:24 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002fa53cb09-c02f-49b2-9d52-a6c3b16bbc0c,
 3DC39DA722A1628917AB265CB375B6C80BE9100C) smtp.auth=groug@kaod.org
Date: Mon, 19 Oct 2020 13:48:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] 9pfs: suppress performance warnings on qtest runs
Message-ID: <20201019134822.047db0fc@bahia.lan>
In-Reply-To: <a2d2ff2163f8853ea782a7a1d4e6f2afd7c29ffe.1603106145.git.qemu_oss@crudebyte.com>
References: <a2d2ff2163f8853ea782a7a1d4e6f2afd7c29ffe.1603106145.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e9e0bf5b-f981-4a9c-961e-95c8f3f80a9a
X-Ovh-Tracer-Id: 9009451054951405978
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:48:25
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

On Mon, 19 Oct 2020 13:10:18 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Don't trigger any performance warning if we're just running test cases,
> because tests intentionally run for edge cases.
> 
> So far performance warnings were suppressed for the 'synth' fs driver
> backend only. This patch suppresses them for all 9p fs driver backends.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-synth.c         | 2 --
>  hw/9pfs/virtio-9p-device.c | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index cec8c0eefc..7eb210ffa8 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -541,8 +541,6 @@ static int synth_init(FsContext *ctx, Error **errp)
>      QLIST_INIT(&synth_root.child);
>      qemu_mutex_init(&synth_mutex);
>  
> -    ctx->export_flags |= V9FS_NO_PERF_WARN;
> -
>      /* Add "." and ".." entries for root */
>      v9fs_add_dir_node(&synth_root, synth_root.attr->mode,
>                        "..", synth_root.attr, synth_root.attr->inode);
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 36f3aa9352..14371a78ef 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -21,6 +21,7 @@
>  #include "hw/virtio/virtio-access.h"
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
> +#include "sysemu/qtest.h"
>  
>  static void virtio_9p_push_and_notify(V9fsPDU *pdu)
>  {
> @@ -199,6 +200,11 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
> +    FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
> +
> +    if (qtest_enabled() && fse) {
> +        fse->export_flags |= V9FS_NO_PERF_WARN;
> +    }
>  
>      if (v9fs_device_realize_common(s, &virtio_9p_transport, errp)) {
>          return;



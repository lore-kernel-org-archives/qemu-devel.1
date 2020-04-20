Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9AC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AEF620A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEF620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSvG-0006lk-CQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45740 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jQSud-0006HP-CV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:40:23 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jQSuc-0001Fb-N8
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:40:23 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:34343)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jQSuc-00013W-62
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:40:22 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0033F1D06E1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 11:40:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 708EF119DA7BE;
 Mon, 20 Apr 2020 09:40:02 +0000 (UTC)
Date: Mon, 20 Apr 2020 11:39:59 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] MAINTAINERS: Upgrade myself as 9pfs co-maintainer
Message-ID: <20200420113959.2c98e63d@bahia.lan>
In-Reply-To: <E1jEYz4-0004pt-Cs@lizzy.crudebyte.com>
References: <E1jEYz4-0004pt-Cs@lizzy.crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7923239123003283776
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepqhgvmhhurdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.53.149; envelope-from=groug@kaod.org;
 helo=2.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 05:40:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 188.165.53.149
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 14:33:44 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> As suggested by Greg, let's upgrade myself as co-maintainer of 9pfs.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Applied to 9p-next.


Hi Peter,

Christian has been contributing to and reviewing 9pfs patches for some
time now. I'm glad he's now volunteering for maintainership. The next
step is to be able to send PRs that have a chance to be accepted by you.
Christian told me he would need to start with a brand new GPG key. Because
of the confinement, it is very unlikely he has a chance to get this key
signed by anybody *in person* as described in [1]... if I try to make sure
Christian's key fingerprint is valid in a "best effort" way, e.g. multiple
messages using different media or channels, would it be acceptable for you
that I'm the only signer for his key ?

Cheers,

--
Greg

[1] https://wiki.qemu.org/Contribute/SubmitAPullRequest

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7364af0d8b..8d9cd04ab5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1630,7 +1630,7 @@ F: include/hw/virtio/
>  
>  virtio-9p
>  M: Greg Kurz <groug@kaod.org>
> -R: Christian Schoenebeck <qemu_oss@crudebyte.com>
> +M: Christian Schoenebeck <qemu_oss@crudebyte.com>
>  S: Odd Fixes
>  F: hw/9pfs/
>  X: hw/9pfs/xen-9p*



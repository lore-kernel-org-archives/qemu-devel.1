Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD7C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3931A20872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3931A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD28M-0003OJ-3u
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD1zF-0004do-6s
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD1zE-0008CB-5F
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:21 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:59584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD1zC-00089C-8A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:45:18 -0400
Received: from player755.ha.ovh.net (unknown [10.108.57.76])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 0893476D7B
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:45:14 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id BBA9BA4A102C;
 Wed, 25 Sep 2019 07:45:03 +0000 (UTC)
Date: Wed, 25 Sep 2019 09:45:01 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 01/20] xics: Use incomplete type for XICSFabric
Message-ID: <20190925094501.72e32ef7@bahia.lan>
In-Reply-To: <20190925064534.19155-2-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1948369792221026790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.53.132
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Interface instances should never be directly dereferenced.  So, the common
> practice is to make them incomplete types to make sure no-one does that.
> XICSFrabric, however, had a dummy type which is less safe.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  include/hw/ppc/xics.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 64a2c8862a..1ae34ce9cd 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -147,9 +147,7 @@ struct ICSIRQState {
>      uint8_t flags;
>  };
>  
> -struct XICSFabric {
> -    Object parent;
> -};

Ok.

> +typedef struct XICSFabric XICSFabric;
>  

Nak. We already have this statement earlier in this file and
we must keep it there since it is used in the definition of
some other types. I guess this doesn't cause any compiler
warning because the type is incomplete.

With this duplicate typedef removed,

Reviewed-by: Greg Kurz <groug@kaod.org>

>  #define TYPE_XICS_FABRIC "xics-fabric"
>  #define XICS_FABRIC(obj)                                     \



Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E879F206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E879F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkXF-0005W9-W6
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDkW1-0004W3-Ae
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDkVv-00083w-Ne
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:18:09 -0400
Received: from 2.mo4.mail-out.ovh.net ([46.105.72.36]:41770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDkVv-000821-I0
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:18:03 -0400
Received: from player734.ha.ovh.net (unknown [10.108.54.97])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 17A40208D89
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 09:18:00 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id E6F18A3B0B32;
 Fri, 27 Sep 2019 07:17:49 +0000 (UTC)
Date: Fri, 27 Sep 2019 09:17:48 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 01/33] xics: Minor fixes for XICSFabric interface
Message-ID: <20190927091748.4fe61cdd@bahia.lan>
In-Reply-To: <20190927055028.11493-2-david@gibson.dropbear.id.au>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13233827508864850406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.36
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

On Fri, 27 Sep 2019 15:49:56 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Interface instances should never be directly dereferenced.  So, the common
> practice is to make them incomplete types to make sure no-one does that.
> XICSFrabric, however, had a dummy type which is less safe.
> 
> We were also using OBJECT_CHECK() where we should have been using
> INTERFACE_CHECK().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xics.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 64a2c8862a..faa33ae943 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -147,13 +147,9 @@ struct ICSIRQState {
>      uint8_t flags;
>  };
>  
> -struct XICSFabric {
> -    Object parent;
> -};
> -
>  #define TYPE_XICS_FABRIC "xics-fabric"
>  #define XICS_FABRIC(obj)                                     \
> -    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
> +    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
>  #define XICS_FABRIC_CLASS(klass)                                     \
>      OBJECT_CLASS_CHECK(XICSFabricClass, (klass), TYPE_XICS_FABRIC)
>  #define XICS_FABRIC_GET_CLASS(obj)                                   \



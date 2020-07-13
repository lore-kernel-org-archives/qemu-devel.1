Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5624C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32552067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZjldM9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32552067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3Ye-0006kQ-1o
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jv3VV-0003Ac-Qt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:48:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jv3VS-0000FW-IC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594666125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0gRfiqt0ni6sBNdpuxBZtmirTDrslOOg0zJS3axfP9o=;
 b=WZjldM9aMcsQaURF5JNlPOcIyPlz84lq+z+J4n/GmMQPEOOdRlAy1vUdGMyr9p6AWXSDdm
 9Vx+Ilj/bWNpNnGi4mOBzIn+jD1LSIAqukwQWFJnuSeOBlYf5capNDW4wBMi+JJ0SQK4h9
 VhI+u3AtQs0jhJV4tQQD64mvgoEAogM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-HqdUhiOYP6a95byMJpl3iQ-1; Mon, 13 Jul 2020 14:48:43 -0400
X-MC-Unique: HqdUhiOYP6a95byMJpl3iQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 692EF100CC86;
 Mon, 13 Jul 2020 18:48:42 +0000 (UTC)
Received: from localhost (ovpn-119-232.rdu2.redhat.com [10.10.119.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09F825BAE4;
 Mon, 13 Jul 2020 18:48:41 +0000 (UTC)
Date: Mon, 13 Jul 2020 14:48:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 2/2] i386/cpu: Don't add unavailable_features to
 env->user_features
Message-ID: <20200713184841.GF780932@habkost.net>
References: <20200713174436.41070-1-xiaoyao.li@intel.com>
 <20200713174436.41070-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200713174436.41070-3-xiaoyao.li@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:48:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 01:44:36AM +0800, Xiaoyao Li wrote:
> Features unavailable due to absent of their dependent features should
> not be added to env->user_features. env->user_features only contains the
> feature explicity specified with -feature/+feature by user.
> 
> Fixes: 99e24dbdaa68 ("target/i386: introduce generic feature dependency mechanism")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Paolo, do you remember why that line existed?  It doesn't make
sense to me.

There are exactly 2 lines of code reading user_features, and both
of them are inside x86_cpu_expand_features() above this hunk.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  target/i386/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9812d5747f35..fb1de1bd6165 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6370,7 +6370,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>                                        unavailable_features & env->user_features[d->to.index],
>                                        "This feature depends on other features that were not requested");
>  
> -            env->user_features[d->to.index] |= unavailable_features;
>              env->features[d->to.index] &= ~unavailable_features;
>          }
>      }
> -- 
> 2.18.4
> 

-- 
Eduardo



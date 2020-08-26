Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ABDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F9B52074A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMUXc/Ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B52074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyCv-0004Qb-Q4
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAyBH-00024Z-Ai
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31854
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAyBE-0006U5-CH
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 12:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598458901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YsHjPb4FFMwNeHVseWVR1V5wR7cvs+q2u2S/LJB7KrA=;
 b=DMUXc/GafB6SjX6/u30KdzlJGt9HR21h7F0UZ3IgIxWDBvA7Ybvt1IL7h1R4Xgxb3dy9W5
 UWAs1pAqAtO5v0/BOMAUcMhz+UgWb+sJ6OiaJPROJbH8Is4S/7OD0mx6i1vSVsclhEQcKF
 QCtupG6GWP+kh6lt6/A4bZb94MlQ5Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-CsHi4iHCOq-7Sa20yA7y2Q-1; Wed, 26 Aug 2020 12:21:39 -0400
X-MC-Unique: CsHi4iHCOq-7Sa20yA7y2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14E31074646;
 Wed, 26 Aug 2020 16:21:38 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D17C74E85;
 Wed, 26 Aug 2020 16:21:37 +0000 (UTC)
Date: Wed, 26 Aug 2020 12:21:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] spapr: Correct type for SPAPR_DRC_PCI
Message-ID: <20200826162137.GE642093@habkost.net>
References: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
 <20200825111627.2007820-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200825111627.2007820-4-david@gibson.dropbear.id.au>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 09:16:27PM +1000, David Gibson wrote:
> TYPE_SPAPR_DRC_PCI inherits from TYPE_SPAPR_DRC_PHYSICAL, so its checker
> macro should use the corresponding instance type.  We got away with it
> because we never actually used that checker macro.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  include/hw/ppc/spapr_drc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 21af8deac1..baaaba3c1f 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -59,7 +59,7 @@
>          OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
>  #define SPAPR_DRC_PCI_CLASS(klass) \
>          OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
> -#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> +#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
>                                          TYPE_SPAPR_DRC_PCI)

I'm not sure this is really what we want to do.  This is what
triggered the warning in my script, but it doesn't mean we want
to use SpaprDrcPhysical here.

Code that needs a SpaprDrc* can use SPAPR_DR_CONNECTOR();
code that needs a SpaprDrcPhysical* can use SPAPR_DRC_PHYSICAL().
All the other OBJECT_CHECK(SpaprDrc, ...) and
OBJECT_CHECK(SpaprDrcPhysical, ...) macros seem unnecessary.

-- 
Eduardo



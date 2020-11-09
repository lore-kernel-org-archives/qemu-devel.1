Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0D72084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhmhSk5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0D72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc580-0005ug-DB
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc56q-00050q-Uj
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc56i-0000Cx-8V
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604920387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIrCPB09Eot9KFc0Ep+ljqx3gsu1X7GVxlmZdWBe2lU=;
 b=LhmhSk5Ek8xGltS6bEz9zvBlolR9J6R9AbSDjSD6LNgp4l4OEi8cIkKWt+NZr1pn6bDx7F
 YAW+kUa7PRp/4NwJaJCyeqPrTVUF2FoUE9eqLirB59ukNn/uaeBtBbiAojOcbORzrfxs5t
 iGD2TR1W3UskxXw1AzbGGVhSqPqRt+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-cYbbCk5LPfaYrmYq__QTJg-1; Mon, 09 Nov 2020 06:13:03 -0500
X-MC-Unique: cYbbCk5LPfaYrmYq__QTJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683651005513;
 Mon,  9 Nov 2020 11:13:02 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44DC36EF51;
 Mon,  9 Nov 2020 11:12:57 +0000 (UTC)
Date: Mon, 9 Nov 2020 12:12:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/9] s390x: fix clang 11 warnings in cpu_models.c
Message-ID: <20201109121254.7d28bec1.cohuck@redhat.com>
In-Reply-To: <20201105221905.1350-3-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201105221905.1350-3-dbuono@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390 KVM
 CPUs" <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Nov 2020 17:18:58 -0500
Daniele Buono <dbuono@linux.vnet.ibm.com> wrote:

> There are void * pointers that get casted to enums, in cpu_models.c
> Such casts can result in a small integer type and are caught as
> warnings with clang, starting with version 11:
> 
> Clang 11 finds a bunch of spots in the code that trigger this new warnings:
> 
> ../qemu-base/target/s390x/cpu_models.c:985:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390Feat feat = (S390Feat) opaque;
>                     ^~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1002:21: error: cast to smaller integer type 'S390Feat' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390Feat feat = (S390Feat) opaque;
>                     ^~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1036:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390FeatGroup group = (S390FeatGroup) opaque;
>                           ^~~~~~~~~~~~~~~~~~~~~~
> ../qemu-base/target/s390x/cpu_models.c:1057:27: error: cast to smaller integer type 'S390FeatGroup' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>     S390FeatGroup group = (S390FeatGroup) opaque;
>                           ^~~~~~~~~~~~~~~~~~~~~~
> 4 errors generated.
> 
> Avoid this warning by casting the pointer to uintptr_t first.
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
>  target/s390x/cpu_models.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>



Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B5FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38B6206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IChv2S1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38B6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWII5-0007WD-Qq
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWIHI-00071i-Qv
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:31:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWIHG-0006j9-N7
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588764709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8SVk6eCS0C6IDx3Ix710FaAyICTcWjkz93EMRkG/PI=;
 b=IChv2S1CxkyCBC3dfyiHSLB5Sex938D3Za1unL0JYYftJM2kR1OuJnplRf5H5r4x89GZyy
 6g3okV/ArVtbiF7cpew3SF8FQpFRT2Nv19CwW60jBvmnMc9854nedXhzJhPYcrJbZqFbOx
 yoQv3cZBLhgp/KfSRCKmlJ48r8Jewes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-6WqX1GxXNMyx7ldLvEjV0Q-1; Wed, 06 May 2020 07:31:47 -0400
X-MC-Unique: 6WqX1GxXNMyx7ldLvEjV0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AEE880183C;
 Wed,  6 May 2020 11:31:46 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64CAB63F90;
 Wed,  6 May 2020 11:31:41 +0000 (UTC)
Date: Wed, 6 May 2020 13:31:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 09/18] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes,eaes}-256
Message-ID: <20200506133138.4443502c.cohuck@redhat.com>
In-Reply-To: <20200505152926.18877-10-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
 <20200505152926.18877-10-armbru@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:02:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 17:29:17 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
> s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
> "pcc-cmac-eaes-256".  The former is obviously a pasto.
> 
> Impact:
> 
> * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_256
>   as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions,
>   query-cpu-model-expansion, query-cpu-model-baseline,
>   query-cpu-model-comparison, and the error message when
>   s390_realize_cpu_model() fails in check_compatibility().
> 
> * s390_cpu_list() also misidentifies it.  Affects -cpu help.
> 
> * s390_cpu_model_register_props() creates CPU property
>   "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>   ignored (a later commit will change that).  Results in a single
>   property "pcc-cmac-eaes-256" with the description for
>   S390_FEAT_PCC_CMAC_AES_256, and no property for
>   S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
>   and -device, QMP & HMP device_add, QMP device-list-properties, and
>   QOM introspection.
> 
> Fix by deleting the wayward 'e'.
> 
> Fixes: 782417446279717aa85320191a519b51f6d5dd31

I like the more standard

Fixes: 782417446279 ("s390x/cpumodel: introduce CPU features")

for that.

> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/cpu_features_def.inc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

I assume you'll take this one together with the rest of the series?



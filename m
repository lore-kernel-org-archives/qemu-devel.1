Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDFC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C64E2395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5GNi0kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C64E2395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhjB-0008VB-5S
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKhiV-00082o-NA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKhiT-0002cX-Id
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600778896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pTam75SIfgREABi+zZhXLcdFiE6nTVsXhfh/eAeyKCg=;
 b=d5GNi0kMKeRpca9qorhETHHzn1RyeeZXlglFt7a6Q6BOa8wlZ4r378OgPx9eEb4Y+PdZ25
 f9q09jBr9P09Ui97CKT/dNAIgMKgdCTi1wAvy9lVKUyFHDvhMNpoKjOGukIm5vx7Xe3aLy
 W86ocQMxdoBj/rBYvIa2i14+4J1OeSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Y36Q7PEGOFOMdVhg7Hb2GQ-1; Tue, 22 Sep 2020 08:48:14 -0400
X-MC-Unique: Y36Q7PEGOFOMdVhg7Hb2GQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4000B8FDC8D;
 Tue, 22 Sep 2020 12:47:59 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D53B11A8EC;
 Tue, 22 Sep 2020 12:47:58 +0000 (UTC)
Date: Tue, 22 Sep 2020 08:47:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 14/24] i386: Register feature bit properties as class
 properties
Message-ID: <20200922124758.GX57321@habkost.net>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-15-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921221045.699690-15-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 06:10:35PM -0400, Eduardo Habkost wrote:
> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  target/i386/cpu.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 66792f28ba7..1aba87e0a5b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6819,16 +6819,17 @@ static void x86_cpu_release_bit_prop(Object *obj, const char *name,
>   * multiple bits in the same FeatureWord. In that case, the getter will return
>   * true only if all bits are set.
>   */
> -static void x86_cpu_register_bit_prop(X86CPU *cpu,
> +static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
>                                        const char *prop_name,
>                                        FeatureWord w,
>                                        int bitnr)
>  {
> +    ObjectClass *oc = OBJECT_CLASS(xcc);
>      BitProperty *fp;
>      ObjectProperty *op;
>      uint64_t mask = (1ULL << bitnr);
>  
> -    op = object_property_find(OBJECT(cpu), prop_name, NULL);
> +    op = object_class_property_find(oc, prop_name, NULL);
>      if (op) {
>          fp = op->opaque;
>          assert(fp->w == w);
> @@ -6837,14 +6838,14 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
>          fp = g_new0(BitProperty, 1);
>          fp->w = w;
>          fp->mask = mask;
> -        object_property_add(OBJECT(cpu), prop_name, "bool",
> -                            x86_cpu_get_bit_prop,
> -                            x86_cpu_set_bit_prop,
> -                            x86_cpu_release_bit_prop, fp);
> +        object_class_property_add(oc, prop_name, "bool",
> +                                  x86_cpu_get_bit_prop,
> +                                  x86_cpu_set_bit_prop,
> +                                  x86_cpu_release_bit_prop, fp);

This one is broken.  x86_cpu_release_bit_prop() frees fp, and
now fp should never be freed.  The release function shouldn't be
set.

I will send a new version of this patch later.

> [...]

-- 
Eduardo



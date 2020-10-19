Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C2D222EA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1h8XnTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C2D222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYLK-0006h3-2X
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUYJt-00057d-Ox
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kUYJr-0007da-Pt
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603126054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6+/psbPsJ2sdV3kNFa//0/F0KfQGmEIHWD2GfmJUbYg=;
 b=i1h8XnTyLkO0S/9tDOd0Ts9EOpQ5h4yjvbHT32Uf2oHSNABCLgf3TugoL4Up+p3aXRaJS+
 /3O/INnrwDzkXCEsdumOIzch/fc6jBOm53UUZ2k50ZUqh351ZEu8++hJ84vtL+gg/LbESp
 w45ruv7S3Tq9Hglmw1xjWglQzlDy+D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-9vbzWFbqOZWLygpcDNN1Kg-1; Mon, 19 Oct 2020 12:47:33 -0400
X-MC-Unique: 9vbzWFbqOZWLygpcDNN1Kg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D82835B91;
 Mon, 19 Oct 2020 16:47:31 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A3155D9D2;
 Mon, 19 Oct 2020 16:47:31 +0000 (UTC)
Date: Mon, 19 Oct 2020 12:47:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: tobin@linux.ibm.com
Subject: Re: [PATCH v5] sev: add sev-inject-launch-secret
Message-ID: <20201019164730.GN5733@habkost.net>
References: <20201015143713.14682-1-tobin@linux.ibm.com>
 <20201019164604.GM5733@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20201019164604.GM5733@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 12:46:08PM -0400, Eduardo Habkost wrote:
> On Thu, Oct 15, 2020 at 10:37:13AM -0400, tobin@linux.ibm.com wrote:
> [...]
> > diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> > index 88e3f39a1e..2d2ee54cc6 100644
> > --- a/target/i386/sev-stub.c
> > +++ b/target/i386/sev-stub.c
> > @@ -49,3 +49,8 @@ SevCapability *sev_get_capabilities(Error **errp)
> >      error_setg(errp, "SEV is not available in this QEMU");
> >      return NULL;
> >  }
> > +int sev_inject_launch_secret(const char *hdr, const char *secret,
> > +                             uint64_t gpa)
> > +{
> > +    return 1;
> > +}
> 
> This doesn't match the actual function prototype.  I had to apply the following
> fixup:
> 
> ---
> diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
> index 2d2ee54cc6..62a2587e7b 100644
> --- a/target/i386/sev-stub.c
> +++ b/target/i386/sev-stub.c
> @@ -49,8 +49,10 @@ SevCapability *sev_get_capabilities(Error **errp)
>      error_setg(errp, "SEV is not available in this QEMU");
>      return NULL;
>  }
> +
>  int sev_inject_launch_secret(const char *hdr, const char *secret,
> -                             uint64_t gpa)
> +                             uint64_t gpa, Error *errp)

Oops. Fixing up the fixup:

---
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index 62a2587e7b..e4e60d9a7d 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -51,7 +51,7 @@ SevCapability *sev_get_capabilities(Error **errp)
 }
 
 int sev_inject_launch_secret(const char *hdr, const char *secret,
-                             uint64_t gpa, Error *errp)
+                             uint64_t gpa, Error **errp)
 {
     error_setg(errp, "SEV is not available in this QEMU");
     return 1;

-- 
Eduardo



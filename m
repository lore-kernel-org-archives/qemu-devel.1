Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDC2C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0D0D22D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYw+RUT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D0D22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKBq-0002SA-93
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSKAR-0001N0-ND
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSKAO-0007ty-IR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602594995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkub7lJLYsiYoZ8mSCPCNA+GyHkVacpLukHZzYiTpNE=;
 b=JYw+RUT9DW+u/Zz/Nv/XfzR1fhvqpBfQK6BGk1imX6t8cYcW2pUDLNpKqqqLCPB75OJ3Hb
 dxZHqiEJd3HgVt266WrDSCz5XAFooid810r8ABxWymojpu7qliaEi3yJAGzg6E4m/vhOyr
 4ld1Z53O8cGjbA89DYlSkKB7DVB5RSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-atod2wszMvyKxuIk3KImhA-1; Tue, 13 Oct 2020 09:16:32 -0400
X-MC-Unique: atod2wszMvyKxuIk3KImhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65E6864089;
 Tue, 13 Oct 2020 13:16:30 +0000 (UTC)
Received: from localhost (ovpn-117-88.rdu2.redhat.com [10.10.117.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF3895C1C2;
 Tue, 13 Oct 2020 13:16:29 +0000 (UTC)
Date: Tue, 13 Oct 2020 09:16:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] qom: Fix "typddef" typo
Message-ID: <20201013131628.GK7303@habkost.net>
References: <20201007220255.1170167-1-ehabkost@redhat.com>
 <20201012144512.GI39408@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201012144512.GI39408@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 03:45:12PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 07, 2020 at 06:02:55PM -0400, Eduardo Habkost wrote:
> > Fix typo introduced in the C11 #ifdef for qemu_max_align_t.  It
> > never caused any problems because we always compile using
> > -std=gnu99.
> > 
> > Fixes: 4c880f363e9e ("qom: Allow objects to be allocated with increased alignment")
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  qom/object.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/qom/object.c b/qom/object.c
> > index c335dce7e4..125dabd28b 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -692,7 +692,7 @@ static void object_finalize(void *data)
> >  
> >  /* Find the minimum alignment guaranteed by the system malloc. */
> >  #if __STDC_VERSION__ >= 201112L
> > -typddef max_align_t qemu_max_align_t;
> > +typedef max_align_t qemu_max_align_t;
> >  #else
> 
> Why do we need / have this first part of the #if at all ?  We
> unconditionally add  -std=gnu99, so surely this has always
> been dead code and can just be better deleted.

It has the same function as a comment saying "we can use
max_align_t as soon as we move to C11".  The difference is that
it doesn't need us to manually change the code once we do.

-- 
Eduardo



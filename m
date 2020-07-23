Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD80C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EBD206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTu0rE3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EBD206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZqk-0006l6-V8
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyZq1-0006DK-6n
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:56:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55987
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyZpx-0005NU-JB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595505392;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ol1dyGIkVSexYjVIJrLEM9pNiGDilq9KxXDkLr3odFU=;
 b=cTu0rE3rOmklZWozroYLeDW/tsoq69GwqhqUtBfEXzetgpIaxZOwDLxo3J96Gx922/Krbn
 VWovtJCrFKom44hV4CqU9Gm7INDWZiQ0Xfegca17MAf7eRy/w9xJvsboeT7uWKClbylcj0
 4dpgbF3365uF4RIKNf9RNg45/Is/8ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-2TMJNPq4MGmukXkZN1JwhQ-1; Thu, 23 Jul 2020 07:56:24 -0400
X-MC-Unique: 2TMJNPq4MGmukXkZN1JwhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B5011902EA0;
 Thu, 23 Jul 2020 11:56:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 211161001B2C;
 Thu, 23 Jul 2020 11:56:21 +0000 (UTC)
Date: Thu, 23 Jul 2020 12:56:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: enable use of g_autoptr with QAPI types
Message-ID: <20200723115619.GG2615312@redhat.com>
References: <20200723111250.2650203-1-berrange@redhat.com>
 <781b8043-bce5-9f64-bc5f-4f2f740c6a6d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <781b8043-bce5-9f64-bc5f-4f2f740c6a6d@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 06:49:44AM -0500, Eric Blake wrote:
> On 7/23/20 6:12 AM, Daniel P. Berrangé wrote:
> > Currently QAPI generates a type and function for free'ing it:
> > 
> >    typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
> >    void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions *obj);
> > 
> 
> > The above code example now becomes
> > 
> >    g_autoptr(QCryptoBlockCreateOptions) opts = NULL;
> > 
> >    opts = g_new0(QCryptoBlockCreateOptions, 1);
> > 
> >    ....do stuff with opts...
> > 
> > Note, if the local pointer needs to live beyond the scope holding the
> > variable, then g_steal_pointer can be used. This is useful to return the
> > pointer to the caller in the success codepath, while letting it be freed
> > in all error codepaths.
> > 
> >    return g_steal_pointer(&opts);
> > 
> 
> Yep, the idea makes sense!
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   include/crypto/block.h | 2 --
> >   scripts/qapi/types.py  | 1 +
> >   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> Missing a counterpart change to docs/devel/qapi-code-gen.txt.  And it might
> be nice to make this a series with at least one followup patch using the new
> capability, or at least so 'make check' coverage.  But otherwise on the
> right track.

The crypto/block.c already makes use of this capability, which is why
I had to remove the line from block.h to avoid declaring the same thing
twice !

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



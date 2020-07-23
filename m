Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2D7C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C9420768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6R4jsJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C9420768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyak8-0008Ms-Pc
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyai0-0005L6-Rr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:52:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyahy-0007Qw-5F
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595508741;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hqXqmGtpniuhIKde2X41O5bDpuelG1NVZBzPwSPNVAs=;
 b=c6R4jsJjX4q0cAZ3TndlGy/PiTAN4ilIhK4+6wgb2YZC66v6PS+C340ArYa+jamfeoXTkZ
 PpPQShIOUqOm9gQhWM6qttOKry+s4QBGuMqxzWCJT5pjlHSth8zyIwi2TqWX8pjWFDPgx3
 bzPB0oKfqecp+gxgrGGD7dVqQ0moqj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-CvRepwb-Pxahllnwyy_91g-1; Thu, 23 Jul 2020 08:52:17 -0400
X-MC-Unique: CvRepwb-Pxahllnwyy_91g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 544ED1009442;
 Thu, 23 Jul 2020 12:52:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E746887B00;
 Thu, 23 Jul 2020 12:52:14 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:52:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qapi: enable use of g_autoptr with QAPI types
Message-ID: <20200723125211.GI2615312@redhat.com>
References: <20200723111250.2650203-1-berrange@redhat.com>
 <781b8043-bce5-9f64-bc5f-4f2f740c6a6d@redhat.com>
 <20200723115619.GG2615312@redhat.com>
 <87a6zqgztg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a6zqgztg.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 02:50:51PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jul 23, 2020 at 06:49:44AM -0500, Eric Blake wrote:
> >> On 7/23/20 6:12 AM, Daniel P. Berrangé wrote:
> >> > Currently QAPI generates a type and function for free'ing it:
> >> > 
> >> >    typedef struct QCryptoBlockCreateOptions QCryptoBlockCreateOptions;
> >> >    void qapi_free_QCryptoBlockCreateOptions(QCryptoBlockCreateOptions *obj);
> >> > 
> >> 
> >> > The above code example now becomes
> >> > 
> >> >    g_autoptr(QCryptoBlockCreateOptions) opts = NULL;
> >> > 
> >> >    opts = g_new0(QCryptoBlockCreateOptions, 1);
> >> > 
> >> >    ....do stuff with opts...
> >> > 
> >> > Note, if the local pointer needs to live beyond the scope holding the
> >> > variable, then g_steal_pointer can be used. This is useful to return the
> >> > pointer to the caller in the success codepath, while letting it be freed
> >> > in all error codepaths.
> >> > 
> >> >    return g_steal_pointer(&opts);
> >> > 
> >> 
> >> Yep, the idea makes sense!
> 
> Agree.
> 
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >> > ---
> >> >   include/crypto/block.h | 2 --
> >> >   scripts/qapi/types.py  | 1 +
> >> >   2 files changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> Missing a counterpart change to docs/devel/qapi-code-gen.txt.
> 
> Yes.  Can do that in my tree.
> 
> >>                                                                And it might
> >> be nice to make this a series with at least one followup patch using the new
> >> capability, or at least so 'make check' coverage.  But otherwise on the
> >> right track.
> >
> > The crypto/block.c already makes use of this capability, which is why
> > I had to remove the line from block.h to avoid declaring the same thing
> > twice !
> 
> Could be mentioned in the commit message.
> 
> Still, using it somewhere in tests would be nice.
> test-qobject-input-visitor.c's test_visitor_in_struct_nested() looks
> trivial to convert.  Feel free to pick something else.

Ok, I'll convert some.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



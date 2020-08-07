Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C639C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6B622CAE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFq1NT01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6B622CAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Ij-0000yo-6d
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k40I9-0000YT-JL
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:12:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k40I7-0006nH-Eu
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596798722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgu/cGMaNyjX8jZfI2hF2PbdXwRWAt/5NiQ4n39Z76I=;
 b=dFq1NT01Y/CGj3NLmSDheM6IG/K7yn7VTRXUi4d8hNTkbmfk7c3kldEsLKZ019ud/QOuW4
 pGRzKPBLk5dSorU+pH/ljREqub02BXgMX7G3Maa6C/15Qd06f5Ovyhd3uuSv+gnBPCoVF1
 rrlJDp+A2RAGIMrNdrczdiD/jCniZcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-AfH5zrskORmUKFmIwRoM9w-1; Fri, 07 Aug 2020 07:11:54 -0400
X-MC-Unique: AfH5zrskORmUKFmIwRoM9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65C8D18FF662;
 Fri,  7 Aug 2020 11:11:53 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B899F2DE72;
 Fri,  7 Aug 2020 11:11:51 +0000 (UTC)
Date: Fri, 7 Aug 2020 12:11:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 3/4] crypto: use QOM macros for declaration/definition of
 secret types
Message-ID: <20200807111148.GI120942@redhat.com>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-4-berrange@redhat.com>
 <20200723185006.GR1274972@habkost.net>
 <20200724091245.GC3146350@redhat.com>
 <20200806180154.GE1700540@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20200806180154.GE1700540@habkost.net>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:53:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 02:01:54PM -0400, Eduardo Habkost wrote:
> On Fri, Jul 24, 2020 at 10:12:45AM +0100, Daniel P. BerrangÃÂ© wrote:
> > On Thu, Jul 23, 2020 at 02:50:06PM -0400, Eduardo Habkost wrote:
> > > On Thu, Jul 23, 2020 at 07:14:09PM +0100, Daniel P. BerrangÃÂ© wrote:
> > > > This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
> > > > families in the secret types, in order to eliminate boilerplate code.
> > > > 
> > > > Signed-off-by: Daniel P. BerrangÃÂ© <berrange@redhat.com>
> > > > ---
> > > >  crypto/secret.c                 | 24 ++++--------------------
> > > >  crypto/secret_common.c          | 32 +++++++++-----------------------
> > > >  crypto/secret_keyring.c         | 28 +++++++++-------------------
> > > >  include/crypto/secret.h         | 11 ++---------
> > > >  include/crypto/secret_common.h  | 13 ++-----------
> > > >  include/crypto/secret_keyring.h | 18 ++----------------
> > > >  6 files changed, 28 insertions(+), 98 deletions(-)
> > > > 
> > > 
> > > Beautiful.
> > > 
> > > I wonder how hard it would be to automate this.  I'm assuming
> > > Coccinelle won't be able to deal with the macro definitions, but
> > > a handwritten conversion script would be really useful for
> > > dealing with our 1226 static TypeInfo structs.
> > 
> > Probably possible to do a reasonably good job with a perl script or
> > similar. The code patterns to be replaced are reasonably easy to
> > identify with a few regexes.
> 
> I've attempted to parse all the TypeInfo structs in the tree.
> The data I've extracted is available at:
> https://gist.github.com/ehabkost/7a398640492f369685c789ffed0f67aa
> 
> It turns out 230 of our 1259 TypeInfo variables don't have
> instance_size set and don't have their own struct type defined.
> 
> We could:
> * Make that a supported use case, and add helper macros that don't
>   require MyDevice to be defined;
> * Make that not supported, and convert those 230 types automatically; or
> * Make that not supported, and convert those 230 types manually.

When we force an instance struct, we also force definition of an
instance init and finalize function.

230 types is probably enough to justify a further macro that allows
the instance struct, init & finalize funtions to be omitted.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



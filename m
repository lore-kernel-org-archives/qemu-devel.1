Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB57C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D50207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POa2+9XE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D50207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRwc-0006VC-8l
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGRWy-0001Az-BI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:42:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40533
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGRWw-00062b-34
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599763364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2dlaFLZnvytt+snVsWio5eSKLiVeNl9+rmakb0oaao=;
 b=POa2+9XEJda/p9jMeM4MakbI7RGlHyLMZrmTfg781VWqjiDWSi2TTFQhonaA999UEFDo/I
 FSEbnW7fP0o9+V2uUKNmf9neaw8rii1/hUT4H4Xs/GeAZwuL6rMxSoOD+dbUCu5mlz42w5
 7zgYlTvUeyEJzb0bkxMSOyYU1TfB9IM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225--Delm-AVM_K0Br_iz_Fb6g-1; Thu, 10 Sep 2020 14:42:43 -0400
X-MC-Unique: -Delm-AVM_K0Br_iz_Fb6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D1FE1084D61
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 18:42:42 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 309187512B;
 Thu, 10 Sep 2020 18:42:32 +0000 (UTC)
Date: Thu, 10 Sep 2020 19:42:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Subject: Re: [PATCH v2 6/6] tools/virtiofsd: xattr name mapping examples
Message-ID: <20200910184229.GP2814@work-vm>
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-7-dgilbert@redhat.com>
 <20200909113553.GE1377607@lpt>
MIME-Version: 1.0
In-Reply-To: <20200909113553.GE1377607@lpt>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: virtio-fs@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Ján Tomko (jtomko@redhat.com) wrote:
> On a Thursday in 2020, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add a few examples of xattrmaps to the documentation.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> > docs/tools/virtiofsd.rst | 49 ++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 49 insertions(+)
> > 
> > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > index 2efa16d3c5..a138549862 100644
> > --- a/docs/tools/virtiofsd.rst
> > +++ b/docs/tools/virtiofsd.rst
> > @@ -161,6 +161,55 @@ in which case a 'server' rule will always match on all names from
> > the server.
> > 
> > 
> > +xattr-mapping Examples
> > +----------------------
> > +
> > +1) Prefix all attributes with 'user.virtiofs.'
> > +
> > +::
> > +
> > +-o xattrmap=":all:prefix::user.virtiofs.::all:bad:::"
> > +
> > +
> > +This uses two rules, using : as the field separator;
> > +the first rule prefixes and strips 'user.virtiofs.',
> > +the second rule hides any non-prefixed attributes that
> > +the host set.
> > +
> > +2) Prefix 'trusted.' attributes, allow others through
> > +
> > +::
> > +
> > +   "/all/prefix/trusted./user.virtiofs./
> > +    /server/bad//trusted./
> > +    /client/bad/user.virtiofs.trusted.//
> > +    /all/ok///"
> > +
> > +
> > +Here there are four rules, using / as the field
> > +separator, and also demonstrating that new lines can
> > +be included between rules.
> > +The first rule is the prefixing of 'trusted.'.
> > +The second rule hides unprefixed 'trusted.' attributes
> > +on the host.
> > +The third rule stops a guest from explicitily setting
> 
> explicitly

Thanks, I'll save that spare 'i' for another time.

> > +the 'user.viritofs.trusted.' path directly.
> > +Finally, the fourth rule lets all remaining attributes
> > +through.
> > +
> > +3) Hide 'security.' attributes, and allow everything else
> > +
> > +::
> > +
> > +    "/all/bad/security./security./
> > +     /all/ok///'
> > +
> > +The first rule combines what could be separate client and server
> > +rules into a single 'all' rule, matching 'security.' in either
> > +client arguments or lists returned from the host.  This stops
> > +the client seeing any 'security.' attributes on the server and
> > +stops it setting  any.
> 
> extra space.

Gone.

> Reviewed-by: Ján Tomko <jtomko@redhat.com>

Thanks!

> 
> Jano


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7535C388F2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEEB206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRSMPpYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEEB206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvuJ-00013n-5Q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUvry-0007Bv-0Z
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUvrv-0003pR-3Q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603216574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ib91Cd0UVtXBNYoagh3Hg5lKuHv+KxcNmAUniMgqS4k=;
 b=jRSMPpYVr/U3AJRbWitCxpsbcVJ+Vj2O8G4mGpOxf6lx6oUc+vrzhU3uEIGmPVNKllaO6B
 lnILX6QU9RfEACtdwMdIuJVQIjYkEvo7pLrNdVyC3zGUHpXdjpE54uFWlKCplcMxYH0KZe
 J3D+nGR315u78QD4skP8GpjqTp2DmxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-XlJdSr6vPPCBidZpDwFkdw-1; Tue, 20 Oct 2020 13:56:12 -0400
X-MC-Unique: XlJdSr6vPPCBidZpDwFkdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27FC664143
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 17:56:11 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-203.rdu2.redhat.com [10.10.115.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1C16266E;
 Tue, 20 Oct 2020 17:56:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 0BC5D220307; Tue, 20 Oct 2020 13:56:01 -0400 (EDT)
Date: Tue, 20 Oct 2020 13:56:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201020175600.GE380917@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-5-dgilbert@redhat.com>
 <20201020144041.GC380917@redhat.com>
 <20201020153443.GD2962@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201020153443.GD2962@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 04:34:43PM +0100, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > On Wed, Oct 14, 2020 at 07:02:08PM +0100, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > Add a few examples of xattrmaps to the documentation.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > > 
> > > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > > index a3a120da2f..5cb64612ed 100644
> > > --- a/docs/tools/virtiofsd.rst
> > > +++ b/docs/tools/virtiofsd.rst
> > > @@ -163,6 +163,56 @@ in which case a 'server' rule will always match on all names from
> > >  the server.
> > >  
> > >  
> > > +xattr-mapping Examples
> > > +----------------------
> > > +
> > > +1) Prefix all attributes with 'user.virtiofs.'
> > > +
> > > +::
> > > +
> > > +-o xattrmap=":prefix:all::user.virtiofs.::bad:all:::"
> > > +
> > 
> > Staring at rule.
> > 
> > ":bad:all:::"
> > 
> > and trying to map this to ":type:scope:key:prepend:"
> > 
> > type==bad
> > scope==all
> > key==""
> > prepend==""
> 
> Correct.
> 
> > > +
> > > +This uses two rules, using : as the field separator;
> > > +the first rule prefixes and strips 'user.virtiofs.',
> > > +the second rule hides any non-prefixed attributes that
> > > +the host set.
> > 
> > What is non-prefixed xattr in this context. If client sends
> > "security.selinux", is prefixed or non-prefixed.
> 
> Note that anything originating at the client (i.e. starting with "")
> will get caught by the first rule and be prefixed with 'user.virtiofs.'

So first rule is.

:prefix:all::user.virtiofs.:

scope="all"
key==""
prepend="user.virtiofs."

Given scope, rule applies to both client and server. Given key is "",
any income setxattr() request will be prefixed with "user.virtiofs".
And how does this rule work for server (listxattr()). It will match
prepend "user.virtiofs" and if that matches it will be stripped?


> This second rule will only be triggered by an xattr name coming
> from the server (i.e a listxattr) for a name that doesn't begin
> with user.virtiofs. (i.e. didn't match the 1st rule for a server xattr).
> This makes sure that only guest created xattr's (that were set and
> had a prefix added) are then visible to the guest.

Ok, so if an xattr does not match first rule, then second rule says
key="", prepend="" and that will match all xattrs. So anything which
is not caught by first rule, will be caught by second rule and
either rejected or filtered out.

> 
> > Documentation in first patch said.
> > 
> > +- 'bad' - If a client tries to use this name it's
> > +  denied using EPERM; when the server passes an attribute
> > +  name matching it's hidden.
> > 
> > I am not sure which xattr name will be blocked if key=="" and prepend==""
> 
> All of them; they're still matched at the beginning; as the first
> patch says 'It maybe empty in which case a 'client' rule will always
> match on client names'

Ok.

> 
> > > +2) Prefix 'trusted.' attributes, allow others through
> > > +
> > > +::
> > > +
> > > +   "/prefix/all/trusted./user.virtiofs./
> > > +    /bad/server//trusted./
> > > +    /bad/client/user.virtiofs.//
> > > +    /ok/all///"
> > > +
> > > +
> > > +Here there are four rules, using / as the field
> > > +separator, and also demonstrating that new lines can
> > > +be included between rules.
> > > +The first rule is the prefixing of 'trusted.' and
> > > +stripping of 'user.virtiofs.'.
> > 
> > So this is bidrectional rule, right. For setxattr(), "trusted."
> > will be replaced with "user.virtiofs" and for listxattr(),
> > server will replace user.virtiofs with trusted. ?
> 
> prefixed not replaced; so it'll turn "trusted." into
> "user.virtiofs.trusted." and strip it back off for listxattr.

Ok. Got it. I am wondering how will I specify these rules so that
they work in nested configuration. Say I have L0 host, L1 guest and
L2 guest. Say virtiofsd0 is running on L0 and virtiofsd1 is running
on L1. 

I am wondering how will I specify the rules on virtiofsd0 and virtiofsd1
so that it works. Will it be same or rules are level dependent.

> 
> > > +The second rule hides unprefixed 'trusted.' attributes
> > > +on the host.
> > 
> > If host has "trusted.*", we are not hiding it and as per first
> > rule we are converting it to "user.virtiofs.trusted.*", right?
> > So why this second rule is needed.
> 
> No, the first rule will only prefix strings provided by the guest
> and strip strings provided by the server. This rule hides
> existing server 'trusted.' xattrs - so if the guest sets
> trusted.foo it's not confused by also seeing a server trusted.foo
> 
> > > +The third rule stops a guest from explicitly setting
> > > +the 'user.viritofs.' path directly.
> > > +Finally, the fourth rule lets all remaining attributes
> > > +through.
> > 
> > So If I don't specify third rule, and client does
> > setxattr(user.virtiofs.*), it will simply be a passthrough?
> 
> Right; and that's dangerous, because a non-privileged guest
> process can set a user. xattr; so a non-priv guest process could
> set user.virtiofs.trusted.foo and then it would get read back
> and be used as trusted.foo that has an impact on priviliged processes.

Right. We don't want unpriviliged process to be able to setup
user.virtiofs.trusted.*. But that's what precisely happen in
a nested configuration.

In above example, L2 will set trusted.foo, virtiofsd1 wil convert it
to user.virtiofs.trusted.foo and virtiofsd0 will reject it, breaking
the nested virtiofs.

Thanks
Vivek



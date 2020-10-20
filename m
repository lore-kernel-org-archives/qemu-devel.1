Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED2CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28052222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M74SPkl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28052222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtgA-0002xe-Lp
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUtfF-0001zt-Aq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kUtfC-0000n4-Ob
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603208101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BriWYyBElqLphqLN8wSaGmFTpiXrcZgiTq60A+lffpc=;
 b=M74SPkl0Dr0QNMd9ZsEmDnrtZdgYSaICdxTb6QBqftkRHQqYx5K/ThfWCBYD7Y2D7BpNYc
 RkTLzsp53XYM8x2i5ieQDuiQP9PG/AHQwXL4gzBE5QbGCcYRD40Rr5M8xmeT8T60d/zdad
 u9nqMN76UQjYUMdaIwnPD2CVeXHILSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-H9XbHqDkP_GJEXLVYLxBdQ-1; Tue, 20 Oct 2020 11:34:58 -0400
X-MC-Unique: H9XbHqDkP_GJEXLVYLxBdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C95C210E2183
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 15:34:57 +0000 (UTC)
Received: from work-vm (ovpn-113-116.ams2.redhat.com [10.36.113.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B49A5D9CD;
 Tue, 20 Oct 2020 15:34:47 +0000 (UTC)
Date: Tue, 20 Oct 2020 16:34:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201020153443.GD2962@work-vm>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-5-dgilbert@redhat.com>
 <20201020144041.GC380917@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020144041.GC380917@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> On Wed, Oct 14, 2020 at 07:02:08PM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Add a few examples of xattrmaps to the documentation.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >=20
> > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > index a3a120da2f..5cb64612ed 100644
> > --- a/docs/tools/virtiofsd.rst
> > +++ b/docs/tools/virtiofsd.rst
> > @@ -163,6 +163,56 @@ in which case a 'server' rule will always match on=
 all names from
> >  the server.
> > =20
> > =20
> > +xattr-mapping Examples
> > +----------------------
> > +
> > +1) Prefix all attributes with 'user.virtiofs.'
> > +
> > +::
> > +
> > +-o xattrmap=3D":prefix:all::user.virtiofs.::bad:all:::"
> > +
>=20
> Staring at rule.
>=20
> ":bad:all:::"
>=20
> and trying to map this to ":type:scope:key:prepend:"
>=20
> type=3D=3Dbad
> scope=3D=3Dall
> key=3D=3D""
> prepend=3D=3D""

Correct.

> > +
> > +This uses two rules, using : as the field separator;
> > +the first rule prefixes and strips 'user.virtiofs.',
> > +the second rule hides any non-prefixed attributes that
> > +the host set.
>=20
> What is non-prefixed xattr in this context. If client sends
> "security.selinux", is prefixed or non-prefixed.

Note that anything originating at the client (i.e. starting with "")
will get caught by the first rule and be prefixed with 'user.virtiofs.'
This second rule will only be triggered by an xattr name coming
from the server (i.e a listxattr) for a name that doesn't begin
with user.virtiofs. (i.e. didn't match the 1st rule for a server xattr).
This makes sure that only guest created xattr's (that were set and
had a prefix added) are then visible to the guest.

> Documentation in first patch said.
>=20
> +- 'bad' - If a client tries to use this name it's
> +  denied using EPERM; when the server passes an attribute
> +  name matching it's hidden.
>=20
> I am not sure which xattr name will be blocked if key=3D=3D"" and prepend=
=3D=3D""

All of them; they're still matched at the beginning; as the first
patch says 'It maybe empty in which case a 'client' rule will always
match on client names'

> > +2) Prefix 'trusted.' attributes, allow others through
> > +
> > +::
> > +
> > +   "/prefix/all/trusted./user.virtiofs./
> > +    /bad/server//trusted./
> > +    /bad/client/user.virtiofs.//
> > +    /ok/all///"
> > +
> > +
> > +Here there are four rules, using / as the field
> > +separator, and also demonstrating that new lines can
> > +be included between rules.
> > +The first rule is the prefixing of 'trusted.' and
> > +stripping of 'user.virtiofs.'.
>=20
> So this is bidrectional rule, right. For setxattr(), "trusted."
> will be replaced with "user.virtiofs" and for listxattr(),
> server will replace user.virtiofs with trusted. ?

prefixed not replaced; so it'll turn "trusted." into
"user.virtiofs.trusted." and strip it back off for listxattr.

> > +The second rule hides unprefixed 'trusted.' attributes
> > +on the host.
>=20
> If host has "trusted.*", we are not hiding it and as per first
> rule we are converting it to "user.virtiofs.trusted.*", right?
> So why this second rule is needed.

No, the first rule will only prefix strings provided by the guest
and strip strings provided by the server. This rule hides
existing server 'trusted.' xattrs - so if the guest sets
trusted.foo it's not confused by also seeing a server trusted.foo

> > +The third rule stops a guest from explicitly setting
> > +the 'user.viritofs.' path directly.
> > +Finally, the fourth rule lets all remaining attributes
> > +through.
>=20
> So If I don't specify third rule, and client does
> setxattr(user.virtiofs.*), it will simply be a passthrough?

Right; and that's dangerous, because a non-privileged guest
process can set a user. xattr; so a non-priv guest process could
set user.virtiofs.trusted.foo and then it would get read back
and be used as trusted.foo that has an impact on priviliged processes.

Dave

> Thanks
> Vivek
>=20
> > +
> > +3) Hide 'security.' attributes, and allow everything else
> > +
> > +::
> > +
> > +    "/bad/all/security./security./
> > +     /ok/all///'
> > +
> > +The first rule combines what could be separate client and server
> > +rules into a single 'all' rule, matching 'security.' in either
> > +client arguments or lists returned from the host.  This stops
> > +the client seeing any 'security.' attributes on the server and
> > +stops it setting any.
> > +
> >  Examples
> >  --------
> > =20
> > --=20
> > 2.28.0
> >=20
--=20
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



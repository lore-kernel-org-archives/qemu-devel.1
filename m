Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356BC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955E220BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqeXYbti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVERT-0007ot-Io
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kVEPi-0006RJ-Ix
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:44:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kVEPf-0006XJ-N6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 09:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603287862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EDTfTyjgClGcv87eNOUpAB2vsdgpJ80iCtUh1j9L/DY=;
 b=PqeXYbti7TS0AYHd4Qx3FFZ/6f/BctBIdD3rUMMnAl+hu0zhV+c5IF0hjv6HJpTZd2gM38
 j9egVgaXsT2sIKevTL4Sts58dIwWcuIrChz3Q43PAkzdbXKQRzQkSR0QOkyx7oU/ipFOQA
 9PwSzCaYwhdFJ5ilWwCyV2SUPWxvV+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-n28DB1RHOq2srroo2Pt7Hg-1; Wed, 21 Oct 2020 09:44:20 -0400
X-MC-Unique: n28DB1RHOq2srroo2Pt7Hg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E56F68799EF
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 13:44:18 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-107.rdu2.redhat.com [10.10.116.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 986A160DA0;
 Wed, 21 Oct 2020 13:44:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 130D8222F9C; Wed, 21 Oct 2020 09:44:08 -0400 (EDT)
Date: Wed, 21 Oct 2020 09:44:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201021134408.GA442437@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-5-dgilbert@redhat.com>
 <20201020144041.GC380917@redhat.com>
 <20201020153443.GD2962@work-vm>
 <20201020175600.GE380917@redhat.com>
 <20201020190237.GG2962@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201020190237.GG2962@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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

On Tue, Oct 20, 2020 at 08:02:37PM +0100, Dr. David Alan Gilbert wrote:

[..]
> > > > > +2) Prefix 'trusted.' attributes, allow others through
> > > > > +
> > > > > +::
> > > > > +
> > > > > +   "/prefix/all/trusted./user.virtiofs./
> > > > > +    /bad/server//trusted./
> > > > > +    /bad/client/user.virtiofs.//
> > > > > +    /ok/all///"
> > > > > +
> > > > > +
> > > > > +Here there are four rules, using / as the field
> > > > > +separator, and also demonstrating that new lines can
> > > > > +be included between rules.
> > > > > +The first rule is the prefixing of 'trusted.' and
> > > > > +stripping of 'user.virtiofs.'.
> > > > 
> > > > So this is bidrectional rule, right. For setxattr(), "trusted."
> > > > will be replaced with "user.virtiofs" and for listxattr(),
> > > > server will replace user.virtiofs with trusted. ?
> > > 
> > > prefixed not replaced; so it'll turn "trusted." into
> > > "user.virtiofs.trusted." and strip it back off for listxattr.
> > 
> > Ok. Got it. I am wondering how will I specify these rules so that
> > they work in nested configuration. Say I have L0 host, L1 guest and
> > L2 guest. Say virtiofsd0 is running on L0 and virtiofsd1 is running
> > on L1. 
> > 
> > I am wondering how will I specify the rules on virtiofsd0 and virtiofsd1
> > so that it works. Will it be same or rules are level dependent.
> 
> I'm hoping it'll be the same, see below.
> 
> > > 
> > > > > +The second rule hides unprefixed 'trusted.' attributes
> > > > > +on the host.
> > > > 
> > > > If host has "trusted.*", we are not hiding it and as per first
> > > > rule we are converting it to "user.virtiofs.trusted.*", right?
> > > > So why this second rule is needed.
> > > 
> > > No, the first rule will only prefix strings provided by the guest
> > > and strip strings provided by the server. This rule hides
> > > existing server 'trusted.' xattrs - so if the guest sets
> > > trusted.foo it's not confused by also seeing a server trusted.foo
> > > 
> > > > > +The third rule stops a guest from explicitly setting
> > > > > +the 'user.viritofs.' path directly.
> > > > > +Finally, the fourth rule lets all remaining attributes
> > > > > +through.
> > > > 
> > > > So If I don't specify third rule, and client does
> > > > setxattr(user.virtiofs.*), it will simply be a passthrough?
> > > 
> > > Right; and that's dangerous, because a non-privileged guest
> > > process can set a user. xattr; so a non-priv guest process could
> > > set user.virtiofs.trusted.foo and then it would get read back
> > > and be used as trusted.foo that has an impact on priviliged processes.
> > 
> > Right. We don't want unpriviliged process to be able to setup
> > user.virtiofs.trusted.*. But that's what precisely happen in
> > a nested configuration.
> > 
> > In above example, L2 will set trusted.foo, virtiofsd1 wil convert it
> > to user.virtiofs.trusted.foo and virtiofsd0 will reject it, breaking
> > the nested virtiofs.
> 
> So to allow nesting you need to nest the user.virtiofs. as well, not
> just the trusted. So either you do an all, or if you want to be more
> selective then I think the following would work:
> 
>  1  /prefix/client/trusted./user.virtiofs./
>  2  /prefix/client/user.virtiofs./user.virtiofs./

Ok, so basically instead of blocking user.virtiofs.trusted. from client,
prefix it with "user.virtiofs." one more time. IOW, allow client to
set user.virtiofs.trusted. because it will get back user.virtiofs.trusted.
and not "trusted." which is ok. Now client user space can't fool client
kernel with setting arbitrary user.virtiofs.trusted xattrs.

And if client kernel sends, trusted., it will get back trusted.

Only thing which can happen is that client1 sets user.virtiofs.trusted.
and nested client2 will get it as trusted. So client1 user space can
fool nested client's kernel. But given client1 has launched nested
client2, we should be able to trust some user on client1 and make
sure other users can't see this shared dir and this probably is
not an issue.

>  3  /prefix/server//user.virtiofs./
>  4  /bad/server//trusted./
>  5  /ok/all///
> 
> 1 causes any getattr/setattr to convert 'trusted.'
>                                    to   'user.virtiofs.trusted.'
> 2 causes any getattr/setattr to convert 'user.virtiofs.'
>                                    to   'user.virtiofs.user.virtiofs.'
> 3 causes any listattr to lose a layer of user.virtiofs.
> 4 blocks any trusted. from the layer beneath
> 5 lets anything else through
> 
> (I'm trying to convince myself if we need a
> /bad/server//user.virtiofs.trusted.  to stop the previous level being
> visible).

user.virtiofs.trusted on server will be converted to trusted., right?
Can't block it otherwise L1 client breaks, isn't it?

Vivek



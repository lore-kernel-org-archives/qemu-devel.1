Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BAFC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AC421534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZpdWIg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AC421534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsvU-0005iY-9u
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUsp6-0007LC-Dw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUsow-00025M-FT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603204858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6qUlKOLJ6PcnsgGPUJvvy3f6Y4JF1AoGuO1v3bdNTM=;
 b=eZpdWIg8hKdQfB7lYHWpdfgpmp6PsF1ATb+rpcw74yI5BnoIZE+5IANuCLU/TtiU7eOMyv
 EHHyN6MUlXUEj0H6owgoPxSNdEKgy0LiBML9xkH38Asb/EipFFlWospMtKpfj/1ybaFT7y
 QHxVFVs5I43vyXygAmuxfxwXtu5B1ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548--G83bxSSP3iJgbYVU39QLg-1; Tue, 20 Oct 2020 10:40:52 -0400
X-MC-Unique: -G83bxSSP3iJgbYVU39QLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8D91074656
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 14:40:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-203.rdu2.redhat.com [10.10.115.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7486C5B4A3;
 Tue, 20 Oct 2020 14:40:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 038F7220307; Tue, 20 Oct 2020 10:40:41 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:40:41 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201020144041.GC380917@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-5-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014180209.49299-5-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Wed, Oct 14, 2020 at 07:02:08PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a few examples of xattrmaps to the documentation.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/tools/virtiofsd.rst | 50 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index a3a120da2f..5cb64612ed 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -163,6 +163,56 @@ in which case a 'server' rule will always match on all names from
>  the server.
>  
>  
> +xattr-mapping Examples
> +----------------------
> +
> +1) Prefix all attributes with 'user.virtiofs.'
> +
> +::
> +
> +-o xattrmap=":prefix:all::user.virtiofs.::bad:all:::"
> +

Staring at rule.

":bad:all:::"

and trying to map this to ":type:scope:key:prepend:"

type==bad
scope==all
key==""
prepend==""

> +
> +This uses two rules, using : as the field separator;
> +the first rule prefixes and strips 'user.virtiofs.',
> +the second rule hides any non-prefixed attributes that
> +the host set.

What is non-prefixed xattr in this context. If client sends
"security.selinux", is prefixed or non-prefixed.

Documentation in first patch said.

+- 'bad' - If a client tries to use this name it's
+  denied using EPERM; when the server passes an attribute
+  name matching it's hidden.

I am not sure which xattr name will be blocked if key=="" and prepend==""

> +
> +2) Prefix 'trusted.' attributes, allow others through
> +
> +::
> +
> +   "/prefix/all/trusted./user.virtiofs./
> +    /bad/server//trusted./
> +    /bad/client/user.virtiofs.//
> +    /ok/all///"
> +
> +
> +Here there are four rules, using / as the field
> +separator, and also demonstrating that new lines can
> +be included between rules.
> +The first rule is the prefixing of 'trusted.' and
> +stripping of 'user.virtiofs.'.

So this is bidrectional rule, right. For setxattr(), "trusted."
will be replaced with "user.virtiofs" and for listxattr(),
server will replace user.virtiofs with trusted. ?

> +The second rule hides unprefixed 'trusted.' attributes
> +on the host.

If host has "trusted.*", we are not hiding it and as per first
rule we are converting it to "user.virtiofs.trusted.*", right?
So why this second rule is needed.

> +The third rule stops a guest from explicitly setting
> +the 'user.viritofs.' path directly.
> +Finally, the fourth rule lets all remaining attributes
> +through.

So If I don't specify third rule, and client does
setxattr(user.virtiofs.*), it will simply be a passthrough?

Thanks
Vivek

> +
> +3) Hide 'security.' attributes, and allow everything else
> +
> +::
> +
> +    "/bad/all/security./security./
> +     /ok/all///'
> +
> +The first rule combines what could be separate client and server
> +rules into a single 'all' rule, matching 'security.' in either
> +client arguments or lists returned from the host.  This stops
> +the client seeing any 'security.' attributes on the server and
> +stops it setting any.
> +
>  Examples
>  --------
>  
> -- 
> 2.28.0
> 



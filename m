Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01526C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864EC2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fFLYcrBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864EC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRgG-0001SI-Jj
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGRTN-00035T-Tz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:39:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43124
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kGRTH-0005WM-Gu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599763138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SjpjriiWAJ/m+DYExsRNzzLlr6OeO+GxgXNof7uMVQ=;
 b=fFLYcrBf38xwc+vRJIMFeeXBMyvagqy1t2rZjDVd5I6oIgDt8Po4T6Du39iBK/tH9Uyell
 2SSargcISw7DoO+aQa4qDDmuRUuB+TnBFDVSoVOAf/3Z4OkuQBN9dwWI3FNb2L7feZDezN
 2sMypBouVYhTTTFJPW/oTCyw3JKTn3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-6A_OjgbXNsmTHXbuu_Nytw-1; Thu, 10 Sep 2020 14:38:57 -0400
X-MC-Unique: 6A_OjgbXNsmTHXbuu_Nytw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E9031074645
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 18:38:56 +0000 (UTC)
Received: from work-vm (ovpn-114-164.phx2.redhat.com [10.3.114.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 088027EB7A;
 Thu, 10 Sep 2020 18:38:48 +0000 (UTC)
Date: Thu, 10 Sep 2020 19:38:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Subject: Re: [PATCH v2 3/6] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20200910183846.GO2814@work-vm>
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-4-dgilbert@redhat.com>
 <20200909112012.GD1377607@lpt>
MIME-Version: 1.0
In-Reply-To: <20200909112012.GD1377607@lpt>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Ján Tomko (jtomko@redhat.com) wrote:
> On a Thursday in 2020, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Add an option to define mappings of xattr names so that
> > the client and server filesystems see different views.
> > This can be used to have different SELinux mappings as
> > seen by the guest, to run the virtiofsd with less privileges
> > (e.g. in a case where it can't set trusted/system/security
> > xattrs but you want the guest to be able to), or to isolate
> > multiple users of the same name; e.g. trusted attributes
> > used by stacking overlayfs.
> > 
> > A mapping engine is used wit 3 simple rules; the rules can
> > be combined to allow most useful mapping scenarios.
> > The ruleset is defined by -o xattrmap='rules...'.
> > 
> > This patch doesn't use the rule maps yet.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> > docs/tools/virtiofsd.rst         |  55 ++++++++++++
> > tools/virtiofsd/passthrough_ll.c | 148 +++++++++++++++++++++++++++++++
> > 2 files changed, 203 insertions(+)
> > 
> > diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > index 824e713491..2efa16d3c5 100644
> > --- a/docs/tools/virtiofsd.rst
> > +++ b/docs/tools/virtiofsd.rst
> > @@ -107,6 +107,60 @@ Options
> >   performance.  ``auto`` acts similar to NFS with a 1 second metadata cache
> >   timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
> > 
> > +xattr-mapping
> > +-------------
> > +
> > +By default the name of xattr's used by the client are passed through to the server
> > +file system.  This can be a problem where either those xattr names are used
> > +by something on the server (e.g. selinux client/server confusion) or if the
> > +virtiofsd is running in a container with restricted priviliges where it cannot
> 
> privileges

Fixed.

> > +access some attributes.
> > +
> > +A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
> > +string consists of a series of rules.
> > +
> > +The first matching rule terminates the mapping.
> > +
> > +Each rule consists of a number of fields separated with a separator that is the
> > +first non-white space character in the rule.  This separator must then be used
> > +for the whole rule.
> > +White space may be added before and after each rule.
> > +Using ':' as the separator a rule is of the form:
> > +
> > +``:scope:type:key:prepend:``
> > +
> > +**scope** is:
> > +
> > +- 'client' - match 'key' against a xattr name from the client for
> > +             setxattr/getxattr/removexattr
> > +- 'server' - match 'prepend' against a xattr name from the server
> > +             for listxattr
> > +- 'all' - can be used to match both cases.
> > +
> > +**type** is one of:
> > +
> > +- 'prefix' - If 'key' matches the client then the 'prepend'
> > +  is added before the name is passed to the server.
> > +  For a server case, the prepend is tested and stripped
> > +  if matching.
> > +
> > +- 'ok' - The attribute name is OK and passed through to
> > +  the server unchanged.
> > +
> > +- 'bad' - If a client tries to use this name it's
> > +  denied using EPERM; when the server passes an attribute
> > +  name matching it's hidden.
> > +
> > +**key** is a string tested as a prefix on an attribute name originating
> > +on the client.  It maybe empty in which case a 'client' rule
> > +will always match on client names.
> > +
> > +**prepend** is a string tested as a prefix on an attribute name originiating
> 
> originating

Done.

> > +on the server, and used as a new prefix.  It maybe empty
> 
> may be

OK

> > +in which case a 'server' rule will always match on all names from
> > +the server.
> > +
> > +
> > Examples
> > --------
> > 
> > @@ -123,3 +177,4 @@ Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
> >       -numa node,memdev=mem \
> >       ...
> >   guest# mount -t virtiofs myfs /mnt
> > +
> 
> git complains about trailing whitespace at EOF

Eaten.

Dave

> Jano


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



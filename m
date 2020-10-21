Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2BC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290972065C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhJG1Xjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290972065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHjk-0001fw-3j
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVHgj-0006gU-QO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVHgf-00035p-Ab
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603300446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmMasCdKFT75wPiYpUqSqAkqNIiOJBrEznPdoQEm61o=;
 b=VhJG1XjpC3+3RxlZv2HVxwAhQklOavEKgax8BQ5CqbC4UqfwWsxqCSPVlDghOSL0l62+ZJ
 fAfHjEYXNpEsrzjukkQEm/RUpJgO4Fpaj1J3iBbPDRIkgnsvgbBS8EK5azRyVa4Hry7Sx+
 jQjAPKwvinAZsKgHfik46wgj7jG7L+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-BKaEzC_tNcaFDqLWyTAnyA-1; Wed, 21 Oct 2020 13:14:04 -0400
X-MC-Unique: BKaEzC_tNcaFDqLWyTAnyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4132804B65
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 17:14:03 +0000 (UTC)
Received: from work-vm (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 659245B4B2;
 Wed, 21 Oct 2020 17:13:53 +0000 (UTC)
Date: Wed, 21 Oct 2020 18:13:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 1/5] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20201021171350.GA3720@work-vm>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-2-dgilbert@redhat.com>
 <20201020090755.GA140014@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201020090755.GA140014@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Wed, Oct 14, 2020 at 07:02:05PM +0100, Dr. David Alan Gilbert (git) wrote:
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
> 
> s/wit/with/

Done.

> > +``:type:scope:key:prepend:``
> > +
> > +**type** is one of:
> > +
> > +- 'prefix' - If 'key' matches the client then the 'prepend'
> > +  is added before the name is passed to the server.
> > +  For a server case, the prepend is tested and stripped
> > +  if matching.
> 
> It may be clearer to document rule types like this:
> 
>   - :prefix:client:key:prepend: - Add 'prepend' before the name if it
>                                   starts with 'key'.
> 
>   - :prefix:server::prepend: - Strip 'prepend' if the name starts with
>                                it.
> 
> The client vs server behavior is independent so it's clearer to list
> them as separate cases. In addition, using the full rule syntax shows
> which fields are valid arguments and which ones are ignored.
> 
> The 'all' scope can be documented later as "Combines both the 'client'
> and 'server' scope behavior".

OK, I've reworked this quite a bit, into a simpler part for each of the
type entries with examples of each below.

> > +
> > +- 'ok' - The attribute name is OK and passed through to
> > +  the server unchanged.
> 
> The documentation isn't explicit but I think the default behavior is to
> allow all xattr names?
> 
> What is the purpose of the 'ok' rule? I guess it's to define an
> exception to a later 'prefix' or 'bad' rule. It would be nice to make
> this clear.
> 
> The documentation only mentions :client: behavior, leaving :server:
> undefined. Please indicate whether this rule has an effect in server
> scope.

What I have now is:
+**scope** is:
+
+- 'client' - match 'key' against a xattr name from the client for
+             setxattr/getxattr/removexattr
+- 'server' - match 'prepend' against a xattr name from the server
+             for listxattr
+- 'all' - can be used to make a single rule where both the server
+          and client matches are triggered.
+
+**type** is one of:
+
+- 'prefix' - is designed to prepend and strip a prefix;  the modified
+  attributes then being passed on to the client/server.
+
+- 'ok' - Causes the rule set to be terminated when a match is found
+  while allowing matching xattr's through unchanged.
+  It is intended both as a way of explicitly terminating
+  the list of rules, and to allow some xattr's to skip following rules.
+
+- 'bad' - If a client tries to use a name matching 'key' it's
+  denied using EPERM; when the server passes an attribute
+  name matching 'prepend' it's hidden.  In many ways it's use is very like
+  'ok' as either an explict terminator or for special handling of certain
+  patterns.
+
+**key** is a string tested as a prefix on an attribute name originating
+on the client.  It maybe empty in which case a 'client' rule
+will always match on client names.
+
+**prepend** is a string tested as a prefix on an attribute name originating
+on the server, and used as a new prefix.  It may be empty
+in which case a 'server' rule will always match on all names from
+the server.
+
+e.g.:
+
+  ``:prefix:client:trusted.:user.virtiofs.:``
+
+  will match 'trusted.' attributes in client calls and prefix them before
+  passing them to the server.
+
+  ``:prefix:server::user.virtiofs.:``
+
+  will strip 'user.virtiofs.' from all server replies.
+
+  ``:prefix:all:trusted.:user.virtiofs.:``
+
+  combines the previous two cases into a single rule.
+
+  ``:ok:client:user.::``
+
+  will allow get/set xattr for 'user.' xattr's and ignore
+  following rules.
+
+  ``:ok:server::security.:``
+
+  will pass 'securty.' xattr's in listxattr from the server
+  and ignore following rules.
+
+  ``:ok:all:::``
+
+  will terminate the rule search passing any remaining attributes
+  in both directions.
+
+  ``:bad:server::security.:``
+
+  would hide 'security.' xattr's in listxattr from the server.

so I'm hoping that addresses both the prefix and OK sections
at least.

> > +
> > +- 'bad' - If a client tries to use this name it's
> > +  denied using EPERM; when the server passes an attribute
> > +  name matching it's hidden.
> > +
> > +**scope** is:
> > +
> > +- 'client' - match 'key' against a xattr name from the client for
> > +             setxattr/getxattr/removexattr
> > +- 'server' - match 'prepend' against a xattr name from the server
> > +             for listxattr
> > +- 'all' - can be used to match both cases.
> > +
> > +**key** is a string tested as a prefix on an attribute name originating
> > +on the client.  It maybe empty in which case a 'client' rule
> > +will always match on client names.
> 
> Is there a way to match a full string instead of a prefix (regexp
> ^<pattern>$ instead of ^<pattern>)?

No there isn't; can you think of a way of representing that in the
syntax without making it much more complex?

> > @@ -2010,6 +2020,169 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
> >      fuse_reply_err(req, res == -1 ? errno : 0);
> >  }
> >  
> > +/*
> > + * Exit; process attribute unmodified if matched.
> > + * An empty key applies to all.
> > + */
> > +#define XATTR_MAP_FLAG_END_OK  (1 <<  0)
> > +/*
> > + * The attribute is unwanted;
> > + * EPERM on write hidden on read.
> 
> Making this sentence easier to parse:
> 
> s/write hidden/write, hidden/

Done.

> 
> > + */
> > +#define XATTR_MAP_FLAG_END_BAD (1 <<  1)
> > +/*
> > + * For attr that start with 'key' prepend 'prepend'
> > + * 'key' maybe empty to prepend for all attrs
> 
> s/maybe/may be/

Hmm OK.

> > +    /* Add a terminator to error in cases the user hasn't specified */
> > +    tmp_entry.flags = XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD |
> > +                      XATTR_MAP_FLAG_LAST;
> 
> The comment is slightly misleading. This entry must be added in all
> cases since it terminates the lo->xattr_map_list with the
> XATTR_MAP_FLAG_LAST flag. If we don't add this entry then
> free_xattrmap() will iterate beyond the end of lo->xattr_map_list.
> 
> Another approach is to set XATTR_MAP_FLAG_LAST in add_xattrmap_entry()
> (and clear it on the previous last entry). That way adding the 'bad'
> catch-all truly is optional and just for cases where the user hasn't
> defined a catch-all rule themselves.

I've changed the comment.

> > +    tmp_entry.key = g_strdup("");
> > +    tmp_entry.prepend = g_strdup("");
> > +    lo->xattr_map_list = add_xattrmap_entry(lo->xattr_map_list, &nentries,
> > +                                            &tmp_entry);
> > +
> > +    return res;
> > +}
> > +
> >  static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
> >                          size_t size)
> >  {
> > @@ -2806,6 +2979,8 @@ static void fuse_lo_data_cleanup(struct lo_data *lo)
> >          close(lo->root.fd);
> >      }
> >  
> > +    free(lo->xattrmap);
> > +    free_xattrmap(lo->xattr_map_list);
> >      free(lo->source);
> >  }
> >  
> > @@ -2906,6 +3081,11 @@ int main(int argc, char *argv[])
> >      } else {
> >          lo.source = strdup("/");
> >      }
> > +
> > +    if (lo.xattrmap) {
> > +        lo.xattr_map_list = parse_xattrmap(&lo);
> > +    }
> 
> The function always returns NULL. Has this been tested?

Hmm; I moved that xattr_map_list late and only retested with the
'map' shortcut which still returned it. Fixed.

Dave


-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



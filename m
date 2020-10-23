Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22096C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87804208B6
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bS3lQWem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87804208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyfJ-0002WU-7t
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVyci-00012f-Vn
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVycb-0006bv-96
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603465484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=909Gfe4u8PCGeTj+SdqtzMct+iP9Q+E+HPx6e5qbeNM=;
 b=bS3lQWemiSF8UuHH5vIpqadtuE8Rabx8c/a75J3lW38VsI+TgUpB8cp5+TW3TLuUmVuZvc
 j+jNFKGFvx0UhreiRPzajxpQD2xJ6u938l17OMjogef7CZkGBYUGM2bftrO1XNXFh3wPFr
 6BD2zAaoPqQXRBAdaFBgvbOsz7B9YkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-oyiyJGtsMJOt93BF7xH5Zw-1; Fri, 23 Oct 2020 11:04:43 -0400
X-MC-Unique: oyiyJGtsMJOt93BF7xH5Zw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 241CE804B71
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:04:42 +0000 (UTC)
Received: from work-vm (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE19E1002C03;
 Fri, 23 Oct 2020 15:04:31 +0000 (UTC)
Date: Fri, 23 Oct 2020 16:04:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 2/5] tools/virtiofsd: xattr name mappings: Map client
 xattr names
Message-ID: <20201023150429.GF3038@work-vm>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-3-dgilbert@redhat.com>
 <20201022152853.GC512900@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201022152853.GC512900@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
> On Wed, Oct 14, 2020 at 07:02:06PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Map xattr names originating at the client; from get/set/remove xattr.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 101 ++++++++++++++++++++++++++++++-
> >  1 file changed, 98 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> > index f5a33014f9..57ebe17ed6 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2183,20 +2183,80 @@ static XattrMapEntry *parse_xattrmap(struct lo_data *lo)
> >      return res;
> >  }
> >  
> > -static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
> > +/*
> > + * For use with getxattr/setxattr/removexattr, where the client
> > + * gives us a name and we may need to choose a different one.
> > + * Allocates a buffer for the result placing it in *out_name.
> > + *   If there's no change then *out_name is not set.
> > + * Returns 0 on success
> > + * Can return -EPERM to indicate we block a given attribute
> > + *   (in which case out_name is not allocated)
> > + * Can return -ENOMEM to indicate out_name couldn't be allocated.
> > + */
> > +static int xattr_map_client(const struct lo_data *lo, const char *client_name,
> > +                            char **out_name)
> > +{
> > +    const XattrMapEntry *cur_entry;
> > +
> > +    for (cur_entry = lo->xattr_map_list; ; cur_entry++) {
> > +        if ((cur_entry->flags & XATTR_MAP_FLAG_CLIENT) &&
> > +            (strstart(client_name, cur_entry->key, NULL))) {
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_END_BAD) {
> > +                return -EPERM;
> > +            }
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_END_OK) {
> > +                /* Unmodified name */
> > +                return 0;
> > +            }
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
> 
> I am wondering why do have "END" substring in BAD and OK flags while
> we don't have one in PREFIX flag. IOW, why not simply call these
> flags as XATTR_MAP_FLAG_OK and XATTR_MAP_FLAG_BAD respectively.

OK, the END_'s have gone.

> > +                *out_name = g_try_malloc(strlen(client_name) +
> > +                                         strlen(cur_entry->prepend) + 1);
> 
> Should we check for cur_entry->prepend to be NULL before we try to
> allocate out_name. One could say.
> 
> "prefix:client:trusted.::". In that case we are not supposed to prefix
> anything?

We shouldn't need to do the NULL check; cur_entry->prepend should = ""
in that case, not NULL.

Dave


> > +                if (!*out_name) {
> > +                    return -ENOMEM;
> > +                }
> > +                sprintf(*out_name, "%s%s", cur_entry->prepend, client_name);
> > +                return 0;
> > +            }
> > +        }
> > +    }
> > +
> > +    /* Shouldn't get here - rules should have an END_* */
> > +    abort();
> > +}
> 
> Thanks
> Vivek
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



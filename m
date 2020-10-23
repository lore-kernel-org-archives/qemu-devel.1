Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38C0C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1F220853
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 14:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV8fWGDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1F220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyOQ-00013I-65
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVyNp-0000dX-Cl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVyNl-00047k-U1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603464567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7LPFaYKMzIRya6rSxMVsiA60VXQwf73a7NurhLqpaVY=;
 b=hV8fWGDWiCipkS23X63lcylThgkRekh+u9b1IT0M9hbxttTaRsTFfskI3y4C5BtWi5N3Ut
 hD1YFWMz92n444ZTmACCXPRAmUewOPOChzm1yuhNutvaCmKjN3MVMLeEoVr3JQqA1ZZSbe
 1d5i7CZza0Kv9epqqNxDVs24Et/rknY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-b72zFVTEOK2Cub2ZrvI3ag-1; Fri, 23 Oct 2020 10:49:26 -0400
X-MC-Unique: b72zFVTEOK2Cub2ZrvI3ag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00FB71018F81
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:49:25 +0000 (UTC)
Received: from work-vm (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22AB07D4E1;
 Fri, 23 Oct 2020 14:49:14 +0000 (UTC)
Date: Fri, 23 Oct 2020 15:49:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 3/5] tools/virtiofsd: xattr name mappings: Map server
 xattr names
Message-ID: <20201023144912.GE3038@work-vm>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-4-dgilbert@redhat.com>
 <20201022161656.GD512900@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201022161656.GD512900@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
> On Wed, Oct 14, 2020 at 07:02:07PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Map xattr names coming from the server, i.e. the host filesystem;
> > currently this is only from listxattr.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  tools/virtiofsd/passthrough_ll.c | 89 ++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> > 
> > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> > index 57ebe17ed6..8406a2ae86 100644
> > --- a/tools/virtiofsd/passthrough_ll.c
> > +++ b/tools/virtiofsd/passthrough_ll.c
> > @@ -2220,6 +2220,43 @@ static int xattr_map_client(const struct lo_data *lo, const char *client_name,
> >          }
> >      }
> >  
> > +    /* Shouldn't get here - rules should have an END_* - check parse_xattrmap */
> > +    abort();
> > +}
> > +
> > +/*
> > + * For use with listxattr where the server fs gives us a name and we may need
> > + * to sanitize this for the client.
> > + * Returns a pointer to the result in *out_name
> > + *   This is always the original string or the current string with some prefix
> > + *   removed; no reallocation is done.
> > + * Returns 0 on success
> > + * Can return -ENODATA to indicate the name should be dropped from the list.
> > + */
> > +static int xattr_map_server(const struct lo_data *lo, const char *server_name,
> > +                            const char **out_name)
> > +{
> > +    const XattrMapEntry *cur_entry;
> > +    const char *end;
> > +
> > +    for (cur_entry = lo->xattr_map_list; ; cur_entry++) {
> > +        if ((cur_entry->flags & XATTR_MAP_FLAG_SERVER) &&
> > +            (strstart(server_name, cur_entry->prepend, &end))) {
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_END_BAD) {
> > +                return -ENODATA;
> > +            }
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_END_OK) {
> > +                *out_name = server_name;
> > +                return 0;
> > +            }
> > +            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
> > +                /* Remove prefix */
> > +                *out_name = end;
> > +                return 0;
> > +            }
> > +        }
> > +    }
> > +
> >      /* Shouldn't get here - rules should have an END_* */
> >      abort();
> 
> I am wondering why to put that restriction. If none of the rules match,
> can't we just return as nothing has to be done.

I always add a terminator in the parse as either a bad/ok, and was just
enforcing it - but I've changed it to a return -ENODATA that's probably
safer than the abort().

> >  }
> > @@ -2378,8 +2415,60 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
> >          if (ret == 0) {
> >              goto out;
> >          }
> > +
> > +        if (lo->xattr_map_list) {
> > +            /*
> > +             * Map the names back, some attributes might be dropped,
> > +             * some shortened, but not increased, so we shouldn't
> > +             * run out of room.
> > +             */
> > +            size_t out_index, in_index;
> > +            out_index = 0;
> > +            in_index = 0;
> > +            while (in_index < ret) {
> > +                const char *map_out;
> > +                char *in_ptr = value + in_index;
> > +                /* Length of current attribute name */
> > +                size_t in_len = strlen(value + in_index) + 1;
> > +
> > +                int mapret = xattr_map_server(lo, in_ptr, &map_out);
> > +                if (mapret != -ENODATA && mapret != 0) {
> > +                    /* Shouldn't happen */
> > +                    saverr = -mapret;
> > +                    goto out;
> > +                }
> > +                if (mapret == 0) {
> > +                    /* Either unchanged, or truncated */
> > +                    size_t out_len;
> > +                    if (map_out != in_ptr) {
> > +                        /* +1 copies the NIL */
> > +                        out_len = strlen(map_out) + 1;
> > +                    } else {
> > +                        /* No change */
> > +                        out_len = in_len;
> > +                    }
> > +                    /*
> > +                     * Move result along, may still be needed for an unchanged
> > +                     * entry if a previous entry was changed.
> > +                     */
> > +                    memmove(value + out_index, map_out, out_len);
> > +
> > +                    out_index += out_len;
> > +                }
> > +                in_index += in_len;
> > +            }
> > +            ret = out_index;
> > +            if (ret == 0) {
> > +                goto out;
> > +            }
> > +        }
> >          fuse_reply_buf(req, value, ret);
> >      } else {
> > +        /*
> > +         * xattrmap only ever shortens the result,
> > +         * so we don't need to do anything clever with the
> > +         * allocation length here.
> > +         */
> >          fuse_reply_xattr(req, ret);
> 
> Hmmm.., so this code returns the length of buffer which will fit xattrs.
> So we will will changing the semantics a bit. Instead of returning
> the exact size of buffer needed, we will be returning max size. I hope
> its not a problem. Fixing it will be too expensive I guess.

Right, although the semantics are fuzzy anyway since someone can
come along and add/remove an xattr between the listxattr calls.

Dave

> Thanks
> Vivek
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



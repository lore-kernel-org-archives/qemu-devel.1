Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ED6C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1870208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvBjyx0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1870208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzza-0000vh-SJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVzHj-0004gY-OE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVzHh-000497-Iv
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iZLH4xhdHI2eDUTSbPsMLZ81jjONEc5fNGKytncbceY=;
 b=EvBjyx0zDSP/vWi1eYa0m+tOoNH797O7ohErWJ0kDtgfVJv4OyVZA//ft83ksXAfZqI0RE
 YawJ4uT1KYkU/HHSS45FzZXc2pzpyrriZymhExM2+/cMR2ThFb6sQcb0LIPVg9fJgNRnsJ
 bBTKci+ukQZZnsV/Eifa/WYkoW08zHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-gknayiryPJioFPcgqDzVzw-1; Fri, 23 Oct 2020 11:47:11 -0400
X-MC-Unique: gknayiryPJioFPcgqDzVzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD539186DD40
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:47:10 +0000 (UTC)
Received: from work-vm (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EA9A5C1CF;
 Fri, 23 Oct 2020 15:47:00 +0000 (UTC)
Date: Fri, 23 Oct 2020 16:46:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 1/5] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20201023154658.GG3038@work-vm>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-2-dgilbert@redhat.com>
 <20201022145242.GB512900@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201022145242.GB512900@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> On Wed, Oct 14, 2020 at 07:02:05PM +0100, Dr. David Alan Gilbert (git) wrote:
> 
> [..]
> > +/*
> > + * Exit; process attribute unmodified if matched.
> > + * An empty key applies to all.
> > + */
> > +#define XATTR_MAP_FLAG_END_OK  (1 <<  0)
> > +/*
> > + * The attribute is unwanted;
> > + * EPERM on write hidden on read.
> > + */
> > +#define XATTR_MAP_FLAG_END_BAD (1 <<  1)
> > +/*
> > + * For attr that start with 'key' prepend 'prepend'
> > + * 'key' maybe empty to prepend for all attrs
> > + * key is defined from set/remove point of view.
> > + * Automatically reversed on read
> > + */
> > +#define XATTR_MAP_FLAG_PREFIX  (1 <<  2)
> > +/* Apply rule to get/set/remove */
> > +#define XATTR_MAP_FLAG_CLIENT  (1 << 16)
> > +/* Apply rule to list */
> > +#define XATTR_MAP_FLAG_SERVER  (1 << 17)
> > +/* Apply rule to all */
> > +#define XATTR_MAP_FLAG_ALL   (XATTR_MAP_FLAG_SERVER | XATTR_MAP_FLAG_CLIENT)
> > +
> > +/* Last rule in the XATTR_MAP */
> > +#define XATTR_MAP_FLAG_LAST    (1 << 30)
> 
> I see that you are using bit positions for flags. Not clear why you
> used bit 0,1,2 and then jumped to 16,17 and then to 30. May be you
> are doing some sort of reservation of bits. Will be nice to explain
> that a bit so that next person modifying it can use bits from
> correct pool.

I've added a 'types' and a 'scopes' comment pair to hopefully make it
clear how I split it up.

> > +
> > +static XattrMapEntry *add_xattrmap_entry(XattrMapEntry *orig_map,
> > +                                         size_t *nentries,
> > +                                         const XattrMapEntry *new_entry)
> > +{
> > +    XattrMapEntry *res = g_realloc_n(orig_map, ++*nentries,
> > +                                     sizeof(XattrMapEntry));
> > +    res[*nentries - 1] = *new_entry;
> > +
> > +    return res;
> > +}
> > +
> > +static void free_xattrmap(XattrMapEntry *map)
> > +{
> > +    XattrMapEntry *curr = map;
> > +
> > +    if (!map) {
> > +        return;
> > +    };
> 
> ; after } is not needed.

Gone.

> > +
> > +    do {
> > +        g_free(curr->key);
> > +        g_free(curr->prepend);
> > +    } while (!(curr++->flags & XATTR_MAP_FLAG_LAST));
> > +
> > +    g_free(map);
> > +}
> > +
> > +static XattrMapEntry *parse_xattrmap(struct lo_data *lo)
> > +{
> > +    XattrMapEntry *res = NULL;
> > +    XattrMapEntry tmp_entry;
> > +    size_t nentries = 0;
> 
> If you are calculating number of entries (nentries), may be this could
> be stored in lo_data so that can be later used to free entries or loop
> through rules etc.

Done; and that removes the need for _LAST.

> > +    const char *map = lo->xattrmap;
> > +    const char *tmp;
> > +
> > +    while (*map) {
> > +        char sep;
> > +
> > +        if (isspace(*map)) {
> > +            map++;
> > +            continue;
> > +        }
> > +        /* The separator is the first non-space of the rule */
> > +        sep = *map++;
> > +        if (!sep) {
> > +            break;
> > +        }
> 
> When can sep be NULL? In that case while loop will not even continue.

The end of the rule list.

> > +
> > +        /* Start of 'type' */
> > +        if (strstart(map, "prefix", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_PREFIX;
> > +        } else if (strstart(map, "ok", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_END_OK;
> > +        } else if (strstart(map, "bad", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_END_BAD;
> > +        } else {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Unexpected type;"
> > +                     "Expecting 'prefix', 'ok', or 'bad' in rule %zu\n",
> > +                     __func__, nentries);
> > +            exit(1);
> > +        }
> > +
> > +        if (*map++ != sep) {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Missing '%c' at end of type field of rule %zu\n",
> > +                     __func__, sep, nentries);
> > +            exit(1);
> > +        }
> > +
> > +        /* Start of 'scope' */
> > +        if (strstart(map, "client", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_CLIENT;
> > +        } else if (strstart(map, "server", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_SERVER;
> > +        } else if (strstart(map, "all", &map)) {
> > +            tmp_entry.flags |= XATTR_MAP_FLAG_ALL;
> > +        } else {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Unexpected scope;"
> > +                     " Expecting 'client', 'server', or 'all', in rule %zu\n",
> > +                     __func__, nentries);
> > +            exit(1);
> > +        }
> > +
> > +        if (*map++ != sep) {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Expecting '%c' found '%c'"
> > +                     " after scope in rule %zu\n",
> > +                     __func__, sep, *map, nentries);
> > +            exit(1);
> > +        }
> > +
> > +        /* At start of 'key' field */
> > +        tmp = strchr(map, sep);
> > +        if (!tmp) {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Missing '%c' at end of key field of rule %zu",
> > +                     __func__, sep, nentries);
> > +            exit(1);
> > +        }
> > +        tmp_entry.key = g_strndup(map, tmp - map);
> > +        map = tmp + 1;
> > +
> > +        /* At start of 'prepend' field */
> > +        tmp = strchr(map, sep);
> > +        if (!tmp) {
> > +            fuse_log(FUSE_LOG_ERR,
> > +                     "%s: Missing '%c' at end of prepend field of rule %zu",
> > +                     __func__, sep, nentries);
> > +            exit(1);
> > +        }
> > +        tmp_entry.prepend = g_strndup(map, tmp - map);
> > +        map = tmp + 1;
> > +
> > +        lo->xattr_map_list = add_xattrmap_entry(lo->xattr_map_list, &nentries,
> > +                                                &tmp_entry);
> > +        /* End of rule - go around again for another rule */
> > +    }
> > +
> > +    if (!nentries) {
> > +        fuse_log(FUSE_LOG_ERR, "Empty xattr map\n");
> > +        exit(1);
> > +    }
> > +
> > +    /* Add a terminator to error in cases the user hasn't specified */
> > +    tmp_entry.flags = XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD |
> > +                      XATTR_MAP_FLAG_LAST;
> > +    tmp_entry.key = g_strdup("");
> > +    tmp_entry.prepend = g_strdup("");
> > +    lo->xattr_map_list = add_xattrmap_entry(lo->xattr_map_list, &nentries,
> > +                                            &tmp_entry);
> 
> Not sure why this default rule is needed when user has not specified one.
> 
> This seems to be equivalent of ":bad:all:::". Will this not block all
> the xattrs which have not been caught by previous rules. And user
> probably did not want it. 

I might be able to get rid of that now;  my preference is to tell the
users they should be explicit about what happens.

Dave

> Thanks
> Vivek
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



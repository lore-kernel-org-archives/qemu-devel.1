Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137DBC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9C92224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpzgEK2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9C92224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsH6-0007IQ-6V
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUsGC-0006VI-KQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kUsG7-0005Rr-Dd
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603202700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGQGhEau8ipv2LkgFExUTrnuTrs2HWaULIUrGQ7LV/I=;
 b=NpzgEK2EV8WTOtWdC0ikl/ltlU5hYi/G/up6fyuB4VGh1jFFvYjBWREnR6840xhwtg9Q22
 YoY9jSOQL7bKYTdH3rNgKxykibzOw8O5n6W1BCrJzSjRnDORPHxIQM1REpClm3T4AK60/f
 cBs7SRjhlWOYQNGoKeapNDdsirApuYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-68nzYdXpPzmDkpgF0S9XsA-1; Tue, 20 Oct 2020 10:04:57 -0400
X-MC-Unique: 68nzYdXpPzmDkpgF0S9XsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1AF118BE16B
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 14:04:56 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-203.rdu2.redhat.com [10.10.115.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29A0460C0F;
 Tue, 20 Oct 2020 14:04:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 73883220307; Tue, 20 Oct 2020 10:04:46 -0400 (EDT)
Date: Tue, 20 Oct 2020 10:04:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 1/5] tools/virtiofsd: xattr name mappings: Add option
Message-ID: <20201020140446.GB380917@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-2-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014180209.49299-2-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Wed, Oct 14, 2020 at 07:02:05PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add an option to define mappings of xattr names so that
> the client and server filesystems see different views.
> This can be used to have different SELinux mappings as
> seen by the guest, to run the virtiofsd with less privileges
> (e.g. in a case where it can't set trusted/system/security
> xattrs but you want the guest to be able to), or to isolate
> multiple users of the same name; e.g. trusted attributes
> used by stacking overlayfs.
> 
> A mapping engine is used wit 3 simple rules; the rules can
> be combined to allow most useful mapping scenarios.
> The ruleset is defined by -o xattrmap='rules...'.
> 
> This patch doesn't use the rule maps yet.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/tools/virtiofsd.rst         |  54 ++++++++++
>  tools/virtiofsd/passthrough_ll.c | 180 +++++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+)
> 
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 7ecee49834..a3a120da2f 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -109,6 +109,60 @@ Options
>    timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
>    The default is ``auto``.
>  
> +xattr-mapping
> +-------------
> +
> +By default the name of xattr's used by the client are passed through to the server
> +file system.  This can be a problem where either those xattr names are used
> +by something on the server (e.g. selinux client/server confusion) or if the
> +virtiofsd is running in a container with restricted privileges where it cannot
> +access some attributes.
> +
> +A mapping of xattr names can be made using -o xattrmap=mapping where the ``mapping``
> +string consists of a series of rules.
> +
> +The first matching rule terminates the mapping.
> +
> +Each rule consists of a number of fields separated with a separator that is the
> +first non-white space character in the rule.  This separator must then be used
> +for the whole rule.

Where is it useful to have a separator other than ":".


> +White space may be added before and after each rule.
> +Using ':' as the separator a rule is of the form:
> +
> +``:type:scope:key:prepend:``
> +
> +**type** is one of:

I am not sure I understand the syntax explanation. So I will ask
some basic questions.

> +
> +- 'prefix' - If 'key' matches the client then the 'prepend'

What do you mean by "If key matches the client"?

> +  is added before the name is passed to the server.

Its basically the sever which is processing these rules. I guess
you have written this sentence from the perspective of "rule engine"
and it passes the name to file server (despite the fact that rule
engine itself is part of file server).

> +  For a server case, the prepend is tested and stripped
> +  if matching.

Is this about file server removing the "prepend" from xattr
name before it is sent back to client?

> +
> +- 'ok' - The attribute name is OK and passed through to
> +  the server unchanged.
> +
> +- 'bad' - If a client tries to use this name it's
> +  denied using EPERM; when the server passes an attribute
> +  name matching it's hidden.
> +
> +**scope** is:
> +
> +- 'client' - match 'key' against a xattr name from the client for
> +             setxattr/getxattr/removexattr
> +- 'server' - match 'prepend' against a xattr name from the server
> +             for listxattr
> +- 'all' - can be used to match both cases.

So we need this only if we don't want to do
xattr mapping bidirectionally. IOW, server will not allow
getxattr "user.foo" but will allow listing "user.foo"?

/me is wondering what's the use case of this.

> +
> +**key** is a string tested as a prefix on an attribute name originating
> +on the client.  It maybe empty in which case a 'client' rule
> +will always match on client names.
> +
> +**prepend** is a string tested as a prefix on an attribute name originating
> +on the server, and used as a new prefix.

What does it mean that "prepend" is tested as a prefix" and "used as a
new prefix". It is used as a new prefix for client rule, right? Atleast
documentation does not make it clear.

> It may be empty
> +in which case a 'server' rule will always match on all names from
> +the server.
> +
> +
>  Examples
>  --------

Can we give some examples in this patch so that it is easy to understand
what these rules can allow.

Thanks
Vivek

>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index ff53df4451..f5a33014f9 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -64,6 +64,7 @@
>  #include <syslog.h>
>  #include <unistd.h>
>  
> +#include "qemu/cutils.h"
>  #include "passthrough_helpers.h"
>  #include "passthrough_seccomp.h"
>  
> @@ -137,6 +138,12 @@ enum {
>      CACHE_ALWAYS,
>  };
>  
> +typedef struct xattr_map_entry {
> +    char *key;
> +    char *prepend;
> +    unsigned int flags;
> +} XattrMapEntry;
> +
>  struct lo_data {
>      pthread_mutex_t mutex;
>      int debug;
> @@ -144,6 +151,7 @@ struct lo_data {
>      int flock;
>      int posix_lock;
>      int xattr;
> +    char *xattrmap;
>      char *source;
>      char *modcaps;
>      double timeout;
> @@ -157,6 +165,7 @@ struct lo_data {
>      struct lo_map ino_map; /* protected by lo->mutex */
>      struct lo_map dirp_map; /* protected by lo->mutex */
>      struct lo_map fd_map; /* protected by lo->mutex */
> +    XattrMapEntry *xattr_map_list;
>  
>      /* An O_PATH file descriptor to /proc/self/fd/ */
>      int proc_self_fd;
> @@ -172,6 +181,7 @@ static const struct fuse_opt lo_opts[] = {
>      { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
>      { "xattr", offsetof(struct lo_data, xattr), 1 },
>      { "no_xattr", offsetof(struct lo_data, xattr), 0 },
> +    { "xattrmap=%s", offsetof(struct lo_data, xattrmap), 0 },
>      { "modcaps=%s", offsetof(struct lo_data, modcaps), 0 },
>      { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
>      { "timeout=", offsetof(struct lo_data, timeout_set), 1 },
> @@ -2010,6 +2020,169 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
>      fuse_reply_err(req, res == -1 ? errno : 0);
>  }
>  
> +/*
> + * Exit; process attribute unmodified if matched.
> + * An empty key applies to all.
> + */
> +#define XATTR_MAP_FLAG_END_OK  (1 <<  0)
> +/*
> + * The attribute is unwanted;
> + * EPERM on write hidden on read.
> + */
> +#define XATTR_MAP_FLAG_END_BAD (1 <<  1)
> +/*
> + * For attr that start with 'key' prepend 'prepend'
> + * 'key' maybe empty to prepend for all attrs
> + * key is defined from set/remove point of view.
> + * Automatically reversed on read
> + */
> +#define XATTR_MAP_FLAG_PREFIX  (1 <<  2)
> +/* Apply rule to get/set/remove */
> +#define XATTR_MAP_FLAG_CLIENT  (1 << 16)
> +/* Apply rule to list */
> +#define XATTR_MAP_FLAG_SERVER  (1 << 17)
> +/* Apply rule to all */
> +#define XATTR_MAP_FLAG_ALL   (XATTR_MAP_FLAG_SERVER | XATTR_MAP_FLAG_CLIENT)
> +
> +/* Last rule in the XATTR_MAP */
> +#define XATTR_MAP_FLAG_LAST    (1 << 30)
> +
> +static XattrMapEntry *add_xattrmap_entry(XattrMapEntry *orig_map,
> +                                         size_t *nentries,
> +                                         const XattrMapEntry *new_entry)
> +{
> +    XattrMapEntry *res = g_realloc_n(orig_map, ++*nentries,
> +                                     sizeof(XattrMapEntry));
> +    res[*nentries - 1] = *new_entry;
> +
> +    return res;
> +}
> +
> +static void free_xattrmap(XattrMapEntry *map)
> +{
> +    XattrMapEntry *curr = map;
> +
> +    if (!map) {
> +        return;
> +    };
> +
> +    do {
> +        g_free(curr->key);
> +        g_free(curr->prepend);
> +    } while (!(curr++->flags & XATTR_MAP_FLAG_LAST));
> +
> +    g_free(map);
> +}
> +
> +static XattrMapEntry *parse_xattrmap(struct lo_data *lo)
> +{
> +    XattrMapEntry *res = NULL;
> +    XattrMapEntry tmp_entry;
> +    size_t nentries = 0;
> +    const char *map = lo->xattrmap;
> +    const char *tmp;
> +
> +    while (*map) {
> +        char sep;
> +
> +        if (isspace(*map)) {
> +            map++;
> +            continue;
> +        }
> +        /* The separator is the first non-space of the rule */
> +        sep = *map++;
> +        if (!sep) {
> +            break;
> +        }
> +
> +        /* Start of 'type' */
> +        if (strstart(map, "prefix", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_PREFIX;
> +        } else if (strstart(map, "ok", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_END_OK;
> +        } else if (strstart(map, "bad", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_END_BAD;
> +        } else {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Unexpected type;"
> +                     "Expecting 'prefix', 'ok', or 'bad' in rule %zu\n",
> +                     __func__, nentries);
> +            exit(1);
> +        }
> +
> +        if (*map++ != sep) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Missing '%c' at end of type field of rule %zu\n",
> +                     __func__, sep, nentries);
> +            exit(1);
> +        }
> +
> +        /* Start of 'scope' */
> +        if (strstart(map, "client", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_CLIENT;
> +        } else if (strstart(map, "server", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_SERVER;
> +        } else if (strstart(map, "all", &map)) {
> +            tmp_entry.flags |= XATTR_MAP_FLAG_ALL;
> +        } else {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Unexpected scope;"
> +                     " Expecting 'client', 'server', or 'all', in rule %zu\n",
> +                     __func__, nentries);
> +            exit(1);
> +        }
> +
> +        if (*map++ != sep) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Expecting '%c' found '%c'"
> +                     " after scope in rule %zu\n",
> +                     __func__, sep, *map, nentries);
> +            exit(1);
> +        }
> +
> +        /* At start of 'key' field */
> +        tmp = strchr(map, sep);
> +        if (!tmp) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Missing '%c' at end of key field of rule %zu",
> +                     __func__, sep, nentries);
> +            exit(1);
> +        }
> +        tmp_entry.key = g_strndup(map, tmp - map);
> +        map = tmp + 1;
> +
> +        /* At start of 'prepend' field */
> +        tmp = strchr(map, sep);
> +        if (!tmp) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Missing '%c' at end of prepend field of rule %zu",
> +                     __func__, sep, nentries);
> +            exit(1);
> +        }
> +        tmp_entry.prepend = g_strndup(map, tmp - map);
> +        map = tmp + 1;
> +
> +        lo->xattr_map_list = add_xattrmap_entry(lo->xattr_map_list, &nentries,
> +                                                &tmp_entry);
> +        /* End of rule - go around again for another rule */
> +    }
> +
> +    if (!nentries) {
> +        fuse_log(FUSE_LOG_ERR, "Empty xattr map\n");
> +        exit(1);
> +    }
> +
> +    /* Add a terminator to error in cases the user hasn't specified */
> +    tmp_entry.flags = XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD |
> +                      XATTR_MAP_FLAG_LAST;
> +    tmp_entry.key = g_strdup("");
> +    tmp_entry.prepend = g_strdup("");
> +    lo->xattr_map_list = add_xattrmap_entry(lo->xattr_map_list, &nentries,
> +                                            &tmp_entry);
> +
> +    return res;
> +}
> +
>  static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>                          size_t size)
>  {
> @@ -2806,6 +2979,8 @@ static void fuse_lo_data_cleanup(struct lo_data *lo)
>          close(lo->root.fd);
>      }
>  
> +    free(lo->xattrmap);
> +    free_xattrmap(lo->xattr_map_list);
>      free(lo->source);
>  }
>  
> @@ -2906,6 +3081,11 @@ int main(int argc, char *argv[])
>      } else {
>          lo.source = strdup("/");
>      }
> +
> +    if (lo.xattrmap) {
> +        lo.xattr_map_list = parse_xattrmap(&lo);
> +    }
> +
>      if (!lo.timeout_set) {
>          switch (lo.cache) {
>          case CACHE_NONE:
> -- 
> 2.28.0
> 



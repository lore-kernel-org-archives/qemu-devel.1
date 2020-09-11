Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA8C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10ACF2076C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4icIDAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ACF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGqP5-0006oX-Vm
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 17:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kGqOB-0006CL-P6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:15:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kGqO8-00078w-3G
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599858919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQDdNx/mRQAFIwCPY1PGISzufxnmynYaOVinBNhvapU=;
 b=Q4icIDAJCOvxVv91PNB841ejfnzrUhZUsRcuMKZOtDccQz/bBpFAoJe1Krdsjlda0qcr/P
 p5iJcr8Pfsj79HKtHUUmudorvHz7SWDkbNbWBbBbL+z5mTG9UADPAHVfwC+zXJA2mnx2CM
 WVqkYlYm5SY0/jl8zcuLBC5uA8Lfse4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-ed191vCCOheHf8_Zow0HLw-1; Fri, 11 Sep 2020 17:14:07 -0400
X-MC-Unique: ed191vCCOheHf8_Zow0HLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F6D805EE3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 21:14:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-89.rdu2.redhat.com [10.10.114.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2887127CC1;
 Fri, 11 Sep 2020 21:13:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 19F6E220C56; Fri, 11 Sep 2020 17:13:58 -0400 (EDT)
Date: Fri, 11 Sep 2020 17:13:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v2 3/6] tools/virtiofsd: xattr name mappings:
 Add option
Message-ID: <20200911211358.GA191320@redhat.com>
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-4-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827153657.111098-4-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 04:36:54PM +0100, Dr. David Alan Gilbert (git) wrote:
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
>  docs/tools/virtiofsd.rst         |  55 ++++++++++++
>  tools/virtiofsd/passthrough_ll.c | 148 +++++++++++++++++++++++++++++++
>  2 files changed, 203 insertions(+)
> 
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 824e713491..2efa16d3c5 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -107,6 +107,60 @@ Options
>    performance.  ``auto`` acts similar to NFS with a 1 second metadata cache
>    timeout.  ``always`` sets a long cache lifetime at the expense of coherency.
>  
> +xattr-mapping
> +-------------
> +
> +By default the name of xattr's used by the client are passed through to the server
> +file system.  This can be a problem where either those xattr names are used
> +by something on the server (e.g. selinux client/server confusion) or if the
> +virtiofsd is running in a container with restricted priviliges where it cannot
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
> +White space may be added before and after each rule.
> +Using ':' as the separator a rule is of the form:
> +
> +``:scope:type:key:prepend:``

Hi David,

This seems very genric and which makes it harder to understand and
harder to write rules. I am wondering do we really need this degree
of flexibility. Is it worth, dropping some of the requirements
and simplify the syntax.

- I am wonderig why do we need to allow choice of separator.

- Wondering why do we need to allow separate rules for client/server.
  Once we start remapping something, is it not good enough that
  mapping be bidirectonal.

- Not sure why separate notion of "bad". To me once we decide to
  remap something, should automatically block unprefixed version.

IOW, what functionality we will lose if we just say

-o remap_xattr="trusted.".

This implies following.

A. If client is sending any xattr prefixed with "trusted.", prefix it
with "user.virtiofs".

B. Server filters out anything starting with "trusted."

C. If server sees "user.virtiofs.trusted." it strips "user.virtiofs".


For remapping security.selinux, user could specify.

-o remap_xattr="security.selinux."

For nested configuration. virtiofsd at L1 will specify.

-o remap_xattr="security.selinux.".

And virtiofsd at L0 can specify.

-o remap_xattr="user.virtiofs.security.selinux."

I doubt we need to care about being able to remap xattrs of
other filesystems like virtio-9p.

I also have some questions about how this will be used.

Overlay
-------
- So for non nested guests, we can have two instances of overlay. Lets
  call these ovl0 and ovl1. (ovl0 being on host, and ovl1 being inside
  guest). Fs hierarcy might look as follows.

  ext4-->ovl0-->virtiofsd0-->ovl1

  This case does not work by default even if virtiofsd has CAP_SYS_ADMIN
  by default as overlay does not allow nesting. So when ovl1 tries to
  set trusted.overlay, ovl0 will deny it.

  We could simple pass extra directory from host which does not go through
  overlay on host and use that as upper inside guest.

  ext4-->ovl0-->virtiofsd0-->ovl1
  ext4-->ovl0/upper-->virtiofsd0-->ovl1
  (/upper used as upper directory of ovl1)

  I guess remapping "trusted.overlay" will allow us not to have a separate
  ovl0/upper. And following itself will work. Have you tested it? Does
  this work. Basically we are creating nested overlay configuration with
  virtiofs in between. Is "trusted.overlay" only conflict. I wonder
  there might be others. Just that "trusted.overlay" is first failure
  we noticed.

Nested Overlay
--------------
- For now I will assume that we are using separate upper dir.

  ext4-->ovl0-->virtiofsd0-->ovl1-->virtiofsd1-->ovl2
  ext4-->ovl0/upper1-->virtiofsd0-->ovl1(uses upper1 as upperdir)
  ext4-->ovl0/upper2-->virtiofsd0-->ovl1-->virtiofsd1-->ovl2 (users upper2
  as upper dir)

  Basically create two directories upper1 and upper2 on regular filesystem
  say ext4/xfs. Bind mount them on ovl0/upper1 and ovl0/upper2 respectively.
  And now ovl1 uses ovl0/upper1 as upperdir and ovl2 uses ovl0/upper2 as
  upperdir. This should make sure ovl0, ovl1 and ovl2 are not nested from
  sharing upper perspective.

  Now virtiofsd1 will run with '-o remap_xattr="trusted.overlay"' and
  virtiofsd0 will run with '-o remap_xattr="user.virtiofs.trusted.overlay"'

Just trying to wrap my head around how our use cases will use this new
remapping xattr thing.

Thanks
Vivek



> +
> +**scope** is:
> +
> +- 'client' - match 'key' against a xattr name from the client for
> +             setxattr/getxattr/removexattr
> +- 'server' - match 'prepend' against a xattr name from the server
> +             for listxattr
> +- 'all' - can be used to match both cases.
> +
> +**type** is one of:
> +
> +- 'prefix' - If 'key' matches the client then the 'prepend'
> +  is added before the name is passed to the server.
> +  For a server case, the prepend is tested and stripped
> +  if matching.
> +
> +- 'ok' - The attribute name is OK and passed through to
> +  the server unchanged.
> +
> +- 'bad' - If a client tries to use this name it's
> +  denied using EPERM; when the server passes an attribute
> +  name matching it's hidden.
> +
> +**key** is a string tested as a prefix on an attribute name originating
> +on the client.  It maybe empty in which case a 'client' rule
> +will always match on client names.
> +
> +**prepend** is a string tested as a prefix on an attribute name originiating
> +on the server, and used as a new prefix.  It maybe empty
> +in which case a 'server' rule will always match on all names from
> +the server.
> +
> +
>  Examples
>  --------
>  
> @@ -123,3 +177,4 @@ Export ``/var/lib/fs/vm001/`` on vhost-user UNIX domain socket
>        -numa node,memdev=mem \
>        ...
>    guest# mount -t virtiofs myfs /mnt
> +
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 083d17a960..00e96a10cd 100644
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
> @@ -144,6 +145,7 @@ struct lo_data {
>      int flock;
>      int posix_lock;
>      int xattr;
> +    char *xattrmap;
>      char *source;
>      char *modcaps;
>      double timeout;
> @@ -171,6 +173,7 @@ static const struct fuse_opt lo_opts[] = {
>      { "no_posix_lock", offsetof(struct lo_data, posix_lock), 0 },
>      { "xattr", offsetof(struct lo_data, xattr), 1 },
>      { "no_xattr", offsetof(struct lo_data, xattr), 0 },
> +    { "xattrmap=%s", offsetof(struct lo_data, xattrmap), 0 },
>      { "modcaps=%s", offsetof(struct lo_data, modcaps), 0 },
>      { "timeout=%lf", offsetof(struct lo_data, timeout), 0 },
>      { "timeout=", offsetof(struct lo_data, timeout_set), 1 },
> @@ -2003,6 +2006,146 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi,
>      fuse_reply_err(req, res == -1 ? errno : 0);
>  }
>  
> +typedef struct xattr_map_entry {
> +    const char *key;
> +    const char *prepend;
> +    unsigned int flags;
> +} XattrMapEntry;
> +
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
> +static XattrMapEntry *xattr_map_list;
> +
> +static XattrMapEntry *parse_xattrmap(const char *map)
> +{
> +    XattrMapEntry *res = NULL;
> +    size_t nentries = 0;
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
> +        /* Allocate some space for the rule */
> +        res = g_realloc_n(res, ++nentries, sizeof(XattrMapEntry));
> +        res[nentries - 1].flags = 0;
> +
> +        if (strstart(map, "client", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_CLIENT;
> +        } else if (strstart(map, "server", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_SERVER;
> +        } else if (strstart(map, "all", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_ALL;
> +        } else {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Unexpected scope;"
> +                     " Expecting 'client', 'server', or 'all', in rule %zu\n",
> +                     __func__, nentries);
> +            exit(1);
> +        }
> +
> +
> +        if (*map != sep) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Expecting '%c' found '%c'"
> +                     " after scope in rule %zu\n",
> +                     __func__, sep, *map, nentries + 1);
> +            exit(1);
> +        }
> +        /* Skip the separator, now at the start of the 'type' */
> +        map++;
> +
> +        /* Start of 'type' */
> +        if (strstart(map, "prefix", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_PREFIX;
> +        } else if (strstart(map, "ok", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_END_OK;
> +        } else if (strstart(map, "bad", &map)) {
> +            res[nentries - 1].flags |= XATTR_MAP_FLAG_END_BAD;
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
> +        /* At start of 'key' field */
> +        tmp = strchr(map, sep);
> +        if (!tmp) {
> +            fuse_log(FUSE_LOG_ERR,
> +                     "%s: Missing '%c' at end of key field of rule %zu",
> +                     __func__, sep, nentries);
> +            exit(1);
> +        }
> +        res[nentries - 1].key = g_strndup(map, tmp - map);
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
> +        res[nentries - 1].prepend = g_strndup(map, tmp - map);
> +        map = tmp + 1;
> +        /* End of rule - go around again for another rule */
> +    }
> +
> +    if (!nentries) {
> +        fuse_log(FUSE_LOG_ERR, "Empty xattr map\n");
> +        exit(1);
> +    }
> +
> +    /* Add a terminator to error in cases the user hasn't specified */
> +    res = g_realloc_n(res, ++nentries, sizeof(XattrMapEntry));
> +    res[nentries - 1].flags = XATTR_MAP_FLAG_ALL | XATTR_MAP_FLAG_END_BAD;
> +    res[nentries - 1].key = g_strdup("");
> +    res[nentries - 1].prepend = g_strdup("");
> +
> +    return res;
> +}
> +
>  static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>                          size_t size)
>  {
> @@ -2909,6 +3052,11 @@ int main(int argc, char *argv[])
>      } else {
>          lo.source = strdup("/");
>      }
> +
> +    if (lo.xattrmap) {
> +        xattr_map_list = parse_xattrmap(lo.xattrmap);
> +    }
> +
>      if (!lo.timeout_set) {
>          switch (lo.cache) {
>          case CACHE_NONE:
> -- 
> 2.26.2
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs



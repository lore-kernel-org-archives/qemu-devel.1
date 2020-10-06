Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B09C46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7716B206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="el/eeF1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7716B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpWH-0007CD-Br
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1kPpRV-00015H-Dt
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1kPpRQ-000342-37
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602000231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BaUe4isU0tR/NmluVZPPbsP7hFB454Cm7HO/r2z15k4=;
 b=el/eeF1+ch5rnWBR5Q1CnEHldnyuGax99Jtrnv/gz+QNCH41QuJ/Kpc43BpAINYg8qqVtp
 G0PV4eXnGKQWN757hX/HHhbpUPt/N/3qt9ftTNUZZ6VpEPTShV2LYqTWyKEG/5etck8NbE
 LNtmYnmBga/To0BCRwWHLSL8vXRDNRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-cdUy2kTJMbqsboPM2tzrhw-1; Tue, 06 Oct 2020 12:03:49 -0400
X-MC-Unique: cdUy2kTJMbqsboPM2tzrhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12B4A18C5207
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2020 16:03:49 +0000 (UTC)
Received: from titinator (ovpn-115-5.ams2.redhat.com [10.36.115.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEEA360E1C;
 Tue,  6 Oct 2020 16:03:41 +0000 (UTC)
References: <20200827153657.111098-1-dgilbert@redhat.com>
 <20200827153657.111098-6-dgilbert@redhat.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 5/6] tools/virtiofsd: xattr name mappings: Map server
 xattr names
In-reply-to: <20200827153657.111098-6-dgilbert@redhat.com>
Date: Tue, 06 Oct 2020 18:03:38 +0200
Message-ID: <lyft6rl4th.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: virtio-fs@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-08-27 at 17:36 CEST, Dr. David Alan Gilbert (git) wrote...
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Map xattr names coming from the server, i.e. the host filesystem;
> currently this is only from listxattr.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 88 ++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 9b9c8f3ab1..7cd99186f7 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2188,6 +2188,42 @@ static int xattr_map_client(const char *client_name, char **out_name)
>      abort();
>  }
>
> +/*
> + * For use with listxattr where the server fs gives us a name and we may need
> + * to sanitize this for the client.
> + * Returns a pointer to the result in *out_name
> + *   This is always the original string or the current string with some prefix
> + *   removed; no reallocation is done.
> + * Returns 0 on success
> + * Can return -ENODATA to indicate the name should be dropped from the list.
> + */
> +static int xattr_map_server(const char *server_name, const char **out_name)

> +{
> +    const XattrMapEntry *cur_entry;
> +    for (cur_entry = xattr_map_list; ; cur_entry++) {
> +        if ((cur_entry->flags & XATTR_MAP_FLAG_SERVER) &&
> +            (!strncmp(cur_entry->prepend,
> +                      server_name,
> +                      strlen(cur_entry->prepend)))) {

Might be slightly clearer (and possibly faster) as

    strstart(cur_entry->prepend, server_name, &end)

> +            if (cur_entry->flags & XATTR_MAP_FLAG_END_BAD) {
> +                return -ENODATA;
> +            }
> +            if (cur_entry->flags & XATTR_MAP_FLAG_END_OK) {
> +                *out_name = server_name;
> +                return 0;
> +            }
> +            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
> +                /* Remove prefix */
> +                *out_name = server_name + strlen(cur_entry->prepend);

With the above, that would be

    *out_name = end;


> +                return 0;
> +            }
> +        }
> +    }
> +
> +    /* Shouldn't get here - rules should have an END_* */

You probably want to point the finger back to parse_xattrmap() in the comment?

> +    abort();

> +}
> +
>  static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *in_name,
>                          size_t size)
>  {
> @@ -2342,8 +2378,60 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
>          if (ret == 0) {
>              goto out;
>          }
> +
> +        if (lo->xattrmap) {

If you put the "XattrMapEntry" pointer in lo, then you would probably test that.

> +            /*
> +             * Map the names back, some attributes might be dropped,
> +             * some shortened, but not increased, so we shouldn't
> +             * run out of room.
> +             */
> +            size_t out_index, in_index;
> +            out_index = 0;
> +            in_index = 0;
> +            while (in_index < ret) {
> +                const char *map_out;
> +                char *in_ptr = value + in_index;
> +                /* Length of current attribute name */
> +                size_t in_len = strlen(value + in_index) + 1;
> +
> +                int mapret = xattr_map_server(in_ptr, &map_out);
> +                if (mapret != -ENODATA && mapret != 0) {
> +                    /* Shouldn't happen */
> +                    saverr = -mapret;
> +                    goto out;
> +                }
> +                if (mapret == 0) {
> +                    /* Either unchanged, or truncated */
> +                    size_t out_len;
> +                    if (map_out != in_ptr) {
> +                        /* +1 copies the NIL */
> +                        out_len = strlen(map_out) + 1;
> +                    } else {
> +                        /* No change */
> +                        out_len = in_len;
> +                    }
> +                    /*
> +                     * Move result along, may still be needed for an unchanged
> +                     * entry if a previous entry was changed.
> +                     */
> +                    memmove(value + out_index, map_out, out_len);
> +
> +                    out_index += out_len;
> +                }
> +                in_index += in_len;
> +            }
> +            ret = out_index;
> +            if (ret == 0) {
> +                goto out;
> +            }
> +        }
>          fuse_reply_buf(req, value, ret);
>      } else {
> +        /*
> +         * xattrmap only ever shortens the result,
> +         * so we don't need to do anything clever with the
> +         * allocation length here.
> +         */

I don't understand the comment above. We are in the !lo->xattrmap) case, no?

>          fuse_reply_xattr(req, ret);
>      }
>  out_free:


--
Cheers,
Christophe de Dinechin (IRC c3d)



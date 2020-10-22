Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B24C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60731208B6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1H/ar8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60731208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdIs-0005P4-5W
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kVdHb-00046Q-Hu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kVdH5-0003Ma-Hv
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603383429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C28IWTfVw2aaM27ikaGOa7K0/l4uMkscBKhe/GvbSTo=;
 b=I1H/ar8lWcBgUKz2XIaFsZ07vzzEsELohcODYyhInKnCrEidI6MuIF+iHGV+urLSAr1EXQ
 l/uIVpQGfzoQI47/0P4a0r/zSzhGaf/3f189WYTaZPS2O6MP498xb5sCnfTZADHQ0q1Bdf
 ICFRPbkim289oqd+NpIdI382LCtXk2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-_OCeAiMBOcCqR5_RFe9x9Q-1; Thu, 22 Oct 2020 12:17:07 -0400
X-MC-Unique: _OCeAiMBOcCqR5_RFe9x9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0D85F9C9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 16:17:06 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-67.rdu2.redhat.com [10.10.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A94265D9F1;
 Thu, 22 Oct 2020 16:16:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 20F5B222F9C; Thu, 22 Oct 2020 12:16:56 -0400 (EDT)
Date: Thu, 22 Oct 2020 12:16:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 3/5] tools/virtiofsd: xattr name mappings: Map server
 xattr names
Message-ID: <20201022161656.GD512900@redhat.com>
References: <20201014180209.49299-1-dgilbert@redhat.com>
 <20201014180209.49299-4-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014180209.49299-4-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
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

On Wed, Oct 14, 2020 at 07:02:07PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Map xattr names coming from the server, i.e. the host filesystem;
> currently this is only from listxattr.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 89 ++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 57ebe17ed6..8406a2ae86 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2220,6 +2220,43 @@ static int xattr_map_client(const struct lo_data *lo, const char *client_name,
>          }
>      }
>  
> +    /* Shouldn't get here - rules should have an END_* - check parse_xattrmap */
> +    abort();
> +}
> +
> +/*
> + * For use with listxattr where the server fs gives us a name and we may need
> + * to sanitize this for the client.
> + * Returns a pointer to the result in *out_name
> + *   This is always the original string or the current string with some prefix
> + *   removed; no reallocation is done.
> + * Returns 0 on success
> + * Can return -ENODATA to indicate the name should be dropped from the list.
> + */
> +static int xattr_map_server(const struct lo_data *lo, const char *server_name,
> +                            const char **out_name)
> +{
> +    const XattrMapEntry *cur_entry;
> +    const char *end;
> +
> +    for (cur_entry = lo->xattr_map_list; ; cur_entry++) {
> +        if ((cur_entry->flags & XATTR_MAP_FLAG_SERVER) &&
> +            (strstart(server_name, cur_entry->prepend, &end))) {
> +            if (cur_entry->flags & XATTR_MAP_FLAG_END_BAD) {
> +                return -ENODATA;
> +            }
> +            if (cur_entry->flags & XATTR_MAP_FLAG_END_OK) {
> +                *out_name = server_name;
> +                return 0;
> +            }
> +            if (cur_entry->flags & XATTR_MAP_FLAG_PREFIX) {
> +                /* Remove prefix */
> +                *out_name = end;
> +                return 0;
> +            }
> +        }
> +    }
> +
>      /* Shouldn't get here - rules should have an END_* */
>      abort();

I am wondering why to put that restriction. If none of the rules match,
can't we just return as nothing has to be done.

>  }
> @@ -2378,8 +2415,60 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
>          if (ret == 0) {
>              goto out;
>          }
> +
> +        if (lo->xattr_map_list) {
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
> +                int mapret = xattr_map_server(lo, in_ptr, &map_out);
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
>          fuse_reply_xattr(req, ret);

Hmmm.., so this code returns the length of buffer which will fit xattrs.
So we will will changing the semantics a bit. Instead of returning
the exact size of buffer needed, we will be returning max size. I hope
its not a problem. Fixing it will be too expensive I guess.

Thanks
Vivek



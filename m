Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5FC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3EB2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3EB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwrp-0001Zm-F1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irwrB-0000lp-VF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1irwr9-0001Fe-Nx
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:34:08 -0500
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:45784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1irwr9-00018i-1k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:34:07 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym04.jp.fujitsu.com with smtp
 id 7307_5d0d_5707555f_938a_420a_b69f_0a54a77a20c8;
 Thu, 16 Jan 2020 13:33:59 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 24938AC00BC
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 13:33:58 +0900 (JST)
Received: from g01jpexchyt35.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id 1CF9C46E714;
 Thu, 16 Jan 2020 13:33:57 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt35.g01.fujitsu.local (10.128.193.50) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 13:33:57 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <dgilbert@redhat.com>
Subject: Re: [PATCH 053/104] virtiofsd: Drop CAP_FSETID if client asked for it
Date: Thu, 16 Jan 2020 13:41:48 +0900
Message-ID: <20200116044148.3346-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20191212163904.159893-54-dgilbert@redhat.com>
References: <20191212163904.159893-54-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.43
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
Cc: misono.tomohiro@jp.fujitsu.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Vivek Goyal <vgoyal@redhat.com>
> 
> If client requested killing setuid/setgid bits on file being written, drop
> CAP_FSETID capability so that setuid/setgid bits are cleared upon write
> automatically.
> 
> pjdfstest chown/12.t needs this.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>   dgilbert: reworked for libcap-ng

Looks good to me.
 Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

> ---
>  tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 6a09b28608..ab318a6f36 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -201,6 +201,91 @@ static int load_capng(void)
>      return 0;
>  }
>  
> +/*
> + * Helpers for dropping and regaining effective capabilities. Returns 0
> + * on success, error otherwise
> + */
> +static int drop_effective_cap(const char *cap_name, bool *cap_dropped)
> +{
> +    int cap, ret;
> +
> +    cap = capng_name_to_capability(cap_name);
> +    if (cap < 0) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
> +                 cap_name, strerror(errno));
> +        goto out;
> +    }
> +
> +    if (load_capng()) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
> +        goto out;
> +    }
> +
> +    /* We dont have this capability in effective set already. */
> +    if (!capng_have_capability(CAPNG_EFFECTIVE, cap)) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    if (capng_update(CAPNG_DROP, CAPNG_EFFECTIVE, cap)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_update(DROP,) failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_apply(CAPNG_SELECT_CAPS)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "drop:capng_apply() failed\n");
> +        goto out;
> +    }
> +
> +    ret = 0;
> +    if (cap_dropped) {
> +        *cap_dropped = true;
> +    }
> +
> +out:
> +    return ret;
> +}
> +
> +static int gain_effective_cap(const char *cap_name)
> +{
> +    int cap;
> +    int ret = 0;
> +
> +    cap = capng_name_to_capability(cap_name);
> +    if (cap < 0) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_name_to_capability(%s) failed:%s\n",
> +                 cap_name, strerror(errno));
> +        goto out;
> +    }
> +
> +    if (load_capng()) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "load_capng() failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "capng_update(ADD,) failed\n");
> +        goto out;
> +    }
> +
> +    if (capng_apply(CAPNG_SELECT_CAPS)) {
> +        ret = errno;
> +        fuse_log(FUSE_LOG_ERR, "gain:capng_apply() failed\n");
> +        goto out;
> +    }
> +    ret = 0;
> +
> +out:
> +    return ret;
> +}
> +
>  static void lo_map_init(struct lo_map *map)
>  {
>      map->elems = NULL;
> @@ -1559,6 +1644,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
>      (void)ino;
>      ssize_t res;
>      struct fuse_bufvec out_buf = FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
> +    bool cap_fsetid_dropped = false;
>  
>      out_buf.buf[0].flags = FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
>      out_buf.buf[0].fd = lo_fi_fd(req, fi);
> @@ -1570,12 +1656,31 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
>                   out_buf.buf[0].size, (unsigned long)off);
>      }
>  
> +    /*
> +     * If kill_priv is set, drop CAP_FSETID which should lead to kernel
> +     * clearing setuid/setgid on file.
> +     */
> +    if (fi->kill_priv) {
> +        res = drop_effective_cap("FSETID", &cap_fsetid_dropped);
> +        if (res != 0) {
> +            fuse_reply_err(req, res);
> +            return;
> +        }
> +    }
> +
>      res = fuse_buf_copy(&out_buf, in_buf, 0);
>      if (res < 0) {
>          fuse_reply_err(req, -res);
>      } else {
>          fuse_reply_write(req, (size_t)res);
>      }
> +
> +    if (cap_fsetid_dropped) {
> +        res = gain_effective_cap("FSETID");
> +        if (res) {
> +            fuse_log(FUSE_LOG_ERR, "Failed to gain CAP_FSETID\n");
> +        }
> +    }
>  }
>  
>  static void lo_statfs(fuse_req_t req, fuse_ino_t ino)
> -- 
> 2.23.0


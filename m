Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14FC33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8E62082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlgaFYxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8E62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isZQx-0005pM-4Y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1isZQ9-0005MD-4h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1isZQ7-0003UV-TN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:44:49 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:38225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1isZQ7-0003Tp-N3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 16:44:47 -0500
Received: by mail-qk1-x742.google.com with SMTP id k6so24198560qki.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 13:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=d99y6GUUiMKtP66KoDIrebv0uhuAmvdSh1dheYvWuKU=;
 b=LlgaFYxrBGdKCrI2Cb/Oq1MdWweAB3c1m+hvJ6Me00gqo7dRLMN3nJ3deznfiCPo9E
 xcgZVUqvbbWtD2TkoR/W1rbGOEFtfAE3CqEfJkBGN5iBPRZNdT18sXj3RAiGnbUMCbPa
 IDeb6ZvlvIMjnWm5Oj4wsXwduTzlTFvjHKw8lSvxjUmxQM11b9YnO9hpMkhnsF0ccPdP
 5XhVh/RLrap5AxrkmhGp9L5VDA3Y+ygYqjomvUu7iy0mcSe1xALg32CVNqoWI6OPxA6w
 kmo/9ttxSog5QhgoC572oQdNNGu8YGhd2di8cfrzoxlto1DzO46TotD6D2ArLo1+moyo
 aZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d99y6GUUiMKtP66KoDIrebv0uhuAmvdSh1dheYvWuKU=;
 b=XSQsBGU5SkRzyCyGl3jHNk+yQkTr2Nuxh7OBSgS3y8l1/HTD7p8HD0Fl7BomeTfxaB
 dXofobA5+rRkEvwf5IdBHlg61REbyDjP4s66Nv2aziICs9EHsV3NwG9RAa8c4hRiYofl
 W+HlDscoqt7fFesyJAVo/s6Nno25u+dIpXNNLuSiAbJNuZ9hvfHzLqvZMrug8Qjw8R71
 aFOw6vLTree2jAmVC9LuTYTI0N0vQBohxdPdnh51v6cgLc+8wPoiqgrF6AVoOwgrcXEK
 sT8v6OqVX8QK93WLRfO+1ZUvEbiXH+CB8QO/eGurxsOvZTX22gEKewxX7946AsTmMegg
 XaDQ==
X-Gm-Message-State: APjAAAX+iYc4CcObhWfYbAtM8Pc5dCbjBaRA/0v2jAsW6L8xn+51l5W3
 Ea//nqko9pcu40hp+OPOOA==
X-Google-Smtp-Source: APXvYqzPxWbZa4I3bX2gz8zVzVHutk0biG+v1YZIo5GoiPhxmrKmcxITDC3W6uFYdhbw3gVp9NEXYA==
X-Received: by 2002:a05:620a:cd1:: with SMTP id
 b17mr36937096qkj.427.1579297486805; 
 Fri, 17 Jan 2020 13:44:46 -0800 (PST)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id d143sm12443878qke.123.2020.01.17.13.44.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Jan 2020 13:44:46 -0800 (PST)
Date: Fri, 17 Jan 2020 16:44:41 -0500
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 033/104] virtiofsd: passthrough_ll: add lo_map for ino/fh
 indirection
Message-ID: <20200117214441.gl5awagl5o2gcbhp@gabell>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-34-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212163904.159893-34-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:37:53PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> A layer of indirection is needed because passthrough_ll cannot expose
> pointers or file descriptor numbers to untrusted clients.  Malicious
> clients could send invalid pointers or file descriptors in order to
> crash or exploit the file system daemon.
> 
> lo_map provides an integer key->value mapping.  This will be used for
> ino and fh fields in the patches that follow.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 124 +++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 0188cd9ad6..0a94c3e1f2 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -74,6 +74,21 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
>  };
>  #endif
>  
> +struct lo_map_elem {
> +    union {
> +        /* Element values will go here... */
> +        ssize_t freelist;
> +    };
> +    bool in_use;
> +};
> +
> +/* Maps FUSE fh or ino values to internal objects */
> +struct lo_map {
> +    struct lo_map_elem *elems;
> +    size_t nelems;
> +    ssize_t freelist;
> +};
> +
>  struct lo_inode {
>      struct lo_inode *next; /* protected by lo->mutex */
>      struct lo_inode *prev; /* protected by lo->mutex */
> @@ -130,6 +145,115 @@ static struct lo_data *lo_data(fuse_req_t req)
>      return (struct lo_data *)fuse_req_userdata(req);
>  }
>  
> +__attribute__((unused)) static void lo_map_init(struct lo_map *map)
> +{
> +    map->elems = NULL;
> +    map->nelems = 0;
> +    map->freelist = -1;
> +}
> +
> +__attribute__((unused)) static void lo_map_destroy(struct lo_map *map)
> +{
> +    free(map->elems);
> +}
> +
> +static int lo_map_grow(struct lo_map *map, size_t new_nelems)
> +{
> +    struct lo_map_elem *new_elems;
> +    size_t i;
> +
> +    if (new_nelems <= map->nelems) {
> +        return 1;
> +    }
> +
> +    new_elems = realloc(map->elems, sizeof(map->elems[0]) * new_nelems);
> +    if (!new_elems) {
> +        return 0;
> +    }
> +
> +    for (i = map->nelems; i < new_nelems; i++) {
> +        new_elems[i].freelist = i + 1;
> +        new_elems[i].in_use = false;
> +    }
> +    new_elems[new_nelems - 1].freelist = -1;
> +
> +    map->elems = new_elems;
> +    map->freelist = map->nelems;
> +    map->nelems = new_nelems;
> +    return 1;
> +}
> +
> +__attribute__((unused)) static struct lo_map_elem *
> +lo_map_alloc_elem(struct lo_map *map)
> +{
> +    struct lo_map_elem *elem;
> +
> +    if (map->freelist == -1 && !lo_map_grow(map, map->nelems + 256)) {
> +        return NULL;
> +    }
> +
> +    elem = &map->elems[map->freelist];
> +    map->freelist = elem->freelist;
> +
> +    elem->in_use = true;
> +
> +    return elem;
> +}
> +
> +__attribute__((unused)) static struct lo_map_elem *
> +lo_map_reserve(struct lo_map *map, size_t key)
> +{
> +    ssize_t *prev;
> +
> +    if (!lo_map_grow(map, key + 1)) {
> +        return NULL;
> +    }
> +
> +    for (prev = &map->freelist; *prev != -1;
> +         prev = &map->elems[*prev].freelist) {
> +        if (*prev == key) {
> +            struct lo_map_elem *elem = &map->elems[key];
> +
> +            *prev = elem->freelist;
> +            elem->in_use = true;
> +            return elem;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +__attribute__((unused)) static struct lo_map_elem *
> +lo_map_get(struct lo_map *map, size_t key)
> +{
> +    if (key >= map->nelems) {
> +        return NULL;
> +    }
> +    if (!map->elems[key].in_use) {
> +        return NULL;
> +    }
> +    return &map->elems[key];
> +}
> +
> +__attribute__((unused)) static void lo_map_remove(struct lo_map *map,
> +                                                  size_t key)
> +{
> +    struct lo_map_elem *elem;
> +
> +    if (key >= map->nelems) {
> +        return;
> +    }
> +
> +    elem = &map->elems[key];
> +    if (!elem->in_use) {
> +        return;
> +    }
> +
> +    elem->in_use = false;
> +
> +    elem->freelist = map->freelist;
> +    map->freelist = key;
> +}
> +
>  static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
>  {
>      if (ino == FUSE_ROOT_ID) {

Looks good to me.

Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>


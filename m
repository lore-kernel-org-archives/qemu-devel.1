Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167AC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D942187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSYfXasj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D942187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irn7W-0000Wc-F2
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irn6X-0007zU-Cc
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irn6T-0007Gq-36
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irn6S-0007Fl-VA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579111756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bOgIML3cp793tjXOhJDIkkBZUzjUl2QCSdfv35habE4=;
 b=hSYfXasjbc6vG8OBpJlPDeVac5PQ53AOYz4GkKyeKXTs7AgiQUZ0GRIvkaWlvyPkDizili
 gxPiCAE82XsGZXi0EkVYwzDUmbF67lp2c6FsZoVraSRmg3Joy/5stqo0Lyq2EFuPAMzGeH
 uSMZn8aM7zGliuFqfLGI8g9s6vGQezk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-UIdqoFJsOFeJ1WSL0XX8yg-1; Wed, 15 Jan 2020 13:09:12 -0500
Received: by mail-wr1-f70.google.com with SMTP id v17so8244894wrm.17
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 10:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BzfqGcMgusLhrhJYkk2yXzN5RsnEZaDNAD9m//aBY7g=;
 b=o3L2Mlcz2EDNUFC8RPvFvl7+QRSiobS+zcYpVopelSg9y5NbbRvz+Sacv08ySWiRli
 CunIJQGMNoM57K4saA78AhqNL9I2QfEXrV86bSwAiNc4KuxWKZ7lDOgBQ5jqdLSAUU1N
 iihCht7XpEkT5Oq/0AMPptur39RnB886hgLNG1HsBvR2HIxtOsFO1lh+6hXeKZLQaefo
 wAtgOP/qtK3WimkuCVHHk9vbyNGr0XTcQgDHvfpQDkAccMgwiCAYOo/8j/p4M0pUzxHk
 XS1ReKjaVs7GfwOedry3jl6WmZb4CBCzLFfr9Cytm2ixkay0LSF6ko7KH80vW0JZSBuM
 UNBg==
X-Gm-Message-State: APjAAAWU8P4iRKldKeXUM1B1Rx9hHW1V11+SGl7HEmMZhI2u2/k6G+Z6
 qjoCrJg0dnylrMfoLnZBSoncamax/8sieYJtjnk6VVoR1tXD5Bg+IXL+Y2NWV2x+5C5M3TfMxby
 ZmLtaVE53io8i7gk=
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr33558682wrx.288.1579111751513; 
 Wed, 15 Jan 2020 10:09:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz+PPvA7M9JNKvyv+7l9nI/lm0t9JL6wKsp4rySGTCidQ/WWv4fGqJ1uaCeEVhqZ4ij7mPzyA==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr33558647wrx.288.1579111751052; 
 Wed, 15 Jan 2020 10:09:11 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id n16sm25795371wro.88.2020.01.15.10.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 10:09:10 -0800 (PST)
Subject: Re: [PATCH 046/104] virtiofsd: use /proc/self/fd/ O_PATH file
 descriptor
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-47-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d882c23a-e323-0271-3e7b-4d6007241dfb@redhat.com>
Date: Wed, 15 Jan 2020 19:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-47-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: UIdqoFJsOFeJ1WSL0XX8yg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Sandboxing will remove /proc from the mount namespace so we can no
> longer build string paths into "/proc/self/fd/...".
>=20
> Keep an O_PATH file descriptor so we can still re-open fds via
> /proc/self/fd.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 129 ++++++++++++++++++++++++-------
>   1 file changed, 102 insertions(+), 27 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 123f095990..006908f25a 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -110,6 +110,9 @@ struct lo_data {
>       struct lo_map ino_map; /* protected by lo->mutex */
>       struct lo_map dirp_map; /* protected by lo->mutex */
>       struct lo_map fd_map; /* protected by lo->mutex */
> +
> +    /* An O_PATH file descriptor to /proc/self/fd/ */
> +    int proc_self_fd;
>   };
>  =20
>   static const struct fuse_opt lo_opts[] =3D {
> @@ -379,9 +382,9 @@ static int lo_parent_and_name(struct lo_data *lo, str=
uct lo_inode *inode,
>       int res;
>  =20
>   retry:
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(procname, "%i", inode->fd);
>  =20
> -    res =3D readlink(procname, path, PATH_MAX);
> +    res =3D readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
>       if (res < 0) {
>           fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink failed=
: %m\n");
>           goto fail_noretry;
> @@ -477,9 +480,9 @@ static int utimensat_empty(struct lo_data *lo, struct=
 lo_inode *inode,
>           }
>           return res;
>       }
> -    sprintf(path, "/proc/self/fd/%i", inode->fd);
> +    sprintf(path, "%i", inode->fd);
>  =20
> -    return utimensat(AT_FDCWD, path, tv, 0);
> +    return utimensat(lo->proc_self_fd, path, tv, 0);
>  =20
>   fallback:
>       res =3D lo_parent_and_name(lo, inode, path, &parent);
> @@ -535,8 +538,8 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
>           if (fi) {
>               res =3D fchmod(fd, attr->st_mode);
>           } else {
> -            sprintf(procname, "/proc/self/fd/%i", ifd);
> -            res =3D chmod(procname, attr->st_mode);
> +            sprintf(procname, "%i", ifd);
> +            res =3D fchmodat(lo->proc_self_fd, procname, attr->st_mode, =
0);
>           }
>           if (res =3D=3D -1) {
>               goto out_err;
> @@ -552,11 +555,23 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t i=
no, struct stat *attr,
>           }
>       }
>       if (valid & FUSE_SET_ATTR_SIZE) {
> +        int truncfd;
> +
>           if (fi) {
> -            res =3D ftruncate(fd, attr->st_size);
> +            truncfd =3D fd;
>           } else {
> -            sprintf(procname, "/proc/self/fd/%i", ifd);
> -            res =3D truncate(procname, attr->st_size);
> +            sprintf(procname, "%i", ifd);
> +            truncfd =3D openat(lo->proc_self_fd, procname, O_RDWR);
> +            if (truncfd < 0) {
> +                goto out_err;
> +            }
> +        }
> +
> +        res =3D ftruncate(truncfd, attr->st_size);
> +        if (!fi) {
> +            saverr =3D errno;
> +            close(truncfd);
> +            errno =3D saverr;
>           }
>           if (res =3D=3D -1) {
>               goto out_err;
> @@ -857,9 +872,9 @@ static int linkat_empty_nofollow(struct lo_data *lo, =
struct lo_inode *inode,
>           return res;
>       }
>  =20
> -    sprintf(path, "/proc/self/fd/%i", inode->fd);
> +    sprintf(path, "%i", inode->fd);
>  =20
> -    return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
> +    return linkat(lo->proc_self_fd, path, dfd, name, AT_SYMLINK_FOLLOW);
>  =20
>   fallback:
>       res =3D lo_parent_and_name(lo, inode, path, &parent);
> @@ -1387,8 +1402,8 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino,=
 struct fuse_file_info *fi)
>           fi->flags &=3D ~O_APPEND;
>       }
>  =20
> -    sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
> -    fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
> +    sprintf(buf, "%i", lo_fd(req, ino));
> +    fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
>       if (fd =3D=3D -1) {
>           return (void)fuse_reply_err(req, errno);
>       }
> @@ -1440,8 +1455,8 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi)
>   static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
>                        struct fuse_file_info *fi)
>   {
> +    struct lo_data *lo =3D lo_data(req);

We can initialize this one ...

>       int res;
> -    (void)ino;
>       int fd;
>       char *buf;
>  =20
> @@ -1449,12 +1464,12 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t i=
no, int datasync,
>                (void *)fi);
>  =20
>       if (!fi) {

... here:

            lo =3D lo_data(req);

Similarly in other functions, but I see this is the style used by this file=
.

> -        res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
> +        res =3D asprintf(&buf, "%i", lo_fd(req, ino));
>           if (res =3D=3D -1) {
>               return (void)fuse_reply_err(req, errno);
>           }
>  =20
> -        fd =3D open(buf, O_RDWR);
> +        fd =3D openat(lo->proc_self_fd, buf, O_RDWR);
>           free(buf);
>           if (fd =3D=3D -1) {
>               return (void)fuse_reply_err(req, errno);
> @@ -1570,11 +1585,13 @@ static void lo_flock(fuse_req_t req, fuse_ino_t i=
no, struct fuse_file_info *fi,
>   static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e,
>                           size_t size)
>   {
> +    struct lo_data *lo =3D lo_data(req);
>       char *value =3D NULL;
>       char procname[64];
>       struct lo_inode *inode;
>       ssize_t ret;
>       int saverr;
> +    int fd =3D -1;
>  =20
>       inode =3D lo_inode(req, ino);
>       if (!inode) {
> @@ -1599,7 +1616,11 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t=
 ino, const char *name,
>           goto out;
>       }
>  =20
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(procname, "%i", inode->fd);
> +    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
> +    if (fd < 0) {
> +        goto out_err;
> +    }
>  =20
>       if (size) {
>           value =3D malloc(size);
> @@ -1607,7 +1628,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
>               goto out_err;
>           }
>  =20
> -        ret =3D getxattr(procname, name, value, size);
> +        ret =3D fgetxattr(fd, name, value, size);
>           if (ret =3D=3D -1) {
>               goto out_err;
>           }
> @@ -1618,7 +1639,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
>  =20
>           fuse_reply_buf(req, value, ret);
>       } else {
> -        ret =3D getxattr(procname, name, NULL, 0);
> +        ret =3D fgetxattr(fd, name, NULL, 0);
>           if (ret =3D=3D -1) {
>               goto out_err;
>           }
> @@ -1627,6 +1648,10 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t=
 ino, const char *name,
>       }
>   out_free:
>       free(value);
> +
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
>       return;
>  =20
>   out_err:
> @@ -1638,11 +1663,13 @@ out:
>  =20
>   static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
>   {
> +    struct lo_data *lo =3D lo_data(req);
>       char *value =3D NULL;
>       char procname[64];
>       struct lo_inode *inode;
>       ssize_t ret;
>       int saverr;
> +    int fd =3D -1;
>  =20
>       inode =3D lo_inode(req, ino);
>       if (!inode) {
> @@ -1666,7 +1693,11 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_=
t ino, size_t size)
>           goto out;
>       }
>  =20
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(procname, "%i", inode->fd);
> +    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
> +    if (fd < 0) {
> +        goto out_err;
> +    }
>  =20
>       if (size) {
>           value =3D malloc(size);
> @@ -1674,7 +1705,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
>               goto out_err;
>           }
>  =20
> -        ret =3D listxattr(procname, value, size);
> +        ret =3D flistxattr(fd, value, size);
>           if (ret =3D=3D -1) {
>               goto out_err;
>           }
> @@ -1685,7 +1716,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
>  =20
>           fuse_reply_buf(req, value, ret);
>       } else {
> -        ret =3D listxattr(procname, NULL, 0);
> +        ret =3D flistxattr(fd, NULL, 0);
>           if (ret =3D=3D -1) {
>               goto out_err;
>           }
> @@ -1694,6 +1725,10 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_=
t ino, size_t size)
>       }
>   out_free:
>       free(value);
> +
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
>       return;
>  =20
>   out_err:
> @@ -1707,9 +1742,11 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t=
 ino, const char *name,
>                           const char *value, size_t size, int flags)
>   {
>       char procname[64];
> +    struct lo_data *lo =3D lo_data(req);
>       struct lo_inode *inode;
>       ssize_t ret;
>       int saverr;
> +    int fd =3D -1;
>  =20
>       inode =3D lo_inode(req, ino);
>       if (!inode) {
> @@ -1734,21 +1771,31 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_=
t ino, const char *name,
>           goto out;
>       }
>  =20
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(procname, "%i", inode->fd);
> +    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
> +    if (fd < 0) {
> +        saverr =3D errno;
> +        goto out;
> +    }
>  =20
> -    ret =3D setxattr(procname, name, value, size, flags);
> +    ret =3D fsetxattr(fd, name, value, size, flags);
>       saverr =3D ret =3D=3D -1 ? errno : 0;
>  =20
>   out:
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
>       fuse_reply_err(req, saverr);
>   }
>  =20
>   static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *=
name)
>   {
>       char procname[64];
> +    struct lo_data *lo =3D lo_data(req);
>       struct lo_inode *inode;
>       ssize_t ret;
>       int saverr;
> +    int fd =3D -1;
>  =20
>       inode =3D lo_inode(req, ino);
>       if (!inode) {
> @@ -1772,12 +1819,20 @@ static void lo_removexattr(fuse_req_t req, fuse_i=
no_t ino, const char *name)
>           goto out;
>       }
>  =20
> -    sprintf(procname, "/proc/self/fd/%i", inode->fd);
> +    sprintf(procname, "%i", inode->fd);
> +    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
> +    if (fd < 0) {
> +        saverr =3D errno;
> +        goto out;
> +    }
>  =20
> -    ret =3D removexattr(procname, name);
> +    ret =3D fremovexattr(fd, name);
>       saverr =3D ret =3D=3D -1 ? errno : 0;
>  =20
>   out:
> +    if (fd >=3D 0) {
> +        close(fd);
> +    }
>       fuse_reply_err(req, saverr);
>   }
>  =20
> @@ -1870,12 +1925,25 @@ static void print_capabilities(void)
>       printf("}\n");
>   }
>  =20
> +static void setup_proc_self_fd(struct lo_data *lo)
> +{
> +    lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
> +    if (lo->proc_self_fd =3D=3D -1) {
> +        fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
> +        exit(1);
> +    }
> +}
> +
>   int main(int argc, char *argv[])
>   {
>       struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
>       struct fuse_session *se;
>       struct fuse_cmdline_opts opts;
> -    struct lo_data lo =3D { .debug =3D 0, .writeback =3D 0 };
> +    struct lo_data lo =3D {
> +        .debug =3D 0,
> +        .writeback =3D 0,
> +        .proc_self_fd =3D -1,
> +    };
>       struct lo_map_elem *root_elem;
>       int ret =3D -1;
>  =20
> @@ -1986,6 +2054,9 @@ int main(int argc, char *argv[])
>  =20
>       fuse_daemonize(opts.foreground);
>  =20
> +    /* Must be after daemonize to get the right /proc/self/fd */
> +    setup_proc_self_fd(&lo);
> +
>       /* Block until ctrl+c or fusermount -u */
>       ret =3D virtio_loop(se);
>  =20
> @@ -2001,6 +2072,10 @@ err_out1:
>       lo_map_destroy(&lo.dirp_map);
>       lo_map_destroy(&lo.ino_map);
>  =20
> +    if (lo.proc_self_fd >=3D 0) {
> +        close(lo.proc_self_fd);
> +    }
> +
>       if (lo.root.fd >=3D 0) {
>           close(lo.root.fd);
>       }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



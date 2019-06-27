Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C53C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67394208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67394208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXPZ-0006Nj-LA
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgX0b-0006qT-I4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgX0Z-0003OD-Gw
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:12:25 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:52007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgX0X-0003Ae-FK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:12:21 -0400
Received: from player786.ha.ovh.net (unknown [10.109.159.136])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 181F2FFDFD
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 18:12:07 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 6B1D17681CAF;
 Thu, 27 Jun 2019 16:12:04 +0000 (UTC)
Date: Thu, 27 Jun 2019 18:12:03 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190627181203.59c956d9@bahia.lan>
In-Reply-To: <9e026ca5f087d6ef741e0d82a0067ed7cdaf129f.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <9e026ca5f087d6ef741e0d82a0067ed7cdaf129f.1561575449.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16921994128154335552
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.238
Subject: Re: [Qemu-devel] [PATCH v4 1/5] 9p: unsigned type for type, version,
 path
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 20:25:55 +0200
Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:

> There is no need for signedness on these QID fields for 9p.
> 
> Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>

You should mention here the changes you made on top of Antonios
original patch. Something like:

[CS: - also convert path
     - adapted trace-events and donttouch_stat()]

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  fsdev/9p-marshal.h   |  6 +++---
>  hw/9pfs/9p.c         |  6 +++---
>  hw/9pfs/trace-events | 14 +++++++-------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
> index c8823d878f..8f3babb60a 100644
> --- a/fsdev/9p-marshal.h
> +++ b/fsdev/9p-marshal.h
> @@ -9,9 +9,9 @@ typedef struct V9fsString
>  
>  typedef struct V9fsQID
>  {
> -    int8_t type;
> -    int32_t version;
> -    int64_t path;
> +    uint8_t type;
> +    uint32_t version;
> +    uint64_t path;
>  } V9fsQID;
>  
>  typedef struct V9fsStat
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 55821343e5..586a6dccba 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -743,9 +743,9 @@ static int donttouch_stat(V9fsStat *stat)
>  {
>      if (stat->type == -1 &&
>          stat->dev == -1 &&
> -        stat->qid.type == -1 &&
> -        stat->qid.version == -1 &&
> -        stat->qid.path == -1 &&
> +        stat->qid.type == 0xff &&
> +        stat->qid.version == (uint32_t) -1 &&
> +        stat->qid.path == (uint64_t) -1 &&
>          stat->mode == -1 &&
>          stat->atime == -1 &&
>          stat->mtime == -1 &&
> diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> index c0a0a4ab5d..6964756922 100644
> --- a/hw/9pfs/trace-events
> +++ b/hw/9pfs/trace-events
> @@ -6,7 +6,7 @@ v9fs_rerror(uint16_t tag, uint8_t id, int err) "tag %d id %d err %d"
>  v9fs_version(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
>  v9fs_version_return(uint16_t tag, uint8_t id, int32_t msize, char* version) "tag %d id %d msize %d version %s"
>  v9fs_attach(uint16_t tag, uint8_t id, int32_t fid, int32_t afid, char* uname, char* aname) "tag %u id %u fid %d afid %d uname %s aname %s"
> -v9fs_attach_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d type %d version %d path %"PRId64
> +v9fs_attach_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %d id %d type %d version %d path %"PRId64

I was expecting to see PRIu64 for an uint64_t but I now realize that %d
seems to be used all over the place for unsigned types... :-\

At least, please fix the masks of the lines you're changing in this
patch so that unsigned are passed to "u" or PRIu64. The rest of the
mess can be fixed later in a followup.

>  v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime %d length %"PRId64"}"
>  v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag %d id %d fid %d request_mask %"PRIu64
> @@ -14,9 +14,9 @@ v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mod
>  v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
>  v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
>  v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
> -v9fs_open_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
> +v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
>  v9fs_lcreate(uint16_t tag, uint8_t id, int32_t dfid, int32_t flags, int32_t mode, uint32_t gid) "tag %d id %d dfid %d flags %d mode %d gid %u"
> -v9fs_lcreate_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int32_t iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
> +v9fs_lcreate_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int32_t iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
>  v9fs_fsync(uint16_t tag, uint8_t id, int32_t fid, int datasync) "tag %d id %d fid %d datasync %d"
>  v9fs_clunk(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_read(uint16_t tag, uint8_t id, int32_t fid, uint64_t off, uint32_t max_count) "tag %d id %d fid %d off %"PRIu64" max_count %u"
> @@ -26,21 +26,21 @@ v9fs_readdir_return(uint16_t tag, uint8_t id, uint32_t count, ssize_t retval) "t
>  v9fs_write(uint16_t tag, uint8_t id, int32_t fid, uint64_t off, uint32_t count, int cnt) "tag %d id %d fid %d off %"PRIu64" count %u cnt %d"
>  v9fs_write_return(uint16_t tag, uint8_t id, int32_t total, ssize_t err) "tag %d id %d total %d err %zd"
>  v9fs_create(uint16_t tag, uint8_t id, int32_t fid, char* name, int32_t perm, int8_t mode) "tag %d id %d fid %d name %s perm %d mode %d"
> -v9fs_create_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
> +v9fs_create_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %d id %d qid={type %d version %d path %"PRId64"} iounit %d"
>  v9fs_symlink(uint16_t tag, uint8_t id, int32_t fid,  char* name, char* symname, uint32_t gid) "tag %d id %d fid %d name %s symname %s gid %u"
> -v9fs_symlink_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
> +v9fs_symlink_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
>  v9fs_flush(uint16_t tag, uint8_t id, int16_t flush_tag) "tag %d id %d flush_tag %d"
>  v9fs_link(uint16_t tag, uint8_t id, int32_t dfid, int32_t oldfid, char* name) "tag %d id %d dfid %d oldfid %d name %s"
>  v9fs_remove(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_wstat(uint16_t tag, uint8_t id, int32_t fid, int32_t mode, int32_t atime, int32_t mtime) "tag %u id %u fid %d stat={mode %d atime %d mtime %d}"
>  v9fs_mknod(uint16_t tag, uint8_t id, int32_t fid, int mode, int major, int minor) "tag %d id %d fid %d mode %d major %d minor %d"
> -v9fs_mknod_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
> +v9fs_mknod_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path) "tag %d id %d qid={type %d version %d path %"PRId64"}"
>  v9fs_lock(uint16_t tag, uint8_t id, int32_t fid, uint8_t type, uint64_t start, uint64_t length) "tag %d id %d fid %d type %d start %"PRIu64" length %"PRIu64
>  v9fs_lock_return(uint16_t tag, uint8_t id, int8_t status) "tag %d id %d status %d"
>  v9fs_getlock(uint16_t tag, uint8_t id, int32_t fid, uint8_t type, uint64_t start, uint64_t length)"tag %d id %d fid %d type %d start %"PRIu64" length %"PRIu64
>  v9fs_getlock_return(uint16_t tag, uint8_t id, uint8_t type, uint64_t start, uint64_t length, uint32_t proc_id) "tag %d id %d type %d start %"PRIu64" length %"PRIu64" proc_id %u"
>  v9fs_mkdir(uint16_t tag, uint8_t id, int32_t fid, char* name, int mode, uint32_t gid) "tag %u id %u fid %d name %s mode %d gid %u"
> -v9fs_mkdir_return(uint16_t tag, uint8_t id, int8_t type, int32_t version, int64_t path, int err) "tag %u id %u qid={type %d version %d path %"PRId64"} err %d"
> +v9fs_mkdir_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int err) "tag %u id %u qid={type %d version %d path %"PRId64"} err %d"
>  v9fs_xattrwalk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, char* name) "tag %d id %d fid %d newfid %d name %s"
>  v9fs_xattrwalk_return(uint16_t tag, uint8_t id, int64_t size) "tag %d id %d size %"PRId64
>  v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, uint64_t size, int flags) "tag %d id %d fid %d name %s size %"PRIu64" flags %d"



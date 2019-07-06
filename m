Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC3C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 10:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D272083B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 10:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Dl4w/lkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D272083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjhr6-0000ff-TC
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 06:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hjhq3-0000Br-8o
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hjhq2-0008Ep-6a
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:22:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:51933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hjhq1-0008DI-Pu
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 06:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1OKNw412AQsGYzaF42QPgwP+urnp34aewBQIbhS0LmM=; b=Dl4w/lkxhhFWNcejQH9ia3eEGJ
 5DBO167yeLqWE95+x/4UFcqcbWFFzwo6yqPbaBBplGzKhgwp9OdFAFsghTaJU+Oew7xHZkvqKKReI
 h7ei5DBQYbMDBT/S9WcqEYuQ2AZhC5MpxPo3AZLw+HL6/ZXgIw5GfzCyUlVILcsjFSigDrPNMs+Rj
 +BFix4Uc4qC5T+h9BZNEOG9kSeyBhfIIFO/ryQCgNTm97yBuMZ6EquHlVbYgg3Ovrciv+V/PTyhFx
 5nFYUxrL9J2mayFxhrJGV6likv2HTkDbppHp1U96k/KW02yaVkOJtJnT3Gr2QGH/b5pq7izcXWDL2
 v8SiVCaMj0BDzfubXDucbC/k0pU0GY1Uf3OWxn9gabYIAEVHHZFOiRMevSysJ1ZhRlvIFArOiIVZd
 FnIajolbSCdl0e8w4bAk+gE7yo3PUenwrZR3cbIue8bd43sqlz89HfcSbR4ko/SCzAxVmgeV+Kwb8
 s4ecg0pAO/jhin3pfCa8ALVS1a46r2+LfFpQRHth+WdW5zp2tpm6xOk/Pd7/PLJZlHqFC5CS53n4/
 iySyG0wAMpJrur6Hj5ux6MlavdSpre4dNHi+QzDU7FkGehRAJ9EOdBkZAtG+GJI/CnL0e6bCOwpdO
 N1J6eJyZj5wgPBCX6zRByjkFow4+1jAnXLw0Qij0A=;
To: qemu-devel@nongnu.org
Date: Sat, 06 Jul 2019 12:22:27 +0200
Message-ID: <5352483.8Ep87BTfyf@silver>
In-Reply-To: <ec68cd4c68726f09cb340348f682265060d914d4.1562154272.git.qemu_oss@crudebyte.com>
References: <cover.1562154272.git.qemu_oss@crudebyte.com>
 <ec68cd4c68726f09cb340348f682265060d914d4.1562154272.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v5 3/5] 9p: Added virtfs option
 'remap_inodes'
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 3. Juli 2019 13:13:26 CEST Christian Schoenebeck wrote:
> To support multiple devices on the 9p share, and avoid
> qid path collisions we take the device id as input
[snip]
>      - Fixed v9fs_do_readdir() having exposed info outside
>        export root with '..' entry.
[snip]
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 8cc65c2c67..39c6c2a894 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
[snip]
> @@ -1940,6 +2041,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu,
> V9fsFidState *fidp, int32_t count = 0;
>      off_t saved_dir_pos;
>      struct dirent *dent;
> +    struct stat stbuf;
> +    bool fidIsExportRoot;
> +
> +    /*
> +     * determine if fidp is the export root, which is required for safe
> +     * handling of ".." below
> +     */
> +    err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> +    if (err < 0) {
> +        return err;
> +    }
> +    fidIsExportRoot = pdu->s->dev_id == stbuf.st_dev &&
> +                      pdu->s->root_ino == stbuf.st_ino;
> 
>      /* save the directory position */
>      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> @@ -1964,16 +2078,51 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> *pdu, V9fsFidState *fidp, v9fs_string_free(&name);
>              return count;
>          }
> -        /*
> -         * Fill up just the path field of qid because the client uses
> -         * only that. To fill the entire qid structure we will have
> -         * to stat each dirent found, which is expensive
> -         */
> -        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> -        memcpy(&qid.path, &dent->d_ino, size);
> -        /* Fill the other fields with dummy values */
> -        qid.type = 0;
> -        qid.version = 0;
> +
> +        if (fidIsExportRoot && !strcmp("..", dent->d_name)) {
> +            /*
> +             * if "." is export root, then return qid of export root for
> +             * ".." to avoid exposing anything outside the export
> +             */
> +            err = fid_to_qid(pdu, fidp, &qid);
> +            if (err < 0) {
> +                v9fs_readdir_unlock(&fidp->fs.dir);
> +                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> +                v9fs_string_free(&name);
> +                return err;
> +            }

Hmm, I start to wonder whether I should postpone that particular bug fix and 
not make it part of that QID fix patch series (not even as separate patch 
there). Because that fix needs some more adjustments. E.g. I should adjust 
dent->d_type here as well; but more notably it should also distinguish between 
the case where the export root is mounted as / on guest or not and that's 
where this fix could become ugly and grow in size.

To make the case clear:  calling on guest	

	readdir(pathOfSome9pExportRootOnGuest);

currently always returns for its ".." result entry the inode number and d_type 
of the export root's parent directory on host, so it exposes information of 
host outside the 9p export.

I don't see that as security issue, since the information revealed is limited 
to the inode number and d_type, but it is definitely incorrect behaviour.

Best regards,
Christian Schoenebeck


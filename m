Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC885C3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D4C2190F
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iMGaptJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D4C2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4Vez-0007MW-Kt
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 15:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4Vdp-0006ss-EE
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1i4Vdo-000389-6H
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:36:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:46603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1i4Vdn-00031z-Ko
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 15:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=roNLp9i8Tkt+nptO+qFgLTp+We3GPxVKy4qvNTcDNWY=; b=iMGaptJpNwl5gQcuqU4EDuPZCn
 TIC5nV+RfGCcQpZXvrNI1viCOR26qkxI8QIismdlxvo79J0jAjvf46gwzBqm9Ivhs8L0f1ui7NdNF
 FY0ZBSh7LT9vC4SDAX4PKRe7Sn2Jvd6gXv2o5yufUkDsHnNd6jq5alw/L6AsxoKdx3d8MbZWB01Lq
 Xsn/yaaapDbvxZfrDhTeY+WOIug6ckfOM4DRQR1SJqzuFJHw+vPym+A8wOEJ46AE+9sZbi2Ato3vn
 mhB6P7nSlPBE106WV4MEUKkgarQTsgbPglJerDRq8XrqZdA54Kl6wTYoO28/ujk+QaiFhaxitjLC4
 7MjKf7wAw40iW+cucMnfpPaBoqGcOER1Rf+8rcMa09nwklooOM/45iucUhJoPJAkoNE/teayG3uxt
 iSrBsg/QND56wqbUABqUaSZ83klg9ssXUSTICzTNBSrjmJ481KLdErwSZC6KJ1KvuCuFI4rnqw12/
 h6n+satH58wN193fayJHuR5nfkro/BiY1uuyGe6X57Tm+9A/XV/ciCdFqwZ475h+hEJQjK6X1ZTh5
 mCAgZZebeu/Uuc/SppxiLBSDMXV50QXU8lrEVXGmBn0hkrTsNbqKf+MpLqWEoN56mOh4Ra54iyN5m
 b9reYovls0DFBUjtjfhb2VSJvrmV3LxP9meECL3lM=;
To: qemu-devel@nongnu.org
Date: Sun, 01 Sep 2019 21:35:56 +0200
Message-ID: <1656463.NAo3fzYekE@silver>
In-Reply-To: <20190830134827.326dc87a@bahia.lan>
References: <cover.1562154272.git.qemu_oss@crudebyte.com>
 <5352483.8Ep87BTfyf@silver> <20190830134827.326dc87a@bahia.lan>
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 30. August 2019 13:48:27 CEST Greg Kurz wrote:
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index 8cc65c2c67..39c6c2a894 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > 
> > [snip]
> > 
> > > @@ -1940,6 +2041,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> > > *pdu, V9fsFidState *fidp, int32_t count = 0;
> > > 
> > >      off_t saved_dir_pos;
> > >      struct dirent *dent;
> > > 
> > > +    struct stat stbuf;
> > > +    bool fidIsExportRoot;
> > > +
> > > +    /*
> > > +     * determine if fidp is the export root, which is required for safe
> > > +     * handling of ".." below
> > > +     */
> > > +    err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
> > > +    if (err < 0) {
> > > +        return err;
> > > +    }
> > > +    fidIsExportRoot = pdu->s->dev_id == stbuf.st_dev &&
> > > +                      pdu->s->root_ino == stbuf.st_ino;
> > > 
> > >      /* save the directory position */
> > >      saved_dir_pos = v9fs_co_telldir(pdu, fidp);
> > > 
> > > @@ -1964,16 +2078,51 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU
> > > *pdu, V9fsFidState *fidp, v9fs_string_free(&name);
> > > 
> > >              return count;
> > >          
> > >          }
> > > 
> > > -        /*
> > > -         * Fill up just the path field of qid because the client uses
> > > -         * only that. To fill the entire qid structure we will have
> > > -         * to stat each dirent found, which is expensive
> > > -         */
> > > -        size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
> > > -        memcpy(&qid.path, &dent->d_ino, size);
> > > -        /* Fill the other fields with dummy values */
> > > -        qid.type = 0;
> > > -        qid.version = 0;
> > > +
> > > +        if (fidIsExportRoot && !strcmp("..", dent->d_name)) {
> > > +            /*
> > > +             * if "." is export root, then return qid of export root
> > > for
> > > +             * ".." to avoid exposing anything outside the export
> > > +             */
> > > +            err = fid_to_qid(pdu, fidp, &qid);
> > > +            if (err < 0) {
> > > +                v9fs_readdir_unlock(&fidp->fs.dir);
> > > +                v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
> > > +                v9fs_string_free(&name);
> > > +                return err;
> > > +            }
> > 
> > Hmm, I start to wonder whether I should postpone that particular bug fix
> > and not make it part of that QID fix patch series (not even as separate
> > patch there). Because that fix needs some more adjustments. E.g. I should
> > adjust dent->d_type here as well; but more notably it should also
> > distinguish between the case where the export root is mounted as / on
> > guest or not and that's where this fix could become ugly and grow in
> > size.
> > 
> > To make the case clear:  calling on guest
> > 
> > 	readdir(pathOfSome9pExportRootOnGuest);
> > 
> > currently always returns for its ".." result entry the inode number and
> > d_type of the export root's parent directory on host, so it exposes
> > information of host outside the 9p export.
> > 
> > I don't see that as security issue, since the information revealed is
> > limited to the inode number and d_type, but it is definitely incorrect
> > behaviour.
> Definitely. This should be fixed independently of this series. Maybe follow
> the same approach as commit 56f101ecce0e "9pfs: handle walk of ".." in the
> root directory", ie. basically make /.. an alias of /.

That's actually what the suggested fix already did in v5 here (see diff above). 
However I was worried whether I thought about all edge cases. So I also need 
some more testing and hence clearly decided to postpone this fix for now.

Best regards,
Christian Schoenebeck



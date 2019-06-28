Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FBD2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="nwfFkmDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FBD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsN2-0000Dj-H0
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgrEd-0003sf-1A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1hgrEa-0006nO-Ak
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:48:14 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:51609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1hgrEW-0006c6-4R
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yx7v48X7vavRmsbFebclOAvVwiaZPkTdVBnwcYkHA0E=; b=nwfFkmDuaEd/7oRvTZ/oQxsiAq
 ikPKNCAnO8E3P4d4uPaRot/GQivZTUsIicT+/eq9WDZe9fhf9d/1XnXw9kUhy9crGE0w08Ah/4ueO
 jztKEh+o1UQYq/0eyIYHUWsGhf52RVbWpNullDnM4q6+8m6oWwikKguY3vrwU4CHTX+5F+F1GAtCa
 Y4TT41PNcOaXCji4l67SGSXo6yfDDKC59v3ddc7lJEpM/tHcjzu2xFV66AroFPXgx3hFuPUevtzJv
 3aY2yuAD0sOakRuwKYa6sF8J9Qg2N/3HGcIiqB0PeNR3EaZj409fY9XSfP4YXRuFTLjlgvxdPy1y5
 dK3CzAYpZdFqu3u9pUjuL+zQT0viEzCv32AiKa360cLc0wJwvHqjePVXuoY/taFDfSQwH6F607fMq
 PqyVpqunjNEw5qGmsYtjDdBD5P50hpnsMnyftCTA9kXxNM/Vfi5ECYyVSPaLfVEfKoan3Tq6lXNxB
 nfbf1/seC7GAF5hI5AP/1Dul2wppB7Ylr9CmHZVRZhiyv3VM/sstMILplrXqBeSkCVzxNW4fhEDLg
 /xiWG3xTt6zk6K+7y9cIXR4g+d1TAYLziNXM3dJEXCrZ1N8aiDzVYdYVs3hZ8z82Zh2VOW2Nsp+Wt
 Q1bD1AoxUAcqM71w7JujOJJtdKHt+p8cVISEgxMNs=;
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 15:47:52 +0200
Message-ID: <4068711.1y5nem0Q7a@silver>
In-Reply-To: <20190628120931.2d31f741@bahia.lan>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <91b9f8920735847e6c0e84ab6dc2c689aed13cc7.1561575449.git.qemu_oss@crudebyte.com>
 <20190628120931.2d31f741@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [PATCH v4 3/5] 9p: Added virtfs option
 "remap_inodes"
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

On Freitag, 28. Juni 2019 12:09:31 CEST Greg Kurz wrote:
> On Wed, 26 Jun 2019 20:42:13 +0200
> 
> Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > To support multiple devices on the 9p share, and avoid
> > qid path collisions we take the device id as input
> > to generate a unique QID path. The lowest 48 bits of
> > the path will be set equal to the file inode, and the
> > top bits will be uniquely assigned based on the top
> > 16 bits of the inode and the device id.
> > 
> > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> 
> Same remark about changes to the original patch.

ack_once();   :)

> BTW, I had a concern with the way v9fs_do_readdir() open-codes QID
> generation without calling stat_to_qid().
> 
> See discussion here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02724.html
> 
> I guess you should ensure in a preliminary patch that QIDs only
> come out of stat_to_qid().

Mja, actually I first omitted your suggestion consciously, because I first 
thought it was an overkill pure visibility issue lmited to the default case 
remap_inodes==false, but now that I look at it again, it is actually an issue 
even when remap_inodes==true since dirent would expose wrong inode numbers on 
guest as well.

I will see what to do about it. However about your other concern here, quote:

	"Also, if we hit a collision while reading the directory, I'm
	 afraid the remaining entries won't be read at all. I'm not
	 sure this is really what we want."

That's however still a concern here that I would consider overkill to address. 
I mean if a user gets into that situation then because of a configuration error 
that must be corrected by user; the point of this patch set is to prevent 
undefined behaviour and to make the user aware about the root cause of the 
overall issue; the purpose is not to address all possible issues while there 
is still a configuration error.

> > +static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
> > +                                uint64_t *path)
> > +{
> > +    QppEntry lookup = {
> > +        .dev = stbuf->st_dev,
> > +        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
> > +    }, *val;
> > +    uint32_t hash = qpp_hash(lookup);
> > +
> > +    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
> > +
> > +    if (!val) {
> > +        if (pdu->s->qp_prefix_next == 0) {
> > +            /* we ran out of prefixes */
> 
> And we won't ever be able to allocate a new one. Maybe worth
> adding an error_report_once() to inform the user ?

Yeah, I thought about that as well. Will do.

> >  static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID
> >  *qidp) {
> > 
> > -    size_t size;
> > +    int err;
> > 
> > -    if (pdu->s->dev_id == 0) {
> > -        pdu->s->dev_id = stbuf->st_dev;
> > -    } else if (pdu->s->dev_id != stbuf->st_dev) {
> > -        error_report_once(
> > -            "9p: Multiple devices detected in same VirtFS export. "
> > -            "You must use a separate export for each device."
> > -        );
> > -        return -ENOSYS;
> > +    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> > +        /* map inode+device to qid path (fast path) */
> > +        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
> > +        if (err) {
> > +            return err;
> > +        }
> > +    } else {
> > +        if (pdu->s->dev_id == 0) {
> > +            pdu->s->dev_id = stbuf->st_dev;
> > +        } else if (pdu->s->dev_id != stbuf->st_dev) {
> > +            error_report_once(
> > +                "9p: Multiple devices detected in same VirtFS export. "
> > +                "You must either use a separate export for each device "
> > +                "shared from host or enable virtfs option
> > 'remap_inodes'."
> > +            );
> > +            return -ENOSYS;
> > +        }
> > +        size_t size;
> 
> From CODING_STYLE:
> 
> 5. Declarations
> 
> Mixed declarations (interleaving statements and declarations within
> blocks) are generally not allowed; declarations should be at the beginning
> of blocks.
> 
> Please do so for "size" and add an extra blank line.

Ok.

> > +#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
> 
> This won't give the expected result on a 32-bit host. Since this
> is a mask for 64-bit entities, it should rather be:
> 
> #define QPATH_INO_MASK        ((1ULL << 48) - 1)

Correct, will fix it.

> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 0d8beb4afd..e7ea136da1 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1334,7 +1334,7 @@ ETEXI
> > 
> >  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
> >  
> >      "-virtfs
> >      local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-fil
> >      e|passthrough|none\n"> 
> > -    "       
> > [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n" +
> >    "       
> > [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,rem
> > ap_inodes]\n"
> This feature applies to all backends IIUC. We don't really care for the
> synth backend since it generates non-colliding inode numbers by design,
> but the proxy backend has the same issue as local. So...

Yeah, I was not sure about these, because I did not even know what these two 
were for exactly. :)  [ lazyness disclaimer end]

Will do for the other manual locations you mentioned as well.

Best regards,
Christian Schoenebeck


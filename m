Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB434C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F162064A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F162064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgspJ-0005Zn-RY
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hgrmg-0008TW-Gf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hgrme-0002gZ-F7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:23:26 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:38360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hgrmc-0002Yu-Ie
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:23:22 -0400
Received: from player779.ha.ovh.net (unknown [10.109.159.73])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0BB86241BFD
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 16:23:14 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 330CC7437332;
 Fri, 28 Jun 2019 14:23:10 +0000 (UTC)
Date: Fri, 28 Jun 2019 16:23:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190628162308.40ec742c@bahia.lan>
In-Reply-To: <4068711.1y5nem0Q7a@silver>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <91b9f8920735847e6c0e84ab6dc2c689aed13cc7.1561575449.git.qemu_oss@crudebyte.com>
 <20190628120931.2d31f741@bahia.lan> <4068711.1y5nem0Q7a@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2509067945825376576
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.100
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 15:47:52 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 28. Juni 2019 12:09:31 CEST Greg Kurz wrote:
> > On Wed, 26 Jun 2019 20:42:13 +0200
> > 
> > Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org> wrote:
> > > To support multiple devices on the 9p share, and avoid
> > > qid path collisions we take the device id as input
> > > to generate a unique QID path. The lowest 48 bits of
> > > the path will be set equal to the file inode, and the
> > > top bits will be uniquely assigned based on the top
> > > 16 bits of the inode and the device id.
> > > 
> > > Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
> > 
> > Same remark about changes to the original patch.
> 
> ack_once();   :)
> 

:)

> > BTW, I had a concern with the way v9fs_do_readdir() open-codes QID
> > generation without calling stat_to_qid().
> > 
> > See discussion here:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02724.html
> > 
> > I guess you should ensure in a preliminary patch that QIDs only
> > come out of stat_to_qid().
> 
> Mja, actually I first omitted your suggestion consciously, because I first 
> thought it was an overkill pure visibility issue lmited to the default case 
> remap_inodes==false, but now that I look at it again, it is actually an issue 
> even when remap_inodes==true since dirent would expose wrong inode numbers on 
> guest as well.
> 
> I will see what to do about it. However about your other concern here, quote:
> 
> 	"Also, if we hit a collision while reading the directory, I'm
> 	 afraid the remaining entries won't be read at all. I'm not
> 	 sure this is really what we want."
> 
> That's however still a concern here that I would consider overkill to address. 
> I mean if a user gets into that situation then because of a configuration error 
> that must be corrected by user; the point of this patch set is to prevent 
> undefined behaviour and to make the user aware about the root cause of the 
> overall issue; the purpose is not to address all possible issues while there 
> is still a configuration error.
> 

Fair enough. And anyway, if we really need to address that, it can be done
later.

> > > +static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
> > > +                                uint64_t *path)
> > > +{
> > > +    QppEntry lookup = {
> > > +        .dev = stbuf->st_dev,
> > > +        .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
> > > +    }, *val;
> > > +    uint32_t hash = qpp_hash(lookup);
> > > +
> > > +    val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
> > > +
> > > +    if (!val) {
> > > +        if (pdu->s->qp_prefix_next == 0) {
> > > +            /* we ran out of prefixes */
> > 
> > And we won't ever be able to allocate a new one. Maybe worth
> > adding an error_report_once() to inform the user ?
> 
> Yeah, I thought about that as well. Will do.
> 
> > >  static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID
> > >  *qidp) {
> > > 
> > > -    size_t size;
> > > +    int err;
> > > 
> > > -    if (pdu->s->dev_id == 0) {
> > > -        pdu->s->dev_id = stbuf->st_dev;
> > > -    } else if (pdu->s->dev_id != stbuf->st_dev) {
> > > -        error_report_once(
> > > -            "9p: Multiple devices detected in same VirtFS export. "
> > > -            "You must use a separate export for each device."
> > > -        );
> > > -        return -ENOSYS;
> > > +    if (pdu->s->ctx.export_flags & V9FS_REMAP_INODES) {
> > > +        /* map inode+device to qid path (fast path) */
> > > +        err = qid_path_prefixmap(pdu, stbuf, &qidp->path);
> > > +        if (err) {
> > > +            return err;
> > > +        }
> > > +    } else {
> > > +        if (pdu->s->dev_id == 0) {
> > > +            pdu->s->dev_id = stbuf->st_dev;
> > > +        } else if (pdu->s->dev_id != stbuf->st_dev) {
> > > +            error_report_once(
> > > +                "9p: Multiple devices detected in same VirtFS export. "
> > > +                "You must either use a separate export for each device "
> > > +                "shared from host or enable virtfs option
> > > 'remap_inodes'."
> > > +            );
> > > +            return -ENOSYS;
> > > +        }
> > > +        size_t size;
> > 
> > From CODING_STYLE:
> > 
> > 5. Declarations
> > 
> > Mixed declarations (interleaving statements and declarations within
> > blocks) are generally not allowed; declarations should be at the beginning
> > of blocks.
> > 
> > Please do so for "size" and add an extra blank line.
> 
> Ok.
> 
> > > +#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
> > 
> > This won't give the expected result on a 32-bit host. Since this
> > is a mask for 64-bit entities, it should rather be:
> > 
> > #define QPATH_INO_MASK        ((1ULL << 48) - 1)
> 
> Correct, will fix it.
> 
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 0d8beb4afd..e7ea136da1 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -1334,7 +1334,7 @@ ETEXI
> > > 
> > >  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
> > >  
> > >      "-virtfs
> > >      local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-fil
> > >      e|passthrough|none\n"> 
> > > -    "       
> > > [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n" +
> > >    "       
> > > [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode][,rem
> > > ap_inodes]\n"
> > This feature applies to all backends IIUC. We don't really care for the
> > synth backend since it generates non-colliding inode numbers by design,
> > but the proxy backend has the same issue as local. So...
> 
> Yeah, I was not sure about these, because I did not even know what these two 
> were for exactly. :)  [ lazyness disclaimer end]
> 

"proxy" is a backend where all I/O accesses are performed by a separate
process running the virtfs-proxy-helper command. It runs with root
privileges, which provides the same level of functionality as "local"
with security_model=passthrough. It also chroot() into the shared
folder for extra security. But it is slower since it all requests
still go through the virtio-9p device in QEMU. This would call
for a vhost-9p implementation, but it's yet another story.

"synth" is a software pseudo-backend, currently used to test 9pfs
with QTest (see tests/virtio-9p-test.c).

> Will do for the other manual locations you mentioned as well.
> 
> Best regards,
> Christian Schoenebeck



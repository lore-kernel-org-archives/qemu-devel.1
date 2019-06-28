Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BBC5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9915A20645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9915A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqYs-00044z-9t
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgqEU-0006SO-Ba
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgqET-0000Mp-0s
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgqEP-0000KS-DN; Fri, 28 Jun 2019 08:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FC2EC049E23;
 Fri, 28 Jun 2019 12:06:26 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79E986012D;
 Fri, 28 Jun 2019 12:06:23 +0000 (UTC)
Date: Fri, 28 Jun 2019 14:06:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 28 Jun 2019 12:06:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.06.2019 um 13:24 hat Denis Plotnikov geschrieben:
> 
> 
> On 28.06.2019 13:23, Kevin Wolf wrote:
> > Am 28.05.2019 um 16:37 hat Denis Plotnikov geschrieben:
> >> With the patch, qcow2 is able to process image compression type
> >> defined in the image header and choose the corresponding method
> >> for clusters compressing.
> >>
> >> Also, it rework the cluster compression code for adding more
> >> compression types.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >>   block/qcow2.c | 103 ++++++++++++++++++++++++++++++++++++++++++++------
> >>   1 file changed, 92 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/block/qcow2.c b/block/qcow2.c
> >> index c4b5b93408..90f15cc3c9 100644
> >> --- a/block/qcow2.c
> >> +++ b/block/qcow2.c
> >> @@ -400,11 +400,39 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
> >>               break;
> >>   
> >>           case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
> >> +            /* Compression type always goes with the compression type bit set */
> >> +            if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
> >> +                error_setg(errp,
> >> +                           "compression_type_ext: "
> >> +                           "expect compression type bit set");
> >> +                return -EINVAL;
> >> +            }
> >> +
> >> +            ret = bdrv_pread(bs->file, offset, &s->compression_type, ext.len);
> >> +            s->compression_type = be32_to_cpu(s->compression_type);
> >> +
> >> +            if (ret < 0) {
> >> +                error_setg_errno(errp, -ret,
> >> +                                 "ERROR: Could not read compression type");
> >> +                return ret;
> >> +            }
> >> +
> >>               /*
> >> -             * Setting compression type to BDRVQcow2State->compression_type
> >> -             * from the image header is going to be here
> >> +             * The default compression type is not allowed when the extension
> >> +             * is present. ZLIB is used as the default compression type.
> >> +             * When compression type extension header is present then
> >> +             * compression_type should have a value different from the default.
> >>                */
> >> -             break;
> >> +            if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
> >> +                error_setg(errp,
> >> +                           "compression_type_ext:"
> >> +                           "invalid compression type %d",
> >> +                           QCOW2_COMPRESSION_TYPE_ZLIB);
> >> +            }
> > 
> > This is a restriction that the spec doesn't make, so strictly speaking
> > this implementation wouldn't be compliant to the spec.
> The idea is that ZLIB shouldn't appear in the compression type 
> extension. This allows image backward compatibility with an older qemu 
> if zlib is used.
> 
> There is no reason to set ZLIB in the extension because an older qemu 
> knows how to tread ZLIB compressed clusters.
> 
> The restriction aims to guarantee that.
> 
> I tried to describe this case in the specification:
> ...
> When the compression type bit is not set, and the compression type 
> header extension is absent, ZLIB compression is used for compressed 
> clusters.
> 
> Qemu versions older than 4.1 can use images created with compression 
> type ZLIB without any additional preparations and cannot use images 
> created with compression types != ZLIB.
> ...
> 
> Does it makes sense?

This text says that using zlib in the extension is not necessary because
it's the default. But it doesn't say that using zlib in the extension is
illegal.

I agree that there is no good reason to create a compression type
extension if you have zlib. But is there a good reason to forbid it? It
only requires us to add artificial restrictions to code that would work
fine without them.

Either way, if we want to reject such extensions, the spec needs to say
that it's illegal. And if the spec allows such images, we must accept
them.

> > We can discuss whether the code or the spec should be changed. At the
> > moment, I don't see a good reason to make the restriction
> > 
> >> +#ifdef DEBUG_EXT
> >> +            printf("Qcow2: image compression type %s\n", s->compression_type);
> >> +#endif
> >> +            break;
> >>   
> >>           case QCOW2_EXT_MAGIC_DATA_FILE:
> >>           {
> > 
> > We would save most of this code if we added a new field to the header
> > instead of adding a header extension. Not saying that we should
> > definitely do this, but let's discuss it at least.
> 
> If we add the new field to the header will the older qemu be able to use 
> it. Or we will add the header only if needed, i.e. if compression_type 
> != zlib

Increasing the header size is backwards compatible. Older qemu versions
should handle such images correctly. They would store the unknown part
of the header in s->unknown_header_fields and keep it unmodified when
updating the image header.

We would still add the incompatible feature flag for non-zlib, of
course.

Kevin


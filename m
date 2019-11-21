Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495EDC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C3220672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cuOhhOTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C3220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrMD-0007t7-11
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXrIb-0006jj-Df
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXrIa-0004Sj-Ak
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:35:25 -0500
Received: from mout.web.de ([212.227.15.14]:49303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXrIZ-0004SE-U3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574361288;
 bh=t68NHTdFeM6yu7m22dumHFl0QXjqBpA+Lm+dwiMT7pc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cuOhhOTaPcNNxic5Nb/xx6azeJiYpP2cZ2GjyZ3piERrh53uH1jAqEUK6lMxdCvj6
 0JeqSwir7af/gGGJRw5uhZrz00hcIR/PF/fFlXYaM8FCS1g/UfGXf+cGEPxGNCl5CJ
 77hF7F33vXE9/iMh4mJTsO28ezzE2WmPBM2ASens=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MDPUT-1ideC52O7x-00GppW; Thu, 21
 Nov 2019 19:34:48 +0100
Date: Thu, 21 Nov 2019 19:34:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] block/quorum.c: stable children names
Message-ID: <20191121193445.2361b846@luklap>
In-Reply-To: <2ce1be55-010b-d3c3-9df4-e8e02eb522f9@redhat.com>
References: <cover.1574356137.git.lukasstraub2@web.de>
 <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
 <2ce1be55-010b-d3c3-9df4-e8e02eb522f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ANBxRe/fuuwkDI9yB2OTq9RRUDiavF5BifjJ0AHI7hdyI79Jfd6
 zKh3SvlVUBUB1NrPEJ6qva++qXVARBe41XkLOzEw6BKdZonXHYoyiMieszH0Zagq4p6lZwH
 wgwmLRmyshv3yS0POoVYi6INs5UM3ybjLCFTCibyGa27zuZurs8atqPRspwWm+Y8yJ3lWqz
 SF6dKpB02vAlLukyk+fuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e+LfmDV7rSk=:Hn3AVCExgFIvkqOgb3Lj4t
 bo9pT2xLN23pRrnxFNLbBibhh9gYy8HX7HsuWOiLNVpx7MH5+KaOsSAWwKjuuDak3j3ku0/LX
 TutqpPxr+0QeUa+zfpj7x5DrTK1W/B7cKSt5LvLPsFtr4yH/zFQJRsmyKk9e+l4y48gMh8lNh
 4K2iZpp+Yir+36A/QK04n/XlCFaaQPcnohFI2E762Kk2OgZ+VkEZxJ2CxCZfAWHNp/k6TxGTE
 od/n7aCaOcr97fQ8Amz4Z2TmmDjU5j0izN8p31GYnxIJkskwK9/ccPxvPYO1VPeTAkwJaI7BZ
 8QzEFkxLd/ei8Rl2lerwMV8/UfKTeavb7HVPW/0yqN7nei0b02B5SkfiN5Q41N8971+Jb59PJ
 tQnS9grNpkrx5yYcB9mpScGHEmYvE/L+c4FiLVEdNs4o1zDL4ALtqpaShz7mDh8N4YvhrKjr7
 JE/VklDyf4VoaFWE76T16/YFybsv3wfuI7e01FDNoKCJCRDrVvo4MhnV/QzBTcBPsN57WNZqQ
 5hKkBtnK3xRu2tBS5kukxxSI3bdvBTqZ2wJ6oxRk90d44M+2sP+0pUmOv3PpT4yUyL69M8QV+
 W2t6y2RpR1PPPVxA3uy7lydQLj1fsTW85eKsIrKS6nVvEz76x1QrF/9+Q96tUJae293Wh2UnC
 yTe+Y0VVNxqAELU4Q+Szx0G3Azwo4Y/vi33m+ImVFSsvLJL8BNnt3H9onSpPk17Uk96gevVOp
 zYCZHjpoKHwTqppgG3K46UdPSOT2LG0hcTnhv1wMkS+9FiAuEbB7qCz61rF3DwI59lsQkRN2m
 VIe2Y7Koigpjac+RkQJTdWEB0ZmywhbkPAYlBHwvpQeX9aMsIJWL878aDZjD1xoJHrOFPQd3s
 7EbjtxXxkbMpMJcyEIVcHnICrscZYpBFqaYoF6X4+C/4leqCTq5eLv79+yNFCU0r7lcqWck1N
 HWiejHswXWdobd1YItFitT82I52pGM0HXWTSFHHKbUQVq2bqsWSNdFcciFc36c65i8ev2LzYY
 MbC9CFmQA/cuQKkb9jGR1+mHiVyZQNnyXOSk+e9jstJqyZzx9vUPPDlVZFFyJjNeH/uIJyxl2
 Fn++qDN2JMoLqFIkozw8RjoRLPlz1wJnAwzQJQHbz5eQnNw8kp0e6y4w3zvbZ+owzZrNYBqYg
 5X5a/YnafTasT0UNCULaeLPDnL6yUd7/ZEVnDvCO2RJkxvYR4KQCKDAhmPv80S3/87Var1sgL
 fUVigEV9JAe0FYsq0LL9W+hB5njRy2Bs3vd1P+d3aEI0iAf4LbMYdqXHrsuM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.14
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 12:04:58 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 11/21/19 11:49 AM, Lukas Straub wrote:
> > If we remove the child with the highest index from the quorum,
> > decrement s->next_child_index. This way we get stable children
> > names as long as we only remove the last child.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >   block/quorum.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/block/quorum.c b/block/quorum.c
> > index df68adcfaa..6100d4108a 100644
> > --- a/block/quorum.c
> > +++ b/block/quorum.c
> > @@ -1054,6 +1054,12 @@ static void quorum_del_child(BlockDriverState *=
bs, BdrvChild *child,
> >       /* We know now that num_children > threshold, so blkverify must =
be false */
> >       assert(!s->is_blkverify);
> >
> > +    unsigned child_id;
> > +    sscanf(child->name, "children.%u", &child_id);
>
> sscanf() cannot detect overflow. Do we trust our input enough to ignore
> this shortfall in the interface, or should we be using saner interfaces
> like qemu_strtoul()?  For that matter, why do we have to reparse
> something; is it not already available somewhere in numerical form?

Hi,
Yes, I wondered about that too, but found no other way. But the input
is trusted, AFAIK the only way to add child nodes is trough quorum_add_chi=
ld
above and quorum_open and there already are adequate checks there.

> > +    if (child_id =3D=3D s->next_child_index - 1) {
> > +        s->next_child_index--;
> > +    }
> > +
> >       bdrv_drained_begin(bs);
> >
> >       /* We can safely remove this child now */
> > --
> > 2.20.1
> >
> >
>



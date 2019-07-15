Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E500C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF7F214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF7F214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwJM-0004ND-HK
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hmwJC-0003yu-Q9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hmwJB-0006Nz-Hu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hmwJB-0006ML-8e
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD68B3DD47;
 Mon, 15 Jul 2019 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-249.ams2.redhat.com
 [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AA25C257;
 Mon, 15 Jul 2019 08:26:01 +0000 (UTC)
Date: Mon, 15 Jul 2019 10:26:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Message-ID: <20190715082600.GA10255@localhost.localdomain>
References: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
 <f3735415-bd75-8ed6-1dc7-ff51cc7ab03f@redhat.com>
 <0ea72a38-8359-b8d5-3405-52965cd56c62@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0ea72a38-8359-b8d5-3405-52965cd56c62@weilnetz.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 15 Jul 2019 08:26:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [BUG] 216 Alerts reported by LGTM for QEMU (some
 might be release critical)
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.07.2019 um 15:28 hat Stefan Weil geschrieben:
> Am 13.07.2019 um 21:42 schrieb Paolo Bonzini:
> > On 13/07/19 19:46, Stefan Weil wrote:
> >> LGTM reports 16 errors, 81 warnings and 119 recommendations:
> >> https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=3Dlist.
> >>
> >> Some of them are already known (wrong format strings), others look l=
ike
> >> real errors:
> >>
> >> - several multiplication results which don't work as they should in
> >> contrib/vhost-user-gpu, block/* (m->nb_clusters * s->cluster_size on=
ly
> >> 32 bit!),=A0 target/i386/translate.c and other files

Request sizes are limited to 32 bit in the generic block layer before
they are even passed to the individual block drivers, so most if not all
of these are going to be false positives.

> > m->nb_clusters here is limited by s->l2_slice_size (see for example
> > handle_alloc) so I wouldn't be surprised if this is a false positive.=
  I
> > couldn't find this particular multiplication in Coverity, but it has
> > about 250 issues marked as intentional or false positive so there's
> > probably a lot of overlap with what LGTM found.
> >
> > Paolo
>=20
> From other projects I know that there is a certain overlap between the
> results from Coverity Scan an LGTM, but it is good to have both
> analyzers, and the results from LGTM are typically quite reliable.
>=20
> Even if we know that there is no multiplication overflow, the code coul=
d
> be modified. Either the assigned value should use the same data type as
> the factors (possible when there is never an overflow, avoids a size
> extension), or the multiplication could use the larger data type by
> adding a type cast to one of the factors (then an overflow cannot
> happen, static code analysers and human reviewers have an easier job,
> but the multiplication costs more time).

But if you look at the code we're talking about, you see that it's
complaining about things where being more explicit would make things
less readable.

For example, if complains about the multiplication in this line:

    s->file_size +=3D n * s->header.cluster_size;

We know that n * s->header.cluster_size fits in 32 bits, but
s->file_size is 64 bits (and has to be 64 bits). Do you really think we
should introduce another uint32_t variable to store the intermediate
result? And if we cast n to uint64_t, not only might the multiplication
cost more time, but also human readers would wonder why the result could
become larger than 32 bits. So a cast would be misleading.


It also complains about this line:

    ret =3D bdrv_truncate(bs->file, (3 + l1_clusters) * s->cluster_size,
                        PREALLOC_MODE_OFF, &local_err);

Here, we don't even assign the result to a 64 bit variable, but just
pass it to a function which takes a 64 bit parameter. Again, I don't
think introducing additional variables for the intermediate result or
adding casts would be an improvement of the situation.


So I don't think this is a good enough tool to base our code on what it
does and doesn't understand. It would have too much of a negative impact
on our code. We'd rather need a way to mark false positives as such and
move on without changing the code in such cases.

Kevin


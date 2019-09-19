Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA300C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADEDB21924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEDB21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsTV-0004KX-Bq
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAsCz-0001Nz-OJ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAsCy-0005kn-NM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iAsCy-0005ka-H3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 869EE3083392;
 Thu, 19 Sep 2019 08:54:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D05A5D6B0;
 Thu, 19 Sep 2019 08:54:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5416A17535; Thu, 19 Sep 2019 10:54:34 +0200 (CEST)
Date: Thu, 19 Sep 2019 10:54:34 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Message-ID: <20190919085434.i2vkxasicqxfegvt@sirius.home.kraxel.org>
References: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
 <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
 <43E932EA88344C498D975E4FF00CF41E2EAB29A5@dggeml529-mbx.china.huawei.com>
 <CAKXe6SJB4fc_2a0gz8JJ_LD6Qh65DDXaFVhJSspTHQxxn4=UQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SJB4fc_2a0gz8JJ_LD6Qh65DDXaFVhJSspTHQxxn4=UQg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 19 Sep 2019 08:54:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
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
Cc: fangying <fangying1@huawei.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, zhouyibo <zhouyibo3@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 01, 2019 at 10:43:42PM +0800, Li Qiang wrote:
> fangying <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:29=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Nice work, your patch does fix this issue in my test.
> >
> > I think we should make VncState.zlib to be a pointer type as well.
> >
> > Since we are going to use pointers instead of copy, we must make sure=
 that
> > there=E2=80=99s no race condition of pointer members between the loca=
l vs (vnc
> > worker thread) and origin vs (main thread).
> >
> >
>=20
> Yes, there is a race between the main thread and vnc thread.

Where do you see a race?  The main thread allocates the data structures
before any job is started, cleans up after the jobs have been stopped
and never accesses them otherwise.

So unless I missed something the data structures are never accessed in
parallel from multiple threads.

> Maybe we should add a lock just like the 'vs->output_mutex'.

output is a different story.  The output buffer is accessed in parallel
(job thread produces and main thread consumes), so we actually need a
lock here for synchronization.

cheers,
  Gerd



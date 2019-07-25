Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE8C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D0992084D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0992084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqa5r-0004QD-KT
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hqa5f-0003zX-TG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hqa5e-0003Hx-QB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58534)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hqa5e-0003GQ-KO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 204C03092666;
 Thu, 25 Jul 2019 09:31:09 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7EAE5D71A;
 Thu, 25 Jul 2019 09:31:08 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id C131141F40;
 Thu, 25 Jul 2019 09:31:08 +0000 (UTC)
Date: Thu, 25 Jul 2019 05:31:08 -0400 (EDT)
From: Jason Wang <jasowang@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <896797608.4436345.1564047068026.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA-cjP6-T4JOVGu2PvNNscvrPo1RAxWwRM4iA4ufSYBaDQ@mail.gmail.com>
References: <20190722171828.11322-1-chen.zhang@intel.com>
 <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
 <9CFF81C0F6B98A43A459C9EDAD400D78061D67D3@shsmsx102.ccr.corp.intel.com>
 <599f9e75-3d85-c1e7-fe6b-34c95d9d240c@redhat.com>
 <CAFEAcA-cjP6-T4JOVGu2PvNNscvrPo1RAxWwRM4iA4ufSYBaDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.68.5.20, 10.4.195.7]
Thread-Topic: net/colo-compare.c: Fix memory leak and code style issue.
Thread-Index: J1V9J+H/5gJ18TffjJ7EqbVt4rBiPw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 09:31:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Chen Zhang <chen.zhang@intel.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> On Tue, 23 Jul 2019 at 04:24, Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2019/7/23 =E4=B8=8A=E5=8D=882:38, Zhang, Chen wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> > >> Sent: Tuesday, July 23, 2019 1:25 AM
> > >> To: Zhang, Chen <chen.zhang@intel.com>
> > >> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>; Jason Wang
> > >> <jasowang@redhat.com>;
> > >> qemu-dev <qemu-devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
> > >> Subject: Re: [PATCH V5] net/colo-compare.c: Fix memory leak and code
> > >> style
> > >> issue.
> > >>
> > >> On Mon, 22 Jul 2019 at 18:23, Zhang Chen <chen.zhang@intel.com> wrot=
e:
> > >>> From: Zhang Chen <chen.zhang@intel.com>
> > >>>
> > >>> This patch to fix the origin "char *data" memory leak, code style
> > >>> issue and add necessary check here.
> > >>> Reported-by: Coverity (CID 1402785)
> > >>>
> > >>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > >>> ---
> > >>>   net/colo-compare.c | 27 ++++++++++++++++++++-------
> > >>>   1 file changed, 20 insertions(+), 7 deletions(-)
> > >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > >>
> > >> Thanks for your patience in sending out all these versions as we wor=
ked
> > >> through the code review process.
> > > Thank you too~
> > > Maybe you or Jason can pick up this patch?
>=20
> > Applied.
>=20
> Thanks. This is now our last outstanding coverity issue --
> are you planning to send this in for rc3 ?
>=20
> -- PMM
>=20
>=20

Yes.

Thanks


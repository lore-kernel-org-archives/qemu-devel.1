Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEFCC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4726D2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4726D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXmL-00010l-Qx
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIX1w-00033J-OG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIX1v-0003Op-Ey
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iIX1s-0003Lt-Jc; Thu, 10 Oct 2019 07:54:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2F30C0546D5;
 Thu, 10 Oct 2019 11:54:47 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 154BB600C4;
 Thu, 10 Oct 2019 11:54:38 +0000 (UTC)
Date: Thu, 10 Oct 2019 13:54:36 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/1] IDE: deprecate ide-drive
Message-ID: <20191010115436.GS6129@angien.pipo.sk>
References: <20191009224303.10232-1-jsnow@redhat.com>
 <20191009224303.10232-2-jsnow@redhat.com>
 <518ae20b-049d-19ee-1e86-c48466ba0655@redhat.com>
 <20191010112650.GR6129@angien.pipo.sk>
 <10bb29c8-2375-25cd-af67-edddca1be5d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <10bb29c8-2375-25cd-af67-edddca1be5d7@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 10 Oct 2019 11:54:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 13:42:26 +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/10/19 1:26 PM, Peter Krempa wrote:
> > On Thu, Oct 10, 2019 at 13:22:37 +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > > On 10/10/19 12:43 AM, John Snow wrote:
> > > > It's an old compatibility shim that just delegates to ide-cd or i=
de-hd.
> > > > I'd like to refactor these some day, and getting rid of the super=
-object
> > > > will make that easier.
> > > >=20
> > > > Either way, we don't need this.
> > > >=20
> > > > Libvirt-checked-by: Peter Krempa <pkrempa@redhat.com>
> > >=20
> > > Peter made a comment regarding Laszlo's Regression-tested-by tag:
> > >=20
> > >    [...] nobody else is using
> > >    this convention (there are exactly 0 instances of
> > >    "Regression-tested-by" in the project git log as far as
> > >    I can see), and so in practice people reading the commits
> > >    won't really know what you meant by it. Everybody else
> > >    on the project uses "Tested-by" to mean either of the
> > >    two cases you describe above, without distinction...
> > >=20
> > > It probably applies to 'Libvirt-checked-by' too.
> >=20
> > I certainly didn't test it. So feel free to drop that line altogether=
.
>=20
> But you reviewed it, can we use your 'Reviewed-by' instead?

To be honest, I didn't really review the code nor the documentation.
I actually reviewed only the idea itself in the context of integration
with libvirt and that's why I didn't go for 'Reviewed-by:'.

The gist of the citation above is that we should stick to well known
tags with their well known meanings and I think that considering this a
'review' would be a stretch of the definiton.


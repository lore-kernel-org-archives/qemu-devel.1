Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7CC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED7220B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED7220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIHxY-0008MS-6G
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIEoV-0008Cb-Ja
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIEoU-0001dR-HV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIEoS-0001cn-Eg; Wed, 09 Oct 2019 12:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 94B4030013A1;
 Wed,  9 Oct 2019 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E61C60C63;
 Wed,  9 Oct 2019 16:27:42 +0000 (UTC)
Date: Wed, 9 Oct 2019 12:27:40 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/4] iotests: trivial cleanups
Message-ID: <20191009162740.GH30349@localhost.localdomain>
References: <20190927141728.7137-1-crosa@redhat.com>
 <ac7839be-eea2-6fa7-eff5-146d2aedf059@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac7839be-eea2-6fa7-eff5-146d2aedf059@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 09 Oct 2019 16:27:43 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 03:09:25PM +0200, Max Reitz wrote:
> On 27.09.19 16:17, Cleber Rosa wrote:
> > The most trivial set of cleanups to iotests common libraries and the
> > 044 test.
> >=20
> > Cleber Rosa (4):
> >   qemu-iotests: remove bash shebang from library files
> >   qemu-iotests: remove forceful execution success from library files
> >   qemu-iotests: 044: pass is actually a noop, so remove it
> >   qemu-iotests: 044: remove inaccurate docstring class description
> >=20
> >  tests/qemu-iotests/044            | 4 ----
> >  tests/qemu-iotests/common.config  | 5 -----
> >  tests/qemu-iotests/common.filter  | 5 -----
> >  tests/qemu-iotests/common.nbd     | 1 -
> >  tests/qemu-iotests/common.pattern | 2 --
> >  tests/qemu-iotests/common.qemu    | 2 --
> >  tests/qemu-iotests/common.rc      | 5 -----
> >  tests/qemu-iotests/common.tls     | 2 --
> >  8 files changed, 26 deletions(-)
>=20
> Looks OK to me, but I=E2=80=99d like to know what you think about Eric=E2=
=80=99s concern
> on patch 1.
>=20
> Max
>=20

Yep, I agree with Eric's point.  Will send a v2 shortly.

Thanks,
- Cleber.


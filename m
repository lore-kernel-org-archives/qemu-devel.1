Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A7C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9822184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9822184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tsg-0004sM-5x
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i9tdo-0008GS-Ck
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i9tdl-0004C5-WC
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1i9tdl-0004BO-Qi; Mon, 16 Sep 2019 12:14:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8EC33090FCD;
 Mon, 16 Sep 2019 16:14:11 +0000 (UTC)
Received: from localhost (ovpn-116-86.gru2.redhat.com [10.97.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 691EA60600;
 Mon, 16 Sep 2019 16:14:08 +0000 (UTC)
Date: Mon, 16 Sep 2019 13:14:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190916161407.GB4082@habkost.net>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 16 Sep 2019 16:14:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests/acceptance: Add tests for the
 PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <huth@tuxfamily.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 16, 2019 at 11:28:23AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi David,
>=20
> On 9/16/19 2:42 AM, David Gibson wrote:
> > On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> >> Quick tests worth to avoid regressions with the 40p machine.
> >> idea from the "Maintainers, please tell us how to boot your machines=
"
> >> thread:
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
> >>
> >> v2: Split Travis job, added Herv=E9 R-b tag
> >> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.h=
tml
> >>
> >> Regards,
> >>
> >> Phil.
> >=20
> > I'm guessing you're expecting these to go in via the testing tree, in
> > which case
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Thanks, appreciated :)
>=20
> > Or do you want me to take them via the ppc tree?
>=20
> I think the 'testing tree' should focus on the CI/testing
> infrastructure, while each subsystem maintainers should care about the
> tests covering their subsystem (the testing tree maintainers might not
> have the required knowledge to be sure a test is correctly implemented)=
.
>=20
> In this particular case I assume you don't have much knowledge of that
> PPC machine, which is a hobbyist one, but since you are the PPC
> maintainer, I'd rather see this going via your tree :)
>=20
> Alex/Cleber/Eduardo, any comment on this position?

This makes sense to me.  We don't need all new tests to go
through the same tree.

--=20
Eduardo


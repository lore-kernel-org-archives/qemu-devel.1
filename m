Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0935C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BF3206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BF3206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD96P-0006SX-Us
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD94k-0004Rr-1A
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:24:02 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:51085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD94h-0007JZ-C4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:24:01 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.188])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D59525CDE76E;
 Tue,  1 Sep 2020 18:23:55 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 18:23:55 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0038c4c01a5-5fd7-4305-be73-61e1dd7dc590,
 DF2AD85881EC9B15757C33AEE529973A5D0472CE) smtp.auth=groug@kaod.org
Date: Tue, 1 Sep 2020 18:23:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
Message-ID: <20200901182354.78a8032e@bahia.lan>
In-Reply-To: <8a3c31f0-b9e7-5ae8-2c58-0e8cee06d469@redhat.com>
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
 <159897001005.442705.16516671603870288336.stgit@bahia.lan>
 <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
 <8a3c31f0-b9e7-5ae8-2c58-0e8cee06d469@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG6EX2.mxp5.local (172.16.2.52) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: db035762-786f-4b19-8c0f-87c109d8fd83
X-Ovh-Tracer-Id: 8474367126600784349
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:22:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Connor Kuehl <ckuehl@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 18:04:59 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 01/09/20 16:59, Connor Kuehl wrote:
> > On 9/1/20 9:20 AM, Greg Kurz wrote:
> >> It is a bit of a pain to be forced to run configure before being able
> >> to use cscope and friends. Add back the rules to build them in-tree
> >> as before commit a56650518f5b.
> >>
> >> Fixes: a56650518f5b ("configure: integrate Meson in the build system")
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > This might be a user error on my part, but the way I read this it sounds
> > like I could do this:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0$ rm -rf build
> > =C2=A0=C2=A0=C2=A0=C2=A0$ make cscope
> >=20
> > and have it emit a cscope file,=C2=A0 but when I do so it complains abo=
ut the
> > build dir not existing. As I understand it, running ./configure (or
> > meson build) is what generates that build dir. Here's the error for
> > posterity:
> >=20
> > changing dir to build for make "cscope"...
> > make[1]: *** build: No such file or directory.=C2=A0 Stop.
> > make: *** [GNUmakefile:11: cscope] Error 2
>=20
> You have a stray GNUmakefile in your source directory.  It's not
> introduced by Greg's patch.
>=20
> I suggest that you remove the GNUmakefile and just use out-of-tree builds.
>=20
> > [...]
> > Since this recipe doesn't output an artifact called "cscope" I wonder if
> > this should be:
> >=20
> > .PHONY: cscope
> > cscope:
> > =C2=A0=C2=A0=C2=A0=C2=A0...
> >=20
> > or alternatively:
> >=20
> > cscope.out:
> > =C2=A0=C2=A0=C2=A0=C2=A0...
>=20
> Yes it should be phony.  I have adjusted the patch and queued it.
>=20

FWIW, as said in another mail, it is phony somewhere else in the makefile.

> Paolo
>=20



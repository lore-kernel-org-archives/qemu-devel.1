Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CBAC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C46422253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C46422253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoUL-00088s-Cr
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUoSE-0006R2-N5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:01:18 -0400
Received: from 7.mo52.mail-out.ovh.net ([188.165.59.253]:32941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kUoS8-0006nu-Gv
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:01:18 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.58])
 by mo52.mail-out.ovh.net (Postfix) with ESMTPS id 158431FDF77;
 Tue, 20 Oct 2020 12:00:58 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 20 Oct
 2020 12:00:58 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00553272c5d-6d8c-4524-bd8f-c9f27462e92e,
 1DF5E91C91B319FFB92086F2F245FA8D0BCC998A) smtp.auth=groug@kaod.org
Date: Tue, 20 Oct 2020 12:00:57 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
Message-ID: <20201020120057.42c85b2e@bahia.lan>
In-Reply-To: <5436271.QZMOO6KbSo@silver>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <eefd2394efd6ba379d36d80c52de9ad956343b47.1603111175.git.qemu_oss@crudebyte.com>
 <26d3b93c-5dbd-a58c-19e7-060120cfa326@redhat.com>
 <5436271.QZMOO6KbSo@silver>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 754ed4be-35f6-440c-add4-b95491393056
X-Ovh-Tracer-Id: 13067757272634857949
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehphhhilhhmugesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=188.165.59.253; envelope-from=groug@kaod.org;
 helo=7.mo52.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:00:59
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 11:43:18 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 20. Oktober 2020 09:36:10 CEST Philippe Mathieu-Daud=C3=A9 w=
rote:
> > On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
> > > All existing 9pfs test cases are using the 'synth' fs driver so far, =
which
> > > means they are not accessing real files, but a purely simulated (in R=
AM
> > > only) file system.
> > >=20
> > > Let's make this clear by changing the prefix of the individual qtest =
case
> > > names from 'fs/' to 'synth/'. That way they'll be easily distinguisha=
ble
> > > from upcoming new 9pfs test cases supposed to be using a different fs
> > > driver.
> > >=20
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > Message-Id:
> > > <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@cru=
deby
> > > te.com> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> >=20
> > Harmless, but don't need to sign twice ;)
>=20
> Ah, I thought that's the common way, as Greg's PRs contained 2 SOBs as we=
ll,=20
> i.e. I thought this was intended to outline the patch author and submaint=
ainer=20
> were the same person.
>=20
> BTW I actually did not explicitly add the 2nd SOB. It was rather added by=
 the=20
> patchwork client automatically. So maybe it should be fixed in the client=
 to=20
> detect an already existing SOB line? Or am missing something here?
>=20

Yeah this is the reason why my sob appears twice on patches authored by
me, and since this is harmless I never really investigated how to fix
pwclient :)

> Best regards,
> Christian Schoenebeck
>=20
>=20



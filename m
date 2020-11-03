Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9600BC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F50820780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F50820780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyPn-0002FT-JX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kZy6n-0008TW-CS; Tue, 03 Nov 2020 10:20:29 -0500
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:33105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kZy6l-0004oj-DF; Tue, 03 Nov 2020 10:20:28 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.31])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 96E1170AD9E5;
 Tue,  3 Nov 2020 16:20:21 +0100 (CET)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 3 Nov 2020
 16:20:20 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00676fa5dfd-81d2-436e-be0f-e09593a718aa,
 C161C3821E84BD2E3FFA4C47F5A99552FEBD76C4) smtp.auth=groug@kaod.org
Date: Tue, 3 Nov 2020 16:20:19 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 0/4] misc: Trivial format string fixes
Message-ID: <20201103162019.299112a8@bahia.lan>
In-Reply-To: <e2ae5627-a55d-909b-8591-f7c0400cd57c@redhat.com>
References: <20201103112558.2554390-1-philmd@redhat.com>
 <64132d34-dbd9-03ee-6f11-a6908df025bf@linux.vnet.ibm.com>
 <ddd49883-7c97-966b-1f62-52f39f4952ad@linux.vnet.ibm.com>
 <e2ae5627-a55d-909b-8591-f7c0400cd57c@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 1d10889f-4740-489f-bf45-207aef5475a7
X-Ovh-Tracer-Id: 8445656676419869173
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:20:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Dov Murik <dovmurik@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 15:28:11 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 11/3/20 3:03 PM, Dov Murik wrote:
> >=20
> > On 03/11/2020 15:58, Dov Murik wrote:
> >> On 03/11/2020 13:25, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> IIUC qemu-trivial@ doesn't queue patches during freeze,
> >>>
> >>> so it might be easier if patches are queued by respective
> >>>
> >>> subsystem maintainers.
> >>>
> >>>
> >>>
> >>> Philippe Mathieu-Daud=C3=A9 (4):
> >>>
> >>> =C2=A0=C2=A0 hw/display/cirrus_vga: Remove debugging code commented o=
ut
> >>>
> >>> =C2=A0=C2=A0 hw/display/cirrus_vga: Fix hexadecimal format string spe=
cifier
> >>>
> >>> =C2=A0=C2=A0 hw/ppc/spapr_tpm_proxy: Fix hexadecimal format string sp=
ecifier
> >>>
> >>> =C2=A0=C2=A0 migration/ram: Fix hexadecimal format string specifier
> >>>
> >>>
> >>>
> >>> =C2=A0 hw/display/cirrus_vga.c | 20 +-------------------
> >>>
> >>> =C2=A0 migration/ram.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> >>>
> >>> =C2=A0 hw/ppc/trace-events=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> >>>
> >>> =C2=A0 3 files changed, 3 insertions(+), 21 deletions(-)
> >>>
> >>>
> >>>
> >>
> >>
> >> There's at least one more easy fix:
> >>
> >> hw/misc/trace-events:106:mos6522_get_next_irq_time(uint16_t latch,
> >> int64_t d, int64_t delta) "latch=3D%d counter=3D0x%"PRId64 "
> >> delta_next=3D0x%"PRId64
>=20
> Indeed.
>=20
> >>
> >> but I have no idea how to test this.
> >>
> >> -Dov
> >>
> >=20
> > ... and one more in hw/usb/u2f-passthru.c:348 :
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s: Bad writte=
n size (req 0x%zu, val 0x%zd)",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_U2F_PASSTHRU, size=
of(host_packet), written);
>=20
> 'written' is signed, so this format looks correct...
>=20

Irrespective of the sign, u and d shouldn't be used behind 0x=20

> >=20
> > Again, I have no idea how to test/trigger these areas in the code.
> >=20
> > -Dov
> >=20
>=20
>=20



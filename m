Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:16:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEE920708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEE920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWPZ-000778-CW
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtWMw-0004r3-2L
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:13:42 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:60731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtWMu-0000gY-Bd
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:13:41 -0400
Received: from player778.ha.ovh.net (unknown [10.108.54.36])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9922116F9DB
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 15:13:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 3F346143C2E39;
 Thu,  9 Jul 2020 13:13:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0061bf80f32-882c-4e58-a5f7-a3c18fa8ad12,B4CBA90B3A6AD114FE081C226458375F80ABDB80)
 smtp.auth=groug@kaod.org
Date: Thu, 9 Jul 2020 15:13:20 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
Message-ID: <20200709151320.720fb0f0@bahia.lan>
In-Reply-To: <9951d4cb-7aba-bc65-91be-1fe57393d68e@redhat.com>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net>
 <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
 <20200708213900.GD780932@habkost.net>
 <714621e2-4585-e6ee-5812-f3a45aa09267@redhat.com>
 <20200709115413.722d4feb@bahia.lan>
 <69e8f708-4fa7-6240-1484-febae0246ae6@redhat.com>
 <20200709125525.29d28d6a@bahia.lan>
 <9951d4cb-7aba-bc65-91be-1fe57393d68e@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1729382260319820067
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.63.100; envelope-from=groug@kaod.org;
 helo=6.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 09:13:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 14:21:04 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 7/9/20 12:55 PM, Greg Kurz wrote:
> > On Thu, 9 Jul 2020 12:18:06 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >

[...]

> >>>
> >>> FYI, PAPR requires all vCPUs to be "stopped" by default. It is up to =
the
> >>> guest to start them explicitly through an RTAS call. The hypervisor is
> >>> only responsible to start a single vCPU (see spapr_cpu_set_entry_stat=
e()
> >>> called from spapr_machine_reset()) to be able to boot the guest.
> >>>
> >>> So I'm not sure to see how that would depend on the accelerator...
> >>
> >> $ qemu-system-ppc64 -M pseries-5.0,accel=3Dtcg -d in_asm
> >> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> >> cap-cfpc=3Dworkaround
> >> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> >> cap-sbbc=3Dworkaround
> >> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> >> cap-ibs=3Dworkaround
> >> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> >> cap-ccf-assist=3Don
> >> ----------------
> >> IN:
> >> 0x00000100:  48003f00  b        0x4000
> >>
> >> ----------------
> >> IN:
> >> 0x00004000:  7c7f1b78  mr       r31, r3
> >> 0x00004004:  7d6000a6  mfmsr    r11
> >> 0x00004008:  3980a000  li       r12, 0xa000
> >> 0x0000400c:  798c83c6  sldi     r12, r12, 0x30
> >> 0x00004010:  7d6b6378  or       r11, r11, r12
> >> 0x00004014:  7d600164  mtmsrd   r11
> >> ...
> >>
> >> The vCPU doesn't seem stopped to me...
> >>
> >> Am I missing something?
> >>
> >=20
> > Yeah this is the boot vCPU which is required to be started
> > by the platform as explained above, but if you had more
> > vCPUs the other ones would be stopped until the guest OS
> > asks us to start them.
>=20
> Ah OK, so we are good :)
>=20
> The machine simply has to set the 'start-powered-off' flag on
> all vCPUS except the 1st one.
>=20

We only want the first vCPU to start when the platform is
fully configured, so I'd rather put 'start-powered-off' on
every body and explicitly power on the first one during
machine reset as we do now.


Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C62C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAA42074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAA42074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtSrP-0007Kc-Ik
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtSqq-0006oV-N6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:28:20 -0400
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:38796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtSqo-0000Da-KE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:28:20 -0400
Received: from player687.ha.ovh.net (unknown [10.108.57.18])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id D8C511712B0
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 11:28:15 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 3973E1429A812;
 Thu,  9 Jul 2020 09:28:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0051e762cb4-fab0-416e-ad2b-f6aae970f9ce,B4CBA90B3A6AD114FE081C226458375F80ABDB80)
 smtp.auth=groug@kaod.org
Date: Thu, 9 Jul 2020 11:28:01 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: qemu-system-ppc64 abort()s with pcie bridges
Message-ID: <20200709112801.0f4cae40@bahia.lan>
In-Reply-To: <20200708115703.7926205a@bahia.lan>
References: <211dfb13-64cc-850b-4936-0f20f0157d7c@redhat.com>
 <20200708115703.7926205a@bahia.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16370303174541220146
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudelgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.19; envelope-from=groug@kaod.org;
 helo=14.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 05:28:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jul 2020 11:57:03 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 8 Jul 2020 10:03:47 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> >=20
> >  Hi,
> >=20
> > qemu-system-ppc64 currently abort()s when it is started with a pcie
> > bridge device:
> >=20
> > $ qemu-system-ppc64 -M pseries-5.1 -device pcie-pci-bridge
> > Unexpected error in object_property_find() at qom/object.c:1240:
> > qemu-system-ppc64: -device pcie-pci-bridge: Property '.chassis_nr' not =
found
> > Aborted (core dumped)
> >=20
> > or:
> >=20
> > $ qemu-system-ppc64 -M pseries -device dec-21154-p2p-bridge
> > Unexpected error in object_property_find() at qom/object.c:1240:
> > qemu-system-ppc64: -device dec-21154-p2p-bridge: Property '.chassis_nr'
> > not found
> > Aborted (core dumped)
> >=20
> > That's kind of ugly, and it shows up as error when running
> > scripts/device-crash-test. Is there an easy way to avoid the abort() and
> > fail more gracefully here?
> >=20
>=20
> And even worse, this can tear down a running guest with hotplug :\
>=20
> (qemu) device_add pcie-pci-bridge=20
> Unexpected error in object_property_find() at /home/greg/Work/qemu/qemu-p=
pc/qom/object.c:1240:
> Property '.chassis_nr' not found
> Aborted (core dumped)
>=20
> This is caused by recent commit:
>=20
> commit 7ef1553dac8ef8dbe547b58d7420461a16be0eeb
> Author: Markus Armbruster <armbru@redhat.com>
> Date:   Tue May 5 17:29:25 2020 +0200
>=20
>     spapr_pci: Drop some dead error handling
>    =20
>     chassis_from_bus() uses object_property_get_uint() to get property
>     "chassis_nr" of the bridge device.  Failure would be a programming
>     error.  Pass &error_abort, and simplify its callers.
>    =20
>     Cc: David Gibson <david@gibson.dropbear.id.au>
>     Cc: qemu-ppc@nongnu.org
>     Signed-off-by: Markus Armbruster <armbru@redhat.com>
>     Acked-by: David Gibson <david@gibson.dropbear.id.au>
>     Reviewed-by: Greg Kurz <groug@kaod.org>
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>     Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>     Message-Id: <20200505152926.18877-18-armbru@redhat.com>
>=20
> Before that, we would simply print the "chassir_nr not found" error,
> and in case of a cold plugged device exit.
>=20
> The root cause is that the sPAPR PCI code assumes that a PCI bridge
> has a "chassir_nr" property, ie. it is a standard PCI bridge. Other
> PCI bridge types don't have that. Not sure yet why this information
> is required, I'll check LoPAPR.
>=20

More on this side : each slot of a PCI bridge is associated a DRC (a
PAPR thingy to handle hot plug/unplug). Each DRC must have a unique
identifier system-wide. We used to use the bus number to compute
the DRC id but it was broken, so we now _hijack_ "chassis_nr" as an
alternative since this commit:

commit 05929a6c5dfe1028ef66250b7bbf11939f8e77cd
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Apr 10 11:49:28 2019 +1000

    spapr: Don't use bus number for building DRC ids

This means that we only support the standard pci-bridge device,
and this relies on the availability of "chassis_nr". Failure
to find this property is then not a programming error, but
an expected case where we want to fail gracefully (ie. revert
Markus's commit mentioned above).

While reading code I realized that we have another problem : the
realization of the pci-bridge device does fail if "chassis_nr" is
zero, but I failed to find a uniqueness check. And we get:

$ qemu-system-ppc64 -device pci-bridge,chassis_nr=3D1 -device pci-bridge,ch=
assis_nr=3D1
Unexpected error in object_property_try_add() at qom/object.c:1167:
qemu-system-ppc64: -device pci-bridge,chassis_nr=3D1: attempt to add duplic=
ate property '40000100' to object (type 'container')
Aborted (core dumped)

It is very confusing to see that we state that "chassis_nr" is unique
several times in slotid_cap_init() but it is never enforced anywhere.

    if (!chassis) {
        error_setg(errp, "Bridge chassis not specified. Each bridge is requ=
ired"
                   " to be assigned a unique chassis id > 0.");
        return -EINVAL;
    }

or

    /* We make each chassis unique, this way each bridge is First in Chassi=
s */


Michael, Marcel or anyone with PCI knowledge,

Can you shed some light on the semantics of "chassis_nr" ?

> In the meantime, since we're in soft freeze, I guess we should
> revert Markus's patch and add a big fat comment to explain
> what's going on and maybe change the error message to something
> more informative, eg. "PCIE-to-PCI bridges are not supported".
>=20
> Thoughts ?
>=20
> >  Thomas
> >=20
>=20



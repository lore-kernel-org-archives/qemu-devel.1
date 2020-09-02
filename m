Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B66C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3292078B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3292078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDOci-000174-HQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kDOc8-0000SX-8B; Wed, 02 Sep 2020 04:59:32 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:55091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kDOc6-0000I4-2E; Wed, 02 Sep 2020 04:59:31 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.191])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id C66A95D1511D;
 Wed,  2 Sep 2020 10:59:24 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 2 Sep 2020
 10:59:24 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0012be1b71a-f7e9-4ddd-b332-576716138389,
 AA3809B24A0F88596FE87CA7447536A9393A4537) smtp.auth=groug@kaod.org
Date: Wed, 2 Sep 2020 10:59:22 +0200
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 2/5] hw/pci-bridge: Do not declare local variable only
 used for assertion
Message-ID: <20200902105922.33bef18e@bahia.lan>
In-Reply-To: <20200902080801.160652-3-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
 <20200902080801.160652-3-philmd@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 17fb97fa-bd2a-48ad-92a5-ecca5a668f9f
X-Ovh-Tracer-Id: 6839841936875297272
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehrthhhsehtfihiuggulhgvrdhnvght
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 04:59:26
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  2 Sep 2020 10:07:58 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> This variable is used once in an assertion. Remove single
> declaration and access directly in the assert().
>=20
> See in "qemu/osdep.h":
>=20
>  *                                  [...] disable assertion is not
>  * supported upstream so the risk is all yours.  Meanwhile, please
>  * submit patches to remove any side-effects inside an assertion, or
>  * fixing error handling that should use Error instead of assert.
>=20

Not sure how this relates to what the patch is doing, ie. get rid
of a local variable with a single user...

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/pci-bridge/pci_bridge_dev.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
> index 4a080b7c7bf..10c521085d7 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -224,9 +224,7 @@ void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_d=
ev, DeviceState *dev,
>  void pci_bridge_dev_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *=
dev,
>                                Error **errp)
>  {
> -    PCIDevice *pci_hotplug_dev =3D PCI_DEVICE(hotplug_dev);
> -
> -    g_assert(shpc_present(pci_hotplug_dev));
> +    g_assert(shpc_present(PCI_DEVICE(hotplug_dev)));

I don't think this is correct because PCI_DEVICE() has a side-effect: it
causes QEMU to abort() if dev doesn't point to a PCI device. I guess that
if a non-PCI device reaches this code, something is clearly wrong and we
should abort(), even if QEMU was built without assertions.

>      shpc_device_unplug_cb(hotplug_dev, dev, errp);
>  }
> =20



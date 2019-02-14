Received: from eggs.gnu.org ([209.51.188.92]:59407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1guMg2-00084P-Rg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1guMg0-0004Bn-T5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:28:06 -0500
Date: Fri, 15 Feb 2019 00:57:35 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20190213013850.GX1884@umbus.fritz.box>
Message-ID: <nycvar.YSQ.7.76.1902150047200.27283@xnncv>
References: <20190212113929.31390-1-ppandit@redhat.com>
	<20190213013850.GX1884@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] ppc: add host-serial and host-model
 machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Daniel P . Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org

+-- On Wed, 13 Feb 2019, David Gibson wrote --+
| > +
| > +    object_class_property_add_str(oc, "host-serial",
| > +        machine_get_host_serial, machine_set_host_serial,
| > +        &error_abort);
| > +    object_class_property_set_description(oc, "host-serial",
| > +        "Set host's system-id to use", &error_abort);
| > +
| > +    object_class_property_add_str(oc, "host-model",
| > +        machine_get_host_model, machine_set_host_model,
| > +        &error_abort);
| > +    object_class_property_set_description(oc, "host-model",
| > +        "Set host's model-id to use", &error_abort);
| 
| You're adding properties to *all* machines, for something that's only
| used on the PAPR machine.  That doesn't seem right.

I tried to figure out about adding these options to only spapr machine, but it 
does not seem straight forward as above.
 
| >      spapr_machine_4_0_class_options(mc);
| >      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
| > +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
| 
| I'm still not convinced maintaining super-strict backwards compat at
| the expense of security is a good tradeoff here, but since the code's
| already written, let's run with it.

I think current patch will provide a way to help fix the security issue, we 
can revise it further if required.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ABEC33CB0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBC520878
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBC520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyhq-0002Nx-5G
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWygD-0001HI-VV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWygC-0006MS-JD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:16:09 -0500
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:59268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWygC-00064O-Cc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:16:08 -0500
Received: from player778.ha.ovh.net (unknown [10.108.42.23])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 0DB10195A90
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 09:15:57 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 7807FC32B1ED;
 Tue, 19 Nov 2019 08:15:53 +0000 (UTC)
Subject: Re: [PATCH for-5.0] xive/kvm: Trigger interrupts from userspace
To: David Gibson <david@gibson.dropbear.id.au>
References: <157408992731.494439.3405812941731584740.stgit@bahia.lan>
 <f81b87b2-c6c9-9c12-2929-adbb341cd391@kaod.org>
 <20191119004713.GF5582@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <50ff4d1f-6576-0fc3-e1d5-9600cdbef5e4@kaod.org>
Date: Tue, 19 Nov 2019 09:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119004713.GF5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 11870644193856490323
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegjedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.96.102
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 01:47, David Gibson wrote:
> On Mon, Nov 18, 2019 at 04:37:16PM +0100, C=E9dric Le Goater wrote:
>> On 18/11/2019 16:12, Greg Kurz wrote:
>>> When using the XIVE KVM device, the trigger page is directly accessib=
le
>>> in QEMU. Unlike with XICS, no need to ask KVM to fire the interrupt. =
A
>>> simple store on the trigger page does the job.
>>>
>>> Just call xive_esb_trigger().
>>
>> Yes but the KVM XIVE device does a few other checks.=20
>>
>> It checks that the interrupt was correctly initialized at the KVM devi=
ce
>> level. We should be fine in QEMU which has similar checks.
>>
>> It caches the LSI assertion level. We should be fine also because it i=
s
>> useless in KVM when using the XIVE native exploitation mode.
>>
>> It checks it is not a passthru interrupt. Any idea on how to check thi=
s=20
>> condition under QEMU ?=20
>> =20
>>> This may improve performance of emulated devices that go through
>>> qemu_set_irq(), eg. virtio devices created with ioeventfd=3Doff or
>>> configured by the guest to use LSI interrupts, which aren't really
>>> recommended setups.
>>
>> LGTM.
>=20
> Ok, between the comments above and this, I'm not sure if this is ready
> to merge or not.

I think it is.=20

With this change, we are loosing a check on passthrough interrupts but=20
I am not sure how critical this is given that QEMU can anyhow bypass=20
KVM and trigger the interrupt using a store on the ESB page.=20

>> Any figures to share ?=20

I am torturing Greg to have numbers :) but he resisted well.

>> C.
>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>

Let's move on.

Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

C.

>>> ---
>>>  hw/intc/spapr_xive_kvm.c |   16 ++--------------
>>>  1 file changed, 2 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>>> index 08012ac7cd76..69e73552f1ef 100644
>>> --- a/hw/intc/spapr_xive_kvm.c
>>> +++ b/hw/intc/spapr_xive_kvm.c
>>> @@ -354,32 +354,20 @@ static void kvmppc_xive_source_get_state(XiveSo=
urce *xsrc)
>>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>>>  {
>>>      XiveSource *xsrc =3D opaque;
>>> -    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>>> -    struct kvm_irq_level args;
>>> -    int rc;
>>> -
>>> -    /* The KVM XIVE device should be in use */
>>> -    assert(xive->fd !=3D -1);
>>> =20
>>> -    args.irq =3D srcno;
>>>      if (!xive_source_irq_is_lsi(xsrc, srcno)) {
>>>          if (!val) {
>>>              return;
>>>          }
>>> -        args.level =3D KVM_INTERRUPT_SET;
>>>      } else {
>>>          if (val) {
>>>              xsrc->status[srcno] |=3D XIVE_STATUS_ASSERTED;
>>> -            args.level =3D KVM_INTERRUPT_SET_LEVEL;
>>>          } else {
>>>              xsrc->status[srcno] &=3D ~XIVE_STATUS_ASSERTED;
>>> -            args.level =3D KVM_INTERRUPT_UNSET;
>>>          }
>>>      }
>>> -    rc =3D kvm_vm_ioctl(kvm_state, KVM_IRQ_LINE, &args);
>>> -    if (rc < 0) {
>>> -        error_report("XIVE: kvm_irq_line() failed : %s", strerror(er=
rno));
>>> -    }
>>> +
>>> +    xive_esb_trigger(xsrc, srcno);
>>>  }
>>
>>
>=20



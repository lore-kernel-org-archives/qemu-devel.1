Received: from eggs.gnu.org ([2001:4830:134:3::10]:42160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cOitM-0007Go-K3
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cOitJ-0007hL-Dy
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:34:00 -0500
Received: from mout.web.de ([212.227.15.14]:51709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1cOitJ-0007fg-1e
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:33:57 -0500
References: <1466495274-5011-1-git-send-email-peterx@redhat.com>
	<1466495274-5011-17-git-send-email-peterx@redhat.com>
	<576E3BEA.5010400@web.de> <20160625131854.GA16629@pxdev.xzpeter.org>
	<576EA0D0.3070602@web.de> <20160626014847.GB16629@pxdev.xzpeter.org>
	<576FD856.1020806@web.de> <20170103061530.GG22664@pxdev.xzpeter.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <872d969f-0eab-d3d8-32ef-469d6fb88ac8@web.de>
Date: Wed, 4 Jan 2017 11:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170103061530.GG22664@pxdev.xzpeter.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KlNL2t1pa98rBdsmXwFbIEQMD71p2VMiO"
Subject: Re: [Qemu-devel] [PATCH v10 16/26] intel_iommu: add support for
 split irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, rth@twiddle.net, ehabkost@redhat.com, jasowang@redhat.com, marcel@redhat.com, mst@redhat.com, rkrcmar@redhat.com, alex.williamson@redhat.com, wexu@redhat.com, davidkiarie4@gmail.com, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KlNL2t1pa98rBdsmXwFbIEQMD71p2VMiO
From: Jan Kiszka <jan.kiszka@web.de>
To: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, jasowang@redhat.com, marcel@redhat.com, mst@redhat.com,
 rkrcmar@redhat.com, alex.williamson@redhat.com, wexu@redhat.com,
 davidkiarie4@gmail.com, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Message-ID: <872d969f-0eab-d3d8-32ef-469d6fb88ac8@web.de>
Subject: Re: [PATCH v10 16/26] intel_iommu: add support for split irqchip
References: <1466495274-5011-1-git-send-email-peterx@redhat.com>
 <1466495274-5011-17-git-send-email-peterx@redhat.com>
 <576E3BEA.5010400@web.de> <20160625131854.GA16629@pxdev.xzpeter.org>
 <576EA0D0.3070602@web.de> <20160626014847.GB16629@pxdev.xzpeter.org>
 <576FD856.1020806@web.de> <20170103061530.GG22664@pxdev.xzpeter.org>
In-Reply-To: <20170103061530.GG22664@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-01-03 07:15, Peter Xu wrote:
> On Sun, Jun 26, 2016 at 03:27:50PM +0200, Jan Kiszka wrote:
>> On 2016-06-26 03:48, Peter Xu wrote:
>>> On Sat, Jun 25, 2016 at 05:18:40PM +0200, Jan Kiszka wrote:
>>>> On 2016-06-25 15:18, Peter Xu wrote:
>>>>> On Sat, Jun 25, 2016 at 10:08:10AM +0200, Jan Kiszka wrote:
>>>
>>> [...]
>>>
>>>>> I have a thought on how to implement the "sink" you have mentioned:=

>>>>>
>>>>> First of all, in KVM, we provide a new KVM_IRQ_ROUTING_* type, mayb=
e
>>>>> called:
>>>>>
>>>>>   KVM_IRQ_ROUTING_EVENTFD
>>>>
>>>> Not really, because all sources are either using eventfds, which you=
 can
>>>> also terminate in user space (already done for vhost and vfio in cer=
tain
>>>> scenarios - IIRC) or originate there anyway (IOAPIC).
>>>
>>> But how should we handle the cases when the interrupt path are all in=

>>> kernel?
>>
>> There are none which we can't redirect (only full in-kernel irqchip
>> would have, but that's unsupported anyway).
>>
>>>
>>> For vhost, data should be transfered all inside kernel when split
>>> irqchip and irqfd are used: when vhost got data, it triggers irqfd to=

>>> deliver the interrupt to KVM. Along the way, we should all in kernel.=

>>>
>>> For vfio, we have vfio_msihandler() who handles the hardware IRQ and
>>> then triggers irqfd as well to KVM. Again, it seems all in kernel
>>> space, no chance to stop that as well.
>>>
>>> Please correct me if I was wrong.
>>
>> Look at what vhost is doing e.g.: when a virtqueue is masked, it
>> installs an event notifier that records incoming events in a pending
>> state field. When it's unmasked, the corresponding KVM irqfd is instal=
led.
>=20
> Hmm I think it's time I pick up this topic up again... :)
>=20
> Since it's been half a year from the last post of this thread (I
> believe this thread is the so-called "cold data" and should be stored
> on tapes already... and sorry fot the long delay), I'd like to do a
> quick summary on this: interrupt remap still cannot work well when we
> install fault interrupts - when that happens, we should inject VT-d
> fault, rather than keeping silence.
>=20
> The suggestion from Jan above should be a good solution that only need
> to touch qemu part - that's the most benefit AFAIU. However, OTOH IMO
> we need to modify all the kvm irqfd users with this fix (pci-assign,
> ioapic, ivshmem, vfio-pci, virtio) - we need to have all these devices
> init with an "fault sink" eventfd, then when we detected specific
> irqfd install error, we install the "fault sink". What's worse, if we
> add new devices with irqfd support, we need to implement the same
> error handling logic as well. Am I understanding it correctly? If so,
> isn't that awkward?
>=20
> Now I am re-thinking about my KVM_IRQ_ROUTING_EVENTFD proposal to do
> it - in that case, we should not need to worry about the users of kvm
> irqfd, and the error handling is done automatically even with new
> irqfd users coming in. The disadvantage is of course we need to touch
> both qemu and kvm, also we need to touch KVM API for it (though I
> think it'll only need very small change in KVM). And not sure whether
> that would worth it.
>=20
> Or, any better way to do it?
>=20
> Hope I didn't miss anything. Comments are welcomed!
>=20

I don't have the details in mind again, but I suppose the only
alternative to fixing a QEMU boilerplate code issue with new KVM kernel
interface is abstracting the common patterns in QEMU that all the irqfd
users share and solve solve that topic once. Might turn out, though,
that the exiting kernel interface prevents this...

Jan



--KlNL2t1pa98rBdsmXwFbIEQMD71p2VMiO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhsz4AACgkQitSsb3rl5xSaAACfXQXXURWXaiMt25TQgjW6Ff9c
k7UAn2Cw9mvK/TuEVX3BTA9J0fu3yVPT
=jaKD
-----END PGP SIGNATURE-----

--KlNL2t1pa98rBdsmXwFbIEQMD71p2VMiO--

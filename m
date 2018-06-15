Received: from eggs.gnu.org ([2001:4830:134:3::10]:46188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTl0J-000784-QO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTl0H-0004Zu-UE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:26:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTl0H-0004ZD-NJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 05:26:45 -0400
Date: Fri, 15 Jun 2018 10:26:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180615092641.GJ31552@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
	<20180614082155.GI6355@redhat.com>
	<79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
	<20180614151048.GA18967@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB01BFEE@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB01BFEE@dggeml511-mbx.china.huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "frankja@linux.ibm.com" <frankja@linux.ibm.com>, "mst@redhat.com" <mst@redhat.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, longpeng <longpeng2@huawei.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, "mjrosato@linux.vnet.ibm.com" <mjrosato@linux.vnet.ibm.com>

On Fri, Jun 15, 2018 at 12:52:05AM +0000, Gonglei (Arei) wrote:
>=20
>=20
> > -----Original Message-----
> > From: Daniel P. Berrang=C3=A9 [mailto:berrange@redhat.com]
> > Sent: Thursday, June 14, 2018 11:11 PM
> > To: Farhan Ali <alifm@linux.ibm.com>
> > Cc: Halil Pasic <pasic@linux.ibm.com>; qemu-devel@nongnu.org;
> > frankja@linux.ibm.com; mst@redhat.com; borntraeger@de.ibm.com; Gongle=
i
> > (Arei) <arei.gonglei@huawei.com>; longpeng <longpeng2@huawei.com>;
> > Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>;
> > mjrosato@linux.vnet.ibm.com
> > Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling=
 of cipher
> > algorithms for virtio-crypto device
> >=20
> > On Thu, Jun 14, 2018 at 10:50:40AM -0400, Farhan Ali wrote:
> > >
> > >
> > > On 06/14/2018 04:21 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, Jun 13, 2018 at 07:28:08PM +0200, Halil Pasic wrote:
> > > > >
> > > > >
> > > > > On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
> > > > > > On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
> > > > > > > Hi Daniel
> > > > > > >
> > > > > > > On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > > > > > On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrot=
e:
> > > > > > > > > The virtio-crypto driver currently propagates to the gu=
est
> > > > > > > > > all the cipher algorithms that the backend cryptodev ca=
n
> > > > > > > > > support. But in certain cases where the guest has more
> > > > > > > > > performant mechanism to handle some algorithms, it woul=
d be
> > > > > > > > > useful to propagate only a subset of the algorithms.
> > > > > > > >
> > > > > > > > I'm not really convinced by this.
> > > > > > > >
> > > > > > > > The performance of crypto algorithms has many influencing
> > > > > > > > factors, making it pretty hard to decide which is best
> > > > > > > > without actively testing specific impls and comparing
> > > > > > > > them in a manner which matches the application usage
> > > > > > > > pattern. eg in theory the kernel crypto impl of an alg
> > > > > > > > is faster than a userspace impl, if the kernel uses
> > > > > > > > hardware accel and userspace does not. This, however,
> > > > > > > > ignores the overhead of the kernel/userspace switch.
> > > > > > > > The real world performance winner, thus depends on the
> > > > > > > > amount of data being processed in each operation. Some
> > > > > > > > times userspace can win & sometimes kernel space can
> > > > > > > > win. This is even more relevant to virtio-crypto as
> > > > > > > > it has more expensive context switches.
> > > > > > >
> > > > > > > True. But what if the guest can perform some crypto algorit=
hms
> > without a
> > > > > > > incurring a VM exit? For example in s390 we have the cpacf
> > instructions to
> > > > > > > perform crypto and this instruction is implemented for us b=
y our
> > hardware
> > > > > > > virtualization technology. In such a case it would be bette=
r not to use
> > > > > > > virtio-crypto's implementation of such a crypto algorithm.
> > > > > > >
> > > > > > > At the same time we would like to take advantage of virtio-=
crypto's
> > > > > > > acceleration capabilities for certain crypto algorithms for=
 which there
> > is
> > > > > > > no hardware assistance.
> > > > > >
> > > > > > IIUC, the kernel's crypto layer can support multiple implemen=
tations of
> > > > > > any algorithm. Providers can report a priority against implem=
entations
> > > > > > which influences which impl is used in practice. So if there'=
s a native
> > > > > > instruction for a partiuclar algorithm I would expect the imp=
l registered
> > > > > > for that to be designated higher priority than other impls, s=
o that it is
> > > > > > used in preference to other impls.
> > > > > >
> > > > >
> > > > > AFAIR the problem here is that in (the guest) kernel the virtio=
-crypto
> > > > > driver has to register it's crypto algo implementations with a =
priority
> > > > > (single number), which dictates if it's going to be the preferr=
ed (used)
> > > > > implementation of the algorithm or not. The virtio-crypto drive=
r does this
> > > > > without having information about the (comparative or absolute)
> > performance
> > > > > of it's implementation (which depends on the backend among othe=
rs). I
> > don't think
> > > > > any dynamic re-prioritization of the algorithms takes place (e.=
g. based on
> > how these
> > > > > perform in for the given configuration).
> > > > >
> > > > > I think the strategy of the virtio-crypto is to rather overstat=
e, than
> > > > > understate the performance of it's implementation. If we were t=
o 'be
> > > > > conservative' and say, 'hey we don't know nothing about the per=
formance,
> > > > > let's make it lowest priority implementation' the implementatio=
ns
> > provided
> > > > > by virtio-crypto would end up being used only if there is no ot=
her
> > > > > implementation. And that does not sound like a good idea either=
.
> > > >
> > > >
> > > > This problem you describe, however, is something that applies to =
*any*
> > > > kerenl code that is registering a crypto algo impl for accelerato=
r
> > > > hardware. A non-virtualized crypto cards in bare metal likewise c=
annot
> > > > assume that its AES impl is better then the host CPU's  aes-ni in=
struction.
> > > >
> > > > > So the idea is to give the user the power to effectively not pr=
ovide
> > > > > an algorithm via virtio-crypto. That is, if the user observes a=
 performance
> > > > > degradation because of virtio-crypto, he can turn off the bad a=
lgorithms
> > > > > at the device. That way overstatement becomes a much smaller pr=
oblem.
> > > > > The user can turn off the bad algorithms for reasons other than
> > performance
> > > > > too.
> > > > >
> > > > > Of course there are other ways to deal with the problem of virt=
io-crypto
> > > > > driver not knowing how good it's implementation of a given algo=
 is. We
> > > > > could make the in kernel crypto priorities dynamically adjustab=
le in
> > general
> > > > > or we could provide the user with means to specify the prioriti=
es (e.g.
> > > > > as module parameter) with which the virtio-crypto driver regist=
ers each
> > algo.
> > > > > Both of these would be knobs in the guest. It's hard to tell if=
 these first
> > > > > one would be useful in scenarios not involving virtualization. =
Same goes
> > > > > for some kind of dynamic priority management for crypto algorit=
hm
> > implementations
> > > > > in the Linux kernel. I assume the people involved with the resp=
ective
> > > > > subsystem do not see the necessity for something like that.
> > > >
> > > > It still feels like this is a problem for the guest OS to solve. =
If you
> > > > put a physical crypto accelerator in a bare metal machine, that h=
as the
> > > > same problem you describe here, so the kernel surely already need=
s to find
> > > > a viable solution for this problem.
> > > >
> > >
> > > How would the guest OS know which algo is better? As you mentioned =
it does
> > > depend on few factors and the best the kernel can do is use some so=
rt of
> > > heuristics. Such a solution might not be very dynamic and might not=
 work for
> > > all the cases for a user.
> >=20
> > Which is better will likely depend on the application using it. One m=
ight
> > be better for use by the kernel, while another is better for use by a
> > userspace application, or two userspace apps might have different
> > preferences.
> >=20
> > > Shouldn't we use virtualization to give us the flexibility that we =
don't
> > > have with physical crypto accelerator? The crypto accelerator might=
 not know
> > > if it's implementation is any better, but the user can experiment a=
nd see
> > > what works better.
> >=20
> > It is better to provide it all to the guest and let the guest decide =
which
> > is best to use.  If nothing else the virtio-crypto kernel module itse=
lf
> > can have module parameters to control the priority it gives to each
> > algorithm, or can avoid registering certain algorithms.  Doing it gue=
st
> > side is more flexible, because realistically many virt host deploymen=
ts
> > will never give the guest admin ability to control this from the host
> > side, so a guest kernel config ability will be the only thing availab=
le.
> >=20
>=20
> From the perspective of your communication and production deployment,=20
> I tend to agree with Daniel=E2=80=99s point of view. AFAICT DPDK crypto=
dev scheduler
> PMD driver did this thing:
>=20
> " Added a packet-size based distribution mode, which distributes the en=
queued
> Crypto operations among two slaves, based on their data lengths."
>=20
> Which it means that the guest's driver makes the decision.
>=20
> Currently the Linux crypto framework uses the static priority of one al=
go to decide=20
> to choose what is simply. Maybe it should add a scheduler layer too?

The simplest option would probably be either a kernel module parameter,
or even better, sysfs tunables, to allow the priorities to be set
dynamically

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLhqi-0001MZ-Qs
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 23:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLhqf-0007Lx-N6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 23:23:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLhqf-0007LJ-DZ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 23:23:01 -0400
Date: Fri, 16 Jun 2017 06:22:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170616061949-mutt-send-email-mst@kernel.org>
References: <593F8153.7080209@intel.com>
	<f8a64b2c-e769-4e9c-1cc6-ad31ea266010@redhat.com>
	<593F9187.6040800@intel.com>
	<9f196d71-f06b-7520-ca03-e94bf3b5a986@redhat.com>
	<593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59422E91.7080407@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v1] virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Thu, Jun 15, 2017 at 02:52:01PM +0800, Wei Wang wrote:
> On 06/15/2017 12:16 PM, Jason Wang wrote:
> >=20
> >=20
> > On 2017=E5=B9=B406=E6=9C=8814=E6=97=A5 23:22, Michael S. Tsirkin wrot=
e:
> > > On Wed, Jun 14, 2017 at 07:26:54PM +0800, Jason Wang wrote:
> > > >=20
> > > > On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 18:46, Jason Wang wrote:
> > > > >=20
> > > > > On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 17:50, Wei Wang wrote:
> > > > > > On 06/13/2017 05:04 PM, Jason Wang wrote:
> > > > > > >=20
> > > > > > > On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 15:17, Wei Wang wrot=
e:
> > > > > > > > On 06/13/2017 02:29 PM, Jason Wang wrote:
> > > > > > > > > The issue is what if there's a mismatch of
> > > > > > > > > max #sgs between qemu and
> > > > > > > > > > > > When the vhost backend is used, QEMU is not
> > > > > > > > > > > > involved in the data path.
> > > > > > > > > > > > The vhost backend
> > > > > > > > > > > > directly gets what is offered by
> > > > > > > > > > > > the guest from the vq. Why would
> > > > > > > > > > > > there be a mismatch of
> > > > > > > > > > > > max #sgs between QEMU and vhost, and what is
> > > > > > > > > > > > the QEMU side max #sgs
> > > > > > > > > > > > used for? Thanks.
> > > > > > > > > > > You need query the backend max #sgs in this case
> > > > > > > > > > > at least. no? If not
> > > > > > > > > > > how do you know the value is supported by the backe=
nd?
> > > > > > > > > > >=20
> > > > > > > > > > > Thanks
> > > > > > > > > > >=20
> > > > > > > > > > Here is my thought: vhost backend has already been
> > > > > > > > > > supporting 1024 sgs,
> > > > > > > > > > so I think it might not be necessary to query the
> > > > > > > > > > max sgs that the vhost
> > > > > > > > > > backend supports. In the setup phase, when QEMU
> > > > > > > > > > detects the backend is
> > > > > > > > > > vhost, it assumes 1024 max sgs is supported, instead
> > > > > > > > > > of giving an extra
> > > > > > > > > > call to query.
> > > > > > > > > We can probably assume vhost kernel supports up to 1024
> > > > > > > > > sgs. But how about for other vhost-user backends?
> > > > > > > > >=20
> > > > > > > > So far, I haven't seen any vhost backend implementation
> > > > > > > > supporting less than 1024 sgs.
> > > > > > > Since vhost-user is an open protocol we can not check each
> > > > > > > implementation (some may be even close sourced). For safety=
, we
> > > > > > > need an explicit clarification on this.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > And what you said here makes me ask one of
> > > > > > > > > my questions in the past:
> > > > > > > > >=20
> > > > > > > > > Do we have plan to extend 1024 to a larger value or 102=
4
> > > > > > > > > looks good for the future years? If we only care about
> > > > > > > > > 1024, there's even no need for a new config filed, a
> > > > > > > > > feature flag is more than enough. If we want to extend
> > > > > > > > > it to e.g 2048, we definitely need to query vhost
> > > > > > > > > backend's limit (even for vhost-kernel).
> > > > > > > > >=20
> > > > > > > > According to virtio spec (e.g. 2.4.4), unreasonably large
> > > > > > > > descriptors are
> > > > > > > > not encouraged to be used by the guest. If possible, I wo=
uld
> > > > > > > > suggest to use
> > > > > > > > 1024 as the largest number of descriptors that the guest =
can
> > > > > > > > chain, even when
> > > > > > > > we have larger queue size in the future. That is,
> > > > > > > > if (backend =3D=3D QEMU backend)
> > > > > > > >      config.max_chain_size =3D 1023 (defined by the qemu
> > > > > > > > backend implementation);
> > > > > > > > else if (backend =3D=3D vhost)
> > > > > > > >      config.max_chain_size =3D 1024;
> > > > > > > >=20
> > > > > > > > It is transparent to the guest. From the guest's point of
> > > > > > > > view, all it knows is a value
> > > > > > > > given to him via reading config.max_chain_size.
> > > > > > > So not transparent actually, guest at least guest need to s=
ee
> > > > > > > and check for this. So the question still, since you only c=
are
> > > > > > > about two cases in fact:
> > > > > > >=20
> > > > > > > - backend supports 1024
> > > > > > > - backend supports <1024 (qemu or whatever other backends)
> > > > > > >=20
> > > > > > > So it looks like a new feature flag is more than enough. If
> > > > > > > device(backends) support this feature, it can make sure 102=
4 sgs
> > > > > > > is supported?
> > > > > > >=20
> > > > > > That wouldn't be enough. For example, QEMU3.0 backend support=
s
> > > > > > max_chain_size=3D1023,
> > > > > > while QEMU4.0 backend supports max_chain_size=3D1021. How wou=
ld the
> > > > > > guest know
> > > > > > the max size with the same feature flag? Would it still chain=
 1023
> > > > > > descriptors with QEMU4.0?
> > > > > >=20
> > > > > > Best,
> > > > > > Wei
> > > > > I believe we won't go back to less than 1024 in the future. It =
may be
> > > > > worth to add a unittest for this to catch regression early.
> > > > >=20
> > > > > Thanks
> > > I think I disagree with that. Smaller pipes a better (e.g. less cac=
he
> > > pressure) and you only need huge pipes because host thread gets
> > > scheduled out for too long. With more CPUs there's less of a chance=
 of
> > > an overcommit so we'll be able to get by with smaller pipes in the
> > > future.
> >=20
> > Agree, but we are talking about the upper limit. Even if 1024 is
> > supported, small number of #sgs is still encouraged.
> >=20
> > >=20
> > > > Consider the queue size is 256 now, I think maybe we can first
> > > > make tx queue
> > > > size configurable up to 1024, and then do the #sg stuffs on top.
> > > >=20
> > > > What's your opinion, Michael?
> > > >=20
> > > > Thanks
> > > With a kernel backend, 1024 is problematic since we are then unable
> > > to add any entries or handle cases where an entry crosses an MR reg=
ion
> > > boundary. We could support up to 512 with a kernel backend but no o=
ne
> > > seems to want that :)
> >=20
> > Then I see issues with indirect descriptors.
> >=20
> > We try to allow up 1024 chained descriptors implicitly since
> > e0e9b406470b ("vhost: max s/g to match qemu"). If guest can submit
> > crossing MR descs, I'm afraid we've already had this bug since this
> > commit. And actually this seems conflict to what spec said in 2.4.5:
> >=20
> > """
> > The number of descriptors in the table is defined by the queue size f=
or
> > this virtqueue: this is the maximum possible descriptor chain length.
> > """
> >=20
> > Technically, we had the same issue for rx since we allow 1024 queue s=
ize
> > now.
> >=20
> > So actually, allowing the size to 1024 does not introduce any new
> > trouble?
> > >=20
> > > With vhost-user the backend might be able to handle that. So an
> > > acceptable option would be to allow 1K with vhost-user backends
> > > only, trim it back with other backends.
> > >=20
> >=20
> > I believe the idea is to clarify the maximum chain size instead of
> > having any assumption.
> >=20
> >=20
>=20
> I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
>=20
> For now, how about splitting it into two series of patches:
> 1) enable 1024 tx queue size for vhost-user, to let the users of vhost-=
user
> to easily use 1024 queue size.

Fine with me. 1) will get property from user but override it on
!vhost-user. Do we need a protocol flag? It seems prudent but we get
back to cross-version migration issues that are still pending solution.
Marc Andre, what's the status of that work?

> 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.

Rather, to support it for more backends.

> Best,
> Wei

--=20
MST

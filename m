Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0TfZ-0000tK-6W
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f0TfT-0007o3-Fs
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:04:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f0TfT-0007nh-65
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:04:15 -0400
Date: Mon, 26 Mar 2018 16:04:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180326150403.GN19266@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <5AAE4124.5010602@intel.com>
	<20180319062023-mutt-send-email-mst@kernel.org>
	<5AAF7C72.5070403@intel.com>
	<20180320004900-mutt-send-email-mst@kernel.org>
	<5AB06EE9.1030306@intel.com>
	<20180320045134-mutt-send-email-mst@kernel.org>
	<5AB07D7F.90205@intel.com>
	<20180320051840-mutt-send-email-mst@kernel.org>
	<20180326110904.GI19266@redhat.com>
	<286AC319A985734F985F78AFA26841F739485EE3@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F739485EE3@shsmsx102.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "quintela@redhat.com" <quintela@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>

On Mon, Mar 26, 2018 at 02:54:45PM +0000, Wang, Wei W wrote:
> On Monday, March 26, 2018 7:09 PM, Daniel P. Berrang=C3=A9 wrote:
> >=20
> > As far as libvirt is concerned there are three sets of threads it pro=
vides
> > control over
> >=20
> >  - vCPUs - each VCPU in KVM has a thread. Libvirt provides per-thread
> >    tunable control
> >=20
> >  - IOThreads - each named I/O thread can be associated with one or mo=
re
> >    devices. Libvirt provides per-thread tunable control.
> >=20
> >  - Emulator - any other QEMU thread which isn't an vCPU thread or IO =
thread
> >    gets called an emulator thread by libvirt. There is no-per thread
> >    tunable control - we can set tunables for entire set of emulator t=
hreads
> >    at once.
> >=20
>=20
>=20
> Hi Daniel,
> Thanks for sharing the details, they are very helpful. I still have a q=
uestion:
>=20
> There is no fundamental difference between iothread and our optimizatio=
n
> thread (it is similar to the migration thread, which is created when
> migration begins and terminated when migration is done) - both of them =
are
> pthreads and each has a name. Could we also add the similar per-thread
> tunable control in libvirt for such threads?
>=20
> For example, in QEMU we can add a new migration qmp command,
> migrate_enable_free_page_optimization (just like other commands
> migrate_set_speed 10G), this command will create the optimization threa=
d.
> In this way, creation of the thread is in libvirt's control, and libvir=
t
> can then support tuning the thread (e.g. pin it to any pCPU), right?

Anything is possible from a technical level, but from a design POV we
would rather not start exposing tunables for arbitrary device type specif=
ic
threads as they are inherantly non-portable and may not even exist in QEM=
U
long term as it is just an artifact of the current QEMU implementation.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

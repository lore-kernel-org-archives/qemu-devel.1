Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dcKlV-0007Vr-7N
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 20:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1dcKlR-0005qE-2z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 20:10:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:27322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1dcKlQ-0005nZ-RT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 20:10:21 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 1 Aug 2017 00:10:13 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B59DA96@SHSMSX103.ccr.corp.intel.com>
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
	<20170728103557.GB11097@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59D340@SHSMSX103.ccr.corp.intel.com>
	<20170731145141.GI11830@stefanha-x1.localdomain>
	<88704b75-74af-0fff-da0c-7a051185fd0e@redhat.com>
In-Reply-To: <88704b75-74af-0fff-da0c-7a051185fd0e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Monday, July 31, 2017 11:41 PM
> To: Stefan Hajnoczi <stefanha@redhat.com>; Liu, Changpeng
> <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; felipe@nutanix.com; mst@redhat.com; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Subject: Re: [PATCH 1/2] vhost-user-blk: introduce a new vhost-user-blk h=
ost
> device
>=20
> On 31/07/2017 16:51, Stefan Hajnoczi wrote:
> > typedef enum VhostUserRequest {
> >     ...
> >
> >     /* Submitted by the vhost-user master when the guest writes to
> >      * virtio config space and also after live migration on the
> >      * destination host.
> >      */
> >     VHOST_USER_SET_CONFIG,
> >
> >     /* Submitted by the vhost-user master to fetch the contents of the
> >      * virtio config space.  The vhost-user master may cache the
> >      * contents to avoid repeated VHOST_USER_GET_CONFIG calls.
> >      */
> >     VHOST_USER_GET_CONFIG,
> >
> >     ...
> > };
>=20
> Also:
>=20
> 	/* Submitted by the vhost-user master if it would like to
> 	 * be informed of virtio config space changes.   The slave
> 	 * signals the eventfd whenever config space is modified.
> 	 */
> 	VHOST_USER_SET_CONFIG_FD,
>=20
> Paolo
>=20
Thanks Stefan and Paolo, looks much cleaner now.
> > struct VuDev {
> >     ...
> >     int config_change_fd;
> >     ...
> > };

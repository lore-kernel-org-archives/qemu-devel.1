Received: from eggs.gnu.org ([2001:4830:134:3::10]:56564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcCpz-0002Oo-Hp
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcCpw-0005VM-Ck
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcCpw-0005Ug-6Z
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:42:28 -0400
References: <1501120851-4314-1-git-send-email-changpeng.liu@intel.com>
	<1501120851-4314-2-git-send-email-changpeng.liu@intel.com>
	<20170726103513.GB18489@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59C79E@SHSMSX103.ccr.corp.intel.com>
	<20170727094836.GB10129@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59CD56@SHSMSX103.ccr.corp.intel.com>
	<20170728103557.GB11097@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B59D340@SHSMSX103.ccr.corp.intel.com>
	<20170731145141.GI11830@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88704b75-74af-0fff-da0c-7a051185fd0e@redhat.com>
Date: Mon, 31 Jul 2017 17:41:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170731145141.GI11830@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@redhat.com>, "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "felipe@nutanix.com" <felipe@nutanix.com>, "mst@redhat.com" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 31/07/2017 16:51, Stefan Hajnoczi wrote:
> typedef enum VhostUserRequest {
>     ...
>=20
>     /* Submitted by the vhost-user master when the guest writes to
>      * virtio config space and also after live migration on the
>      * destination host.
>      */
>     VHOST_USER_SET_CONFIG,
>=20
>     /* Submitted by the vhost-user master to fetch the contents of the
>      * virtio config space.  The vhost-user master may cache the
>      * contents to avoid repeated VHOST_USER_GET_CONFIG calls.
>      */
>     VHOST_USER_GET_CONFIG,
>=20
>     ...
> };

Also:

	/* Submitted by the vhost-user master if it would like to
	 * be informed of virtio config space changes.   The slave
	 * signals the eventfd whenever config space is modified.
	 */
	VHOST_USER_SET_CONFIG_FD,

Paolo

> struct VuDev {
>     ...
>     int config_change_fd;
>     ...
> };

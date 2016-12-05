Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1cDvrZ-0000DG-GC
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aconole@redhat.com>) id 1cDvrW-0001O3-7r
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:11:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aconole@redhat.com>) id 1cDvrW-0001Ni-1e
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:11:30 -0500
From: Aaron Conole <aconole@redhat.com>
References: <20161130101017.13382-1-maxime.coquelin@redhat.com>
	<b4b08db5-6638-942f-4b0f-8aa3f093cb58@redhat.com>
	<ad8c2014-1bba-4042-29ed-919bc12a54d6@redhat.com>
	<20161130154119-mutt-send-email-mst@kernel.org>
Date: Mon, 05 Dec 2016 11:11:25 -0500
In-Reply-To: <20161130154119-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Wed, 30 Nov 2016 15:42:32 +0200")
Message-ID: <f7ta8cae4pe.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 0/3] virtio-net: Add support to MTU feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, fbl@redhat.com, berrange@redhat.com, mlureau@redhat.com, ktraynor@redhat.com, yuanhan.liu@linux.intel.com

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Nov 30, 2016 at 01:16:59PM +0100, Maxime Coquelin wrote:
>>=20
>>=20
>> On 11/30/2016 12:23 PM, Jason Wang wrote:
>> >=20
>> >=20
>> > On 2016=E5=B9=B411=E6=9C=8830=E6=97=A5 18:10, Maxime Coquelin wrote:
>> > > This series implements Virtio spec update from Aaron Conole which
>> > > defines a way for the host to expose its max MTU to the guest.
>> > >=20
>> > > This third version re-desings how MTU value is provided to QEMU.
>> > > Now, host_mtu parameter is added to provide QEMU with the MTU value,
>> > > and the backend, if supported, gets notified of the MTU value when t=
he
>> > > MTU feature neogotiation succeeds.
>> > >=20
>> > > Only user backend currently supports MTU notification. A new protocol
>> > > feature has been implemented for sending MTU value to the backend.
>> > > Aaron, Kevin, Flavio, do you confirm this works for OVS if DPDK vhos=
t lib
>> > > adds needed API to get the MTU value?
>> > >=20
>> > > For kernel backend, it is expected the management tool also configur=
es
>> > > the tap/macvtap interface with same MTU value.
>> > > Daniel, I would be interrested about your feedback on this implement=
ation
>> > > from management tool point of view.
>> >=20
>> > I believe we want management tool to configure both kernel and user
>> > backends.
>>=20
>> Yes, I think you are right.
>>=20
>> The vhost-user protocol feature would in this case be used to ensure
>> consistency.
>>=20
>> Does that make sense, or we should just drop VHOST_USER_SET_MTU?
>>=20
>> Thanks,
>> Maxime
>
>
> It doesn't hurt to have a feature and if set send mtu to backend,
> to verify that it can support that mtu.
> But we don't need to require that feature, if not supported
> we can just assume mtu is correct.

Sorry for late reply - I agree, this is fine.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fQdXl-0005CU-Kd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1fQdXh-00010X-NL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:52:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1fQdXh-00010A-HU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:52:21 -0400
Date: Wed, 6 Jun 2018 20:52:14 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20180606185214.GH6767@dnr>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<d61c88c7-0803-ba1c-08ab-fc668cffa40b@redhat.com>
	<8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <8e411566-1146-03a2-5372-8f8134ee0ce6@intel.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, qemu-devel@nongnu.org, laine@redhat.com, libvir-list@redhat.com


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 11:17:36AM -0700, Samudrala, Sridhar wrote:
>On 6/4/2018 7:06 PM, Jason Wang wrote:
>>
>>
>> On 2018=E5=B9=B406=E6=9C=8805=E6=97=A5 09:41, Samudrala, Sridhar wrote:
>>> Ping on this patch now that the kernel patches are accepted into
>>> davem's net-next tree.
>>> https://patchwork.ozlabs.org/cover/920005/
>>>
>>>
>>> On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
>>>> This feature bit can be used by hypervisor to indicate virtio_net
>>>> device to
>>>> act as a standby for another device with the same MAC address.
>>>>
>>>> I tested this with a small change to the patch to mark the STANDBY
>>>> feature 'true'
>>>> by default as i am using libvirt to start the VMs.
>>>> Is there a way to pass the newly added feature bit 'standby' to qemu
>>>> via libvirt
>>>> XML file?
>>>>
>>
>> Maybe you can try qemu command line passthrough:
>>
>> https://libvirt.org/drvqemu.html#qemucommand
>
>It looks like this can be used to pass command line arguments to qemu.
>Is it possible to specify a virtio specific attribute via this method?
>

Yes, for testing purposes you should be able to do this via using QEMU's
-set command line argument:
http://blog.vmsplice.net/2011/04/how-to-pass-qemu-command-line-options.html
i.e.:

<domain type=3D'kvm' xmlns:qemu=3D'http://libvirt.org/schemas/domain/qemu/1=
=2E0'>
  ...
  <qemu:commandline>
    <qemu:arg value=3D'-set'/>
    <qemu:arg value=3D'device.net0.standby=3Don'/>
  </qemu:commandline>
</domain>


>For ex: to say mrg_rxbuf is off we can add the following line to virtio
>section of the domain xml file.
>   <host mrg_rxbuf=3D'off'/>
>
>I think libvirt needs to be extended to to support the new 'standby' attri=
bute
>via this mechanism.
>Adding Liane Stump and libvirt to the CC list.

*Laine

>
>Michael,
>Can we start with getting this patch into Qemu and an update to libvirt to
>support the 'standby' feature so that this feature can be enabled via
>some scripts/orchestration layer for now.
>
>We could improve this solution by enhancing Qemu to do automatic managemen=
t of the
>addition/deletion of the primary device based on feature negotiation as a =
later patch.
>

If that means the libvirt attribute would no longer be needed, I don't
see the reason to add it to libvirt in the first place.

Jano

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEyAry0cRMFDoj9m/ZyvpdPXT/AmkFAlsYLVgACgkQyvpdPXT/
AmkqsBAA1U8EMjXoXpQlNvE2eXo0NoiVV8zC3VqYsa1wLmo2J7mfYWJ12p4yRk8D
CCUV/Mz9mpLz+dNH/nSy4fAlItSQNJA3rFTyPtedBPUjU1mxm9q+KUe0q3xhYoDc
BDXd7VA44DDPJQu3XtmBDpazWyWebQ3TXrm4OyQx51nmG0UWugoBIvdzZn8KxqdX
fsEAr01zuRWfsTUIsmpTKRqxtpySt3fXYJbquVOZVZS4kqml69ydpG+Iwg3fWn7Y
sIqMvQemdo96CQVXhRpPf7OFcsuqDITBtPnY5EzgO6xjb2klzL5J7JlXSSCkWrQK
zowABWYz6WNv9Y0JFM6mDdQX2vywPohBOk9rkynMnejq1IQI+lGBdPFre+pZESAY
k9TQ6kyAkIrgkn+ZheCmjdOm5aI360tVfyzl+iDymMU1UxCeIFXHxRHoJwK/7Xt/
wAKMnUDW1K50Vi0W26z+C2Ff2jYBJg4atQPHT5PJBpevwK0+xlE4GULNNJcnbCLL
rmASZpYe4f84jlVEyef9FftzSQVxFLdlDOxqP5KDhh6MMIhBnPacelktHM2Y73rq
qLnag3l0PnyMy9J9VCXysU730PQ5c/XU5uIBR1T3JUfDQLCiZK5Oba93FypGG7rV
X2xIomqFD0M03K5mGh3HvQ/PwQWnpB9SW1cAvgmUOvMxk1VUfik=
=uc2Q
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--

Received: from eggs.gnu.org ([209.51.188.92]:43197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1h1Ryr-0001Oo-N1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jtomko@redhat.com>) id 1h1Ryn-0003pQ-FD
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1h1Ryd-00024u-ON
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:32:37 -0500
Date: Wed, 6 Mar 2019 09:30:32 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Message-ID: <20190306083032.GZ1252@lpt>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
	<20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
	<81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
	<20190306074148.GA9131@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c1qHkdEbEbCG94PZ"
Content-Disposition: inline
In-Reply-To: <20190306074148.GA9131@angien.pipo.sk>
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, Reitz <mreitz@redhat.com>, Max@angien.pipo.sk, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>


--c1qHkdEbEbCG94PZ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 06, 2019 at 08:41:48AM +0100, Peter Krempa wrote:
>On Tue, Mar 05, 2019 at 16:56:43 +0100, Andrea Bolognani wrote:
>> On Tue, 2019-03-05 at 15:38 +0100, Gerd Hoffmann wrote:
>
>[...]
>
>> So I agree neither scenario is exactly perfect, but I still think
>> adding non-transitional alias devices would overall be more
>> user-friendly.
>
>I don't think it makes sense to add it at the qemu level. From libvirt's
>point of view users should be shielded from any qemu impl detail or
>inconsistency as libvirt is the 'user friendly'[1] layer. In qemu the
>devices would be the same and thus does not make sense to do that
>because it would be more confusing.
>
>You can argue that we should add the alias at the libvirt level though.
>

You can, but please don't.

Jano

>[1] Yes. I'm aware that statement is quite ironical.



>--
>libvir-list mailing list
>libvir-list@redhat.com
>https://www.redhat.com/mailman/listinfo/libvir-list


--c1qHkdEbEbCG94PZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAlx/hSQACgkQ+YPwO/Ma
t53bBgf/c8FfX1nYaC1Ul61vNKBg33x+gi7xLYAY9LYd33Uy/i+w/ddxqOEost18
VjO+vYXlK8U1rM5Erm+cJwgArqggbJtFcBSU9Tt45vcU/n6hWdJnN1XmLmGXhyiJ
37XNv4atm4bzGQI7Vcc5XCHmelUWnuDFu+lhZdM7ow3W7lVpG8huWeKaI3xTcwdu
UTP+NS3+JM8gHV9+MnVEESp30ktHbA6jLAuybxxg7qWz5w+h1cwNC6KyLABzda1k
zJICbVCYngaCsiXysrOtp3k0hGj1nu5dIGHTaSWeEtvdhm34paQWdXXYQyOEj0QO
GU3T9fTjjMHs8dH5dPWyo8rUtz9snw==
=Xg87
-----END PGP SIGNATURE-----

--c1qHkdEbEbCG94PZ--

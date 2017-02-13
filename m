Received: from eggs.gnu.org ([2001:4830:134:3::10]:56729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHSp-0008Mo-Ig
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHSm-0002HB-Bw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:18:47 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:35572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdHSm-0002Gt-4f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:18:44 -0500
Received: by mail-wj0-x241.google.com with SMTP id i7so210472wjf.2
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:18:44 -0800 (PST)
Date: Mon, 13 Feb 2017 14:18:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213141841.GH10361@stefanha-x1.localdomain>
References: <CABiB5K4pvPnNmi7q=e=PXaanMNq7QYrqZgdWLX4VRhqyR_k+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <CABiB5K4pvPnNmi7q=e=PXaanMNq7QYrqZgdWLX4VRhqyR_k+LQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Query for PCI burst support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gaurav Sharma <gauravs.2010@gmail.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2017 at 11:28:24AM +0530, Gaurav Sharma wrote:
> Is it possible to generate a PCIe burst of greater than 2dw for any MMIO.
> I see we have limit of max 2dw operation for any MemoryRegion defined by
> the max access size.

My understanding is that QEMU does not emulate bursts because it's a
functional simulator rather than low-level PCI bus transaction
simulator.

You might be interested in KVM's coalesced MMIO feature.  That is a
performance optimization but it's not PCI-specific.

Why are you trying to do PCIe bursts?

Stefan

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocBBAAoJEJykq7OBq3PImxoIALXfgbSe1AKBOcJrLMWgexIN
IVevpd2xrTeuLDOnWahycBeFq9kv4tvQgfczrgxPTuIK+tUMaqE6IvYmHwQA3+CR
8Bqfpy4N9ChE1kIQNIM/PZoyoEHK4sG9bcq+hwjoZgoBRu4mkrLa3SpSF/Cjz7mX
uiT2RP9y0Y/7p+DKveU+w55JT8rOnc8DIClvmiG3mP53DMOWVRDmJNExyv+xy8Cd
XcH/endSvmNRs+1GBKtrto6nAbDXPsu05xtV72FNBlw2Phcgqf/sk5LrJoJeZD6M
bg+kuXOdTeHyRTwsqGZEczIW4T/PztFsIYdxhL4jwzg9/0chrXCnFW9Tldccgnw=
=s8wm
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--

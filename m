Received: from eggs.gnu.org ([2001:4830:134:3::10]:60050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8Kw2-0006zM-FN
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8Kvz-0002Ji-Ai
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:21:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f8Kvz-0002JW-53
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:21:47 -0400
Date: Tue, 17 Apr 2018 15:21:34 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180417072134.GJ10770@stefanha-x1.localdomain>
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
	<1523861081-3600-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHh0aNzodMFDTGdO"
Content-Disposition: inline
In-Reply-To: <1523861081-3600-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13 1/3] net: Remove the deprecated
 "vlan" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>


--wHh0aNzodMFDTGdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 08:44:39AM +0200, Thomas Huth wrote:
> @@ -499,10 +497,11 @@
>  # @opts: device type specific properties (legacy)
>  #
>  # Since: 1.2
> +#
> +# 'vlan' - removed with 2.12

Not sure how to interpret this.  How about "removed in 2.13"?

> @@ -2028,10 +2028,9 @@ DEF("nic", HAS_ARG, QEMU_OPTION_nic,
>      "                provided a 'user' network connection)\n",
>      QEMU_ARCH_ALL)
>  DEF("net", HAS_ARG, QEMU_OPTION_net,
> -    "-net nic[,vlan=n][,netdev=nd][,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
> +    "-net nic[,macaddr=mac][,model=type][,name=str][,addr=str][,vectors=v]\n"
>      "                configure or create an on-board (or machine default) NIC and\n"
> -    "                connect it either to VLAN 'n' or the netdev 'nd' (for pluggable\n"
> -    "                NICs please use '-device devtype,netdev=nd' instead)\n"
> +    "                connect it to hub 0 (please use -nic for direct connections)\n"

What does "direct connections" means?

--wHh0aNzodMFDTGdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1aB9AAoJEJykq7OBq3PI1AQH/A7C7vDNS0aoXJT9LUh/Nxwd
GATRFq4YNrGmoE0zf44RfSxGgbhNg3vVjrBedjAWyXN4ZOt3VmGs7XOzZzFm4Y7Q
AvnKoQ9OwuAmoQ4KyknlEAv8ghdvEwhYm/2CLLrXd79s4eTHvxD/mHL95Hr1JAEP
OLDA78JxZ9niSO10iFPJUsYhATvtWkiS6+FrbeQdrPDk1/jT5IEF0iMXjCIHpyMT
Sbgym1s9hrBtdSoLwRle9PHWGpND48aBlW449RNBUMf94e0wLYCEYOTCU89Tkmz6
aWnN3zD561Z90Efe0zuZhJdsTrcT0AvoJQN+/DpRZ9cWsG87hbTl5s9Z/u9Y8PY=
=agMH
-----END PGP SIGNATURE-----

--wHh0aNzodMFDTGdO--

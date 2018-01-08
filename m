Received: from eggs.gnu.org ([2001:4830:134:3::10]:54189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYY8b-0002sp-UN
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYY8a-0003ms-VE
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:10:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104192203.GD3407@localhost.localdomain>
	<20180108135122.637e478a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <395b6cff-e4be-1aa9-48f6-82cdbd9633b9@amsat.org>
Date: Mon, 8 Jan 2018 11:10:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180108135122.637e478a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="dZsytMtnsZH8ATGxOKZhCx7crUVN01M66"
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] qom: introduce TypeInfo name
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dZsytMtnsZH8ATGxOKZhCx7crUVN01M66
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <395b6cff-e4be-1aa9-48f6-82cdbd9633b9@amsat.org>
Subject: Re: [RFC PATCH 0/6] qom: introduce TypeInfo name aliases
References: <20180104144046.30793-1-f4bug@amsat.org>
 <20180104192203.GD3407@localhost.localdomain>
 <20180108135122.637e478a@redhat.com>
In-Reply-To: <20180108135122.637e478a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On 01/08/2018 09:51 AM, Igor Mammedov wrote:
[...]
> Though it seems easy and trivial, I'm a bit concerned about using
> QOM types for the task though.
> Also see commit 6acbe4c6f which labels aliases as a bad idea
> and says that they are there only for compatibility and shouldn't
> be used.
> So far I agree with that statement, because it introduces
> ambiguity in code used internally and more worrying is that
> this ambiguity will increase user visible ABI (think of '-device_add FO=
O_ALIAS')
> that we would need to maintain afterwards.
> It would be nice to have unified alias API, but I think it should
> be separate one and limited to the same scope (i.e. compat stuff),
> and even that won't be easy as different alias impl. we have now
> have a different needs.
>=20
> wrt this series targeted usage, I'd prefer that object_new/initialize
> would use real type names when creating devices as it does currently
>=20
> FDT linux guest specific names wouldn't seep into device model
> itself. Firmware (FDT or ACPI) should be separate from device
> implementation.

Good point.

> If really there is need to dynamically scan present devices
> and build FDT from result, then probably we should introduce
> interface that devices could implement if necessary.
> (I was thinking about such possibility for ACPI). But so far
> it looked to me as too much overhead for what we do now.

I see, I thought about something similar but TypeInfo.aliases was way
too simple to not try this series first.

What about adding a INTERFACE_FDT_DEVICE type (InterfaceInfo) and let
the FDT devices implement something such:

typedef struct {
    /*< private >*/
    InterfaceClass parent_class;
    DeviceClass parent_class;
    /*< public >*/
    bool (*is_alias)(FDTDeviceIf *dev, const char *name);
    bool (*set_prop...)(FDTDeviceIf *dev, const char *property, ...);
    const void *(*get_prop)(FDTDeviceIf *dev, const char *property);
};

Regards,

Phil.


--dZsytMtnsZH8ATGxOKZhCx7crUVN01M66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpTe90ACgkQ4+MsLN6t
wN5P2w//XjDzG8Twarkl//admIQI6M4zmr13Dw0/4Vo63Tlh8n5RW5zoSQy4X6mg
1kvOYyfN/BOf6fr7gBs72iPfcrz29XQrPWzcE3WCFpnjtnQsLj/TQ6Rx/HA8/nJK
oNFk6rhUPTzW9j+7C5Vt4gCzM6dB6przehX5PY9cxvtVSxRdsd2AgoeO4XxnhAli
nnrwYTW/dOqLVJuB0PSd/si6+VsTkJ73AOo3WtesjRG6xEM0HTTEw1QgpzsN0kdX
3B8HN3dL8fp2pzj4L6bTbL7IW4hvblwV/nmnjWtAN29ZA1DYJOfKj9BBsGzpn+zG
5hmxsULsddulF8V7XAdTMJWipuIr6ncIJ91ZRTqpoDLFK/MaAsOfvRbgo83cLcCH
A2te74Sb0uD8vS1UgXm2dQfOrJnFotuThugrvzuOqfWl79fi7OMVec5+fYwixC9R
51Iircw30Fi4KABb7Ffu4CSVs4dWuf5smvrwUvfQdM3Ix3OUpNTghuxn7mUVYoN9
WJmFzKIV2p0+a3C20L7aGZ8d2bEjhQSpPkn407R4lI4YROQ6TIwVApMsC5HsBvXn
XTDkRsCXZNyveHuwG5+ZjP+ECSc6Eq6qxEvWvXqcw7Xt+KPBaGbmRLzT0JiM8lK9
GQQYCTwQx6JwpuoSvCpggQ54ea/exqNHddbD4GAJZ6RHd2BphCc=
=C3GQ
-----END PGP SIGNATURE-----

--dZsytMtnsZH8ATGxOKZhCx7crUVN01M66--

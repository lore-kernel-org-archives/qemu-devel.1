Received: from eggs.gnu.org ([2001:4830:134:3::10]:44424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1IhH-0007Pe-Sc
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1IhG-0002J9-RZ
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:28:59 -0400
References: <20170419222258.13415-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fdc51365-3006-18d1-96eb-4834e8cac002@redhat.com>
Date: Thu, 20 Apr 2017 15:28:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170419222258.13415-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rBrcRnlV50apGaIkc3KGProSE0TetEuNj"
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, Alistair Francis <alistair.francis@xilinx.com>, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rBrcRnlV50apGaIkc3KGProSE0TetEuNj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring
 <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "open list:Calxeda Highbank" <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Cornelia Huck <cornelia.huck@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <fdc51365-3006-18d1-96eb-4834e8cac002@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] event: Add source information to SHUTDOWN
References: <20170419222258.13415-1-eblake@redhat.com>
In-Reply-To: <20170419222258.13415-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2017 05:22 PM, Eric Blake wrote:
> Libvirt would like to be able to distinguish between a SHUTDOWN
> event triggered solely by guest request and one triggered by a
> SIGTERM or other action on the host.  qemu_kill_report() is
> already able to tell whether a shutdown was triggered by a host
> signal (but NOT by a host UI event, such as clicking the X on
> the window), but that information was then lost after being
> printed to stderr.
>=20
> Enhance the shutdown request path to take a parameter of which
> way it is being triggered, and update ALL callers.  It would have
> been less churn to keep the common case with no arguments as
> meaning guest-triggered, and only modified the host-triggered
> code paths, via a wrapper function, but then we'd still have to
> audit that I didn't miss any host-triggered spots; changing the
> signature forces us to double-check that I correctly categorized
> all callers.
>=20
> Here is output from 'virsh qemu-monitor-event --loop' with the
> patch installed:
>=20
> event SHUTDOWN at 1492639680.731251 for domain fedora_13: {"guest":true=
}
> event STOP at 1492639680.732116 for domain fedora_13: <null>
> event SHUTDOWN at 1492639680.732830 for domain fedora_13: {"guest":fals=
e}

Another reason I'll need a v3: at least qemu-iotests 87 has to be
updated for new expected output.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rBrcRnlV50apGaIkc3KGProSE0TetEuNj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+RneAAoJEKeha0olJ0NqbaQH/3QPSDMwQQPP++YfbHSPpWhQ
H/XceYryP1bFidJ1BOtcmM5w4BSHqjPXCALbq+bF4Z9A9WsY4ffxdxvWDUpH71Z1
qAQuTgUUEM+LFpKMlV8WMjulmmQbHVKjURtzIjtuQluK/RtZ8m8/5NtAMvFXH1QO
YmWmMrQOZrRkJ89/e6yo1QQ5Xuro8Sd9nWeI3uvhBGCs2/kyOD2wt5M3l+zMDV22
wQ2pE3aKn3emZv5yqThOe69gSisiOyPt9xPysQmII+08Ni/smAuQo2kkZAqTF76q
yhMygaDft61exPOi81wVCynFpeii3MiDHdleLW71F+iZIOmonZl29rkr3Yj7tpw=
=8Anw
-----END PGP SIGNATURE-----

--rBrcRnlV50apGaIkc3KGProSE0TetEuNj--

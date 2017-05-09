Received: from eggs.gnu.org ([2001:4830:134:3::10]:40838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d85nv-0004Y4-Ah
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d85ns-0008NA-22
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:07:55 -0400
References: <20170508211953.28017-1-eblake@redhat.com>
	<20170508211953.28017-4-eblake@redhat.com>
	<87inlap7k1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81782139-d66d-72d4-c228-9dd9073a33b9@redhat.com>
Date: Tue, 9 May 2017 09:07:26 -0500
MIME-Version: 1.0
In-Reply-To: <87inlap7k1.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SDeGOvGBIsueVrhobMIU2OhkcpkGsK3W9"
Subject: Re: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:Overall" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, Yongbok Kim <yongbok.kim@imgtec.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>, alistair.francis@xilinx.com, "open list:Calxeda Highbank" <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <"corneli a.huck"@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, "open list:Old World" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SDeGOvGBIsueVrhobMIU2OhkcpkGsK3W9
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "open list:Overall" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alexander Graf <agraf@suse.de>, Yongbok Kim <yongbok.kim@imgtec.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring
 <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 alistair.francis@xilinx.com, "open list:Calxeda Highbank"
 <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Cornelia Huck <"corneli a.huck"@de.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Burton <paul.burton@imgtec.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:Old World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <81782139-d66d-72d4-c228-9dd9073a33b9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/5] shutdown: Add source information to
 SHUTDOWN and RESET
References: <20170508211953.28017-1-eblake@redhat.com>
 <20170508211953.28017-4-eblake@redhat.com>
 <87inlap7k1.fsf@dusky.pond.sub.org>
In-Reply-To: <87inlap7k1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 06:56 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Time to wire up all the call sites that request a shutdown or
>> reset to use the enum added in the previous patch.
>>
>> It would have been less churn to keep the common case with no
>> arguments as meaning guest-triggered, and only modified the
>> host-triggered code paths, via a wrapper function, but then we'd
>> still have to audit that I didn't miss any host-triggered spots;
>> changing the signature forces us to double-check that I correctly
>> categorized all callers.
>>
>> Since command line options can change whether a guest reset request
>> causes an actual reset vs. a shutdown, it's easy to also add the
>> information to reset requests.
>>
>> Replay adds a FIXME to preserve the cause across the replay stream,
>> that will be tackled in the next patch.
>>

>> @@ -569,7 +569,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint1=
6_t val)
>>          default:
>>              if (sus_typ =3D=3D ar->pm1.cnt.s4_val) { /* S4 request */=

>>                  qapi_event_send_suspend_disk(&error_abort);
>> -                qemu_system_shutdown_request();
>> +                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHU=
TDOWN);
>=20
> I'm fine with using SHUTDOWN_CAUSE_GUEST_SHUTDOWN for suspend, but have=

> you considered SHUTDOWN_CAUSE_GUEST_SUSPEND?

It was easy to do
s/qemu_system_shutdown_request()/qemu_system_shutdown_request(SHUTDOWN_CA=
USE_GUEST_SHUTDOWN)/
for all hw/ files.  Harder would be picking a difference between
_SHUTDOWN and a new _SUSPEND. I can do it if hardware owners want the
distinction; but remember that this series will intentionally NOT expose
that distinction to QMP, so I don't know how much it will buy us.


>>  void qmp_stop(Error **errp)
>> @@ -105,7 +105,7 @@ void qmp_stop(Error **errp)
>>
>>  void qmp_system_reset(Error **errp)
>>  {
>> -    qemu_system_reset_request();
>> +    qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP);
>=20
> This is the only place where we pass something other than
> SHUTDOWN_CAUSE_GUEST_RESET.  We could avoid churn the obvious way, but =
I
> guess having the churn eases patch review.  Okay.

Yes, and that was the comment I made in the commit message about
changing the signature everywhere instead of adding wrappers that make
the common case become the default.


>> +++ b/replay/replay.c
>> @@ -51,7 +51,8 @@ bool replay_next_event_is(int event)
>>          switch (replay_state.data_kind) {
>>          case EVENT_SHUTDOWN:
>>              replay_finish_event();
>> -            qemu_system_shutdown_request();
>> +            /* FIXME - store actual reason */
>> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
>=20
> The temporary replay breakage is no big deal.  Still, can we avoid it b=
y
> extending replay first, using a dummy value like
> SHUTDOWN_CAUSE_HOST_ERROR until the real cause becomes available?  Not
> sure it's worth a respin, though.
>=20
>>              break;
>>          default:
>>              /* clock, time_t, checkpoint and other events */
> [...]
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SDeGOvGBIsueVrhobMIU2OhkcpkGsK3W9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEc0fAAoJEKeha0olJ0NqgSYH/i+v6CJcwzlmUHcGVg6DcqRO
tRa/xL25R5FrC+HOREOYVvVkukTZcEsA/ai2nACEi1upKF8IWHFzRjc/6XolbHWl
vHKmcF7n9BcNZi8dqRu3abstD3bcNIiGexPEYTptFaMFiXQq96lHz7R68Ht59bI/
12LEVwf0VAvN+DGm/+9xNGgszRc/Yd6JenZJ4+VbPwJzubU4XVCX5tTSvRt7dfrZ
ZVOAT52aX46iN5C+awgEYAy1hE1GojIEm4yy6PEBDcPw6twodOLYDg4vwAxqbvcK
HVtxkc5Xa1E3WsxjwT1QFos6LGWrlZx8ZMS1y0BlsygxQ/nGEIkb0TwbJqHdKTY=
=fwyb
-----END PGP SIGNATURE-----

--SDeGOvGBIsueVrhobMIU2OhkcpkGsK3W9--

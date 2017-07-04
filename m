Received: from eggs.gnu.org ([2001:4830:134:3::10]:37101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNZp-0006WT-SP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNZl-0006uE-6x
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:09:13 -0400
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
	<20170704114151.GG2180@umbus.fritz.box>
	<20170704150239.2e4adb64@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6e5799ff-e6f6-ed88-8079-489658427033@redhat.com>
Date: Tue, 4 Jul 2017 15:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170704150239.2e4adb64@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tcUWWmbc8nMVebDnT5NLjooV0DDKj2F0L"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcUWWmbc8nMVebDnT5NLjooV0DDKj2F0L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.2017 15:02, Greg Kurz wrote:
> On Tue, 4 Jul 2017 21:41:51 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> On Tue, Jul 04, 2017 at 01:15:00PM +0200, Greg Kurz wrote:
>>> On Tue,  4 Jul 2017 13:01:26 +0200
>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>  =20
>>>> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
>>>> disables compatibility mode for POWER9 DD1 to allow to
>>>> boot on POWER9 DD1 host with KVM.
>>>>
>>>> As the workaround has been added in kvmppc_host_cpu_class_init(),
>>>> it applies only on CPU created with "-cpu host".
>>>> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
>>>> host, this patch moves the workaround from kvmppc_host_cpu_class_ini=
t()
>>>> to init_proc_POWER9().
>>>>  =20
>>>
>>> As with ppc_cpu_initfn() in your previous version, init_proc_POWER9()=
 is
>>> called for every CPU instance.. ie, all CPU will adjust the @pcr_supp=
orted
>>> class attribute... =20
>>
>> Ah.. yeah.. I didn't notice that before.  That's definitely not right.=


It's a hack for DD1 which will likely be removed soon again anyway (as
soon as the DD1 hardware is not in use anymore), so I think it's ok for
such a temporary solution?

>>> What about moving the workaround to ppc_POWER9_cpu_family_class_init(=
)
>>> instead ? This would just require to expose mfpvr() in some header.  =

>>
>> Yeah, as someone else pointed out using the host PVR is also
>> definitely not right (unless you're in a function specifically
>> connected to the host cpu class).
>>
>=20
> I agree but the root issue is that we accept to pass -cpu POWER9 instea=
d of
> -cpu host with -enable-kvm. And the host cpu class isn't involved in th=
is
> case.

Allowing -cpu POWERx with -enable-kvm was likely a bad idea, but we've
agree with libvirt that we support this, so we can't revert this feature
so easily without changing libvirt first.

 Thomas


--tcUWWmbc8nMVebDnT5NLjooV0DDKj2F0L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZW5NwAAoJEC7Z13T+cC21PfYP/iL0mxRKWAkdNRB5qpZinZSo
CRk4gmjr0Y/jnm67BZXoWIuuS5MUqJmc/0NhoFWYtewhddz61NHgQ1PgcXaME0Os
noAWKgUWNNSu3V2cSMZJlBtOe4dU8HSMv4I3CBGp/fdfEcsfdlQNr7gL+RvvszGz
BiF+7Tcard40qnA5aj7eSk7HhUz7PryQ1sCMU9Hdj4OAvc7GtSNd9C2AnMJGce4w
rWlRukzYGsyjAhY7HFUgYXRQ425aiAeRsTAdP4Ctj5GIjBEUsqtSgTk5v/isOJ+a
F0BmZOZb0At9y2U7pFIku1nBa6bL9OC3jcX/8pUq+z4InJA98xbhBYr/U3t+jays
2221cT18ZM1LhPMpkd4en4lPljNtpXYkZiXghZJcb4USNIVMDp6DbwWM2d6um6bq
tgPYpxvWx+CdC3TitdVUsX+hIUnpjnyxVkQWNc72gzsXLKztsChehd2hJozZEHH1
ev7VUvd+7u05PlzYkGBoOMj07Tal49ejh5b+WNeK9SB8hDd8Eu69yDgjjuz9mlAs
mareuUgyEsC6HrjHpTpofrKPj1zGaED8T+YKDKlduFLq0VdIw74uaq5L9Nl+OZWE
MFSNAUyuLNIvCu3rhpm6pmGdBpVjYZH2gR+9AXhpoVvBUTVIDQlZBIy/QALBxtm3
4Bi+ogwba5IqEow8Xiah
=H0/B
-----END PGP SIGNATURE-----

--tcUWWmbc8nMVebDnT5NLjooV0DDKj2F0L--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSfAp-0006TR-6K
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSfAk-0007uq-Jo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:56:35 -0400
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
	<20170704114151.GG2180@umbus.fritz.box>
	<20170704150239.2e4adb64@bahia.lan>
	<20170705063641.GK2180@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <41cfc821-c7f8-0c3d-3bc8-d2877ac5db04@redhat.com>
Date: Wed, 5 Jul 2017 09:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170705063641.GK2180@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9t6BAhdqNS2ka9cv8JveukwDLP9PHBqNL"
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
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9t6BAhdqNS2ka9cv8JveukwDLP9PHBqNL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.07.2017 08:36, David Gibson wrote:
> On Tue, Jul 04, 2017 at 03:02:39PM +0200, Greg Kurz wrote:
>> On Tue, 4 Jul 2017 21:41:51 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> On Tue, Jul 04, 2017 at 01:15:00PM +0200, Greg Kurz wrote:
>>>> On Tue,  4 Jul 2017 13:01:26 +0200
>>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>>  =20
>>>>> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
>>>>> disables compatibility mode for POWER9 DD1 to allow to
>>>>> boot on POWER9 DD1 host with KVM.
>>>>>
>>>>> As the workaround has been added in kvmppc_host_cpu_class_init(),
>>>>> it applies only on CPU created with "-cpu host".
>>>>> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
>>>>> host, this patch moves the workaround from kvmppc_host_cpu_class_in=
it()
>>>>> to init_proc_POWER9().
>>>>>  =20
>>>>
>>>> As with ppc_cpu_initfn() in your previous version, init_proc_POWER9(=
) is
>>>> called for every CPU instance.. ie, all CPU will adjust the @pcr_sup=
ported
>>>> class attribute... =20
>>>
>>> Ah.. yeah.. I didn't notice that before.  That's definitely not right=
=2E
>>>
>>>> What about moving the workaround to ppc_POWER9_cpu_family_class_init=
()
>>>> instead ? This would just require to expose mfpvr() in some header. =
=20
>>>
>>> Yeah, as someone else pointed out using the host PVR is also
>>> definitely not right (unless you're in a function specifically
>>> connected to the host cpu class).
>>>
>>
>> I agree but the root issue is that we accept to pass -cpu POWER9 inste=
ad of
>> -cpu host with -enable-kvm. And the host cpu class isn't involved in t=
his
>> case.
>=20
> Well.. it sort of is.  I believe the way we make this work (since
> Thomas' cleanup) is that when KVM is active, we alter the alias for
> the host cpu's family to point to the host cpu class, instead of
> whatever specific version it usually points to.

Right, it's the code at the and of the kvm_ppc_register_host_cpu_type()
function. Maybe that function could also be a good spot to move the DD1
workaround into (just a quick idea, I haven't checked whether it's
feasible)?

 Thomas


--9t6BAhdqNS2ka9cv8JveukwDLP9PHBqNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZXJuqAAoJEC7Z13T+cC21b2kP/Rdnp+XmNEHlgaGqwB7RkhnF
Cp6xs2XQn+gPSPLyDc7kCTA3NphSXsehB+Kq9L56KG7K6lTxSSn5dahyZAa+Xwhe
0i4GK5Q07Ju3YVik2U+lQixziiyNwqex/2Gb3AqrqvT1PRHaEDy/zM9IqQbjUw8t
ODCPDWxdPaP0oCLGtSlerRGhomKLdIAZxJWGfwZQUcoVyLi4G8heH0+/157emiuW
AfEk0vePnW50IffGjnOWWBhFrV1lRvS92VW5OJ3ARQAYk9+tNsiwfwr2VrURHD6g
ygPWNzIQu7mgBu4PGIFp35COYCALF3rVqA22T6O6yzDZDqwHV4V6F8ZFpqE9YH7N
vWnMv1tzT1J3A+mVWUX4c6HOF/6FzkrNLzdkwhhm5bsv4cxbmveCkO0q1premp/V
kOqu0SW/6GLXYD/mkysSUiNIw7qacfXjiwY/lY0OqpqgVBD29sGGB8mWqamoiyaj
I5r2YIWfKUqCqFqghw8jGHWeyjdj1WWFmiI3GhZsZJnu5JWQL3GKi+EjMw2+fzP5
nAHM8jD89nd51HpnccYp/IywHr+y6FvjF7tdL5asUy8usjDJ54LCPqu1lfqtrmsi
Yo+2fTUnB2TQ8onJT2wDkW9LHrR1w+AVKIka/kkgy/1XYw31zHF5ijAMx/XkWXsc
KTJ1tvgXRardRs7azr1m
=V9fp
-----END PGP SIGNATURE-----

--9t6BAhdqNS2ka9cv8JveukwDLP9PHBqNL--

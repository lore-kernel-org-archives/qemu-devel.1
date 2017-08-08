Received: from eggs.gnu.org ([2001:4830:134:3::10]:36317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1df4qK-00037m-VQ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1df4qF-0003zl-VB
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:46:45 -0400
Date: Tue, 8 Aug 2017 16:45:44 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170808134544.paekftiounmirhbo@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gaxekyluahptihdx"
Content-Disposition: inline
In-Reply-To: <w51valyjj7j.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--gaxekyluahptihdx
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 03:13:36PM +0200, Alberto Garcia wrote:
>On Mon 31 Jul 2017 11:54:41 AM CEST, Manos Pitsidianakis wrote:
>> block/throttle.c uses existing I/O throttle infrastructure inside a
>> block filter driver. I/O operations are intercepted in the filter's
>> read/write coroutines, and referred to block/throttle-groups.c
>>
>> The driver can be used with the syntax
>> -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>         limits.iops-total=3D...,throttle-group=3Dbar
>
>Sorry for not having noticed this earlier, but can't you define the
>throttling group (and its limits) using -object throttle-group ... as
>shown in the previous patch, and simply reference it here? Or would we
>have two alternative ways of setting the throttling limits?
>
>What happens if you have many -drive lines each one with a different set
>of limits but with the same throttling group?

The limits of the last one to be processed will win. Quoting a reply I=20
made to Kevin on the interface test patch:

>> You're right, I missed this. The test result shows that this command
>> succeeds. Do we really want to allow other nodes to be affected with a
>> blockdev-add? Wouldn't it be cleaner to just forbid the combination of
>> limits and throtte-group?
>
>So basically only anonymous, immutable groups can be created through the=
=20
>driver then. All other shared group configurations must be explicitly=20
>created with an -object / object-add syntax. I think this is a neat=20
>separation and compromise if we allow anonymous groups. If not, we can=20
>ignore limits on the throttle driver.

So basically if we have anonymous groups, we accept limits in the driver=20
options but only without a group-name. Without anonymous groups, we=20
remove limits from the driver options and only use the=20
object-add/-object commands to create throttle groups. Does this sound=20
like a good idea? It will be more verbose for the human user. One=20
advantage: all throttle groups can then be managed through=20
qom-set/qom-get since they are owned by the qom tree.

--gaxekyluahptihdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmJwIgACgkQc2J8L2kN
9xBUag/+PssQhcKSQnAotJQGaL+LX9EWjsxx+uOa5WBayYMMQ5R+pAP/4CuMrvDV
RtEZdt1Pbp+hc5IcTCp8vbIc7iC8tVV0eVn+dzWnjI5yXEqTzyLqgoyVCbQ1MLVX
buDyLLHI3nofYgHnPsVtI8XuwUQIp56aQ/Pu/PsAtD5fiS8YdmNtI666wQ+Vwj/9
b+J5pO50BtIrh4v4z18a8DyqMzsdGmzBF+egWakMFmFniOFAV6nRZD8p8bGhotkY
+wT/xko2oqlyds8nZeINh1ciO2/URwi9bX8trVhBlhoZdZ6WKjkCz0+4213bCjgR
2bi/23hfJbGKXdKB+w2xUuMZTtShzemB8hG2+7RbcqCsaNuLDTslxqL4wZeNO9GV
fOdHElmbMhgIJTkETzTF5ktudkzyJlk+1sLbxa8cOCFWS6T2pmmKVGYItbtolbEq
KHDEzXZzN8jGoT869PseVwj4Nkrx7MaKGQ0t8tR0C1B4spMtQ33LL0Hs8JgjE7cZ
s9b1z/rYWxnXAtXy7Qsa3f7Qh2LmvPOSLHKwSr09XzJAVNDaCNWMD1zJkB9Y1SY3
g5LlW3KBXdXmWHguAUVhWiVT+XRWuwUlSGTE15+9MBALnXgwIytMJkGP+Ukm1oqB
IkLj9wDXn82ic6qWePlnrdC5ZNkOV4/NFtHKBQN+vtdqiKXRlZQ=
=5BWh
-----END PGP SIGNATURE-----

--gaxekyluahptihdx--

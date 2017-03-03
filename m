Received: from eggs.gnu.org ([2001:4830:134:3::10]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjpeN-0003yQ-3n
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjpeG-0007pH-VL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:01:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjpeG-0007p5-Mc
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:01:40 -0500
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
	<87h93ascc0.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <020947c3-249c-8ea7-d454-76539ec0b22f@redhat.com>
Date: Fri, 3 Mar 2017 10:01:35 -0600
MIME-Version: 1.0
In-Reply-To: <87h93ascc0.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6VCIlHREqTwiJFWP2CDh8q3BdNKqx4St2"
Subject: Re: [Qemu-devel] [PATCH V8 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Stefano Stabellini <sstabellini@kernel.org>, Wen Congyang <wencongyang@gmail.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6VCIlHREqTwiJFWP2CDh8q3BdNKqx4St2
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 qemu devel <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Wen Congyang <wencongyang@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <020947c3-249c-8ea7-d454-76539ec0b22f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V8 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
 <87h93ascc0.fsf@dusky.pond.sub.org>
In-Reply-To: <87h93ascc0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 07:45 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/23/2017 01:14 AM, Zhang Chen wrote:
>>> We can call this qmp command to do checkpoint outside of qemu.
>>> Xen colo will need this function.
>>>
>>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> You made a substantial change to this patch since v7 in response to my=

>> comments; when you do that, it's best to remove the R-b to make sure I=

>> re-review the changes and am still happy with them.
>>

>>> +# @ReplicationStatus:
>>> +#
>>> +# The result format for 'query-xen-replication-status'.
>>> +#
>>> +# @status: true to error, false to normal.
>>
>> This is now a poor name for the parameter.  Please rename it; probably=

>> to @error (if you want to keep true meaning a problem has been
>> detected), or to @okay (if you want to invert the sense, and @desc is
>> only present when @okay is false).
>=20
> We could replace both members by '*error': 'str', present exactly when
> status is "bad".
>=20
>>> +#
>>> +# @desc: #optional the human readable error description string, when=

>>> +#        @status is 'true'.
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'struct': 'ReplicationStatus',
>>> +  'data': { 'status': 'bool', '*desc': 'str' } }

Except that ReplicationStatus would then be the empty struct on success.
 I guess that's okay, but seems a bit odd.


>>> +# Example:
>>> +#
>>> +# -> { "execute": "query-xen-replication-status" }
>>> +# <- { "return": { "status": "normal" } }
>>
>> This example is now wrong.
>>
>> You'll need a v9.

which has already been submitted and turned into a pull request:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg07652.html

It pre-dated your mandate of "all new QMP commands must have a test":
https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html

but the idea is still relevant, so a followup patch for 2.9 that adds
testsuite coverage of the new commands is appropriate during soft freeze.=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6VCIlHREqTwiJFWP2CDh8q3BdNKqx4St2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuZNfAAoJEKeha0olJ0Nqni0H/2NLMJVXfdgTi9ezceTiv8gw
Ao5kIOrsh2kd1LzkZDSN85ddpTGTAAB+ZphTkB6FqGL3540Lnc6RMZwsSdznYLDg
64ZM5vS8gVmx0bhyVb8jC2dwOptEuZuHh2qUnEAsKiRNBQk7SgOjxS9Yq571NEy8
pkIZYpLAo9A1ENxUkIvb71Lq+CVevObW9SbN+3gITg4affXt3khpzTT8epQzAp3l
r14n51ZIdbvJqgcpwAE/+1e4dSbmZo2ac1cg53lymDmJTovWlre7wn7M97A9T+Ho
Hd8IeVponAG1yel9gFNNOMn6s6HC3WaZgZ/oBmEf6trE2sL06frHIvhsI8MHF2A=
=sBxs
-----END PGP SIGNATURE-----

--6VCIlHREqTwiJFWP2CDh8q3BdNKqx4St2--

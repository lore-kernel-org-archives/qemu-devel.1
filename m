Received: from eggs.gnu.org ([2001:4830:134:3::10]:36562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnHsq-0006QU-Gu
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnHsp-0004Wd-GH
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:23:48 -0400
References: <20180807202122.27006-1-lbloch@janustech.com>
	<20180807202122.27006-5-lbloch@janustech.com>
	<2d31c265-e84a-58d2-506e-a8aae8343d1b@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <e333f9c7-f02e-2feb-c819-da41f1b357bb@janustech.com>
Date: Wed, 8 Aug 2018 09:23:20 +0300
MIME-Version: 1.0
In-Reply-To: <2d31c265-e84a-58d2-506e-a8aae8343d1b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] qcow2: Set the default
 cache-clean-interval to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

On 08/07/2018 11:34 PM, Eric Blake wrote:
> On 08/07/2018 03:21 PM, Leonid Bloch wrote:
>> The default cache-clean-interval is set to 30 seconds, in order to lower
>> the overhead of the qcow2 caches.
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>=20
>> +++ b/qapi/block-core.json
>> @@ -2830,7 +2830,8 @@
>> =C2=A0 #
>> =C2=A0 # @cache-clean-interval:=C2=A0 clean unused entries in the L2 and=
 refcount
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 caches. The interval is in seconds. The=20
>> default value
>> -#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 is 0 and it disables this feature (since 2.5)
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 is 30. (since 2.5)
>> +#
>> =C2=A0 # @encrypt:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Image decryption options. Mandatory for
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 encrypted images, except when doing a=20
>> metadata-only
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 probe of the image. (since 2.10)
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index d6e15b2f06..0cda3d3c3a 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -767,7 +767,7 @@ it which is not used for the L2 cache)
>> =C2=A0 @item cache-clean-interval
>> =C2=A0 Clean unused entries in the L2 and refcount caches. The interval =
is=20
>> in seconds.
>> -The default value is 0 and it disables this feature.
>> +The default value is 30.
>=20
> May be worth wording as:
>=20
> The default value is 30, while setting it to 0 disables this feature.
>=20

Definitely! Thanks! Will fix.

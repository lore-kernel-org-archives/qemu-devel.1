Received: from eggs.gnu.org ([2001:4830:134:3::10]:44979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhJt-0007yF-DS
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNhJn-0008Ve-NZ
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:50:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNhJl-0008V5-SP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:50:06 -0500
References: <20181024094051.4470-1-maozhongyi@cmss.chinamobile.com>
	<20181024094051.4470-3-maozhongyi@cmss.chinamobile.com>
	<fdde9d57-ff39-e187-3fca-fbc9e9bb4c6b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c5d53273-f181-4b30-8b65-a4aa85f575ea@redhat.com>
Date: Fri, 16 Nov 2018 10:49:59 -0600
MIME-Version: 1.0
In-Reply-To: <fdde9d57-ff39-e187-3fca-fbc9e9bb4c6b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-iotests: remove unused
 variable here
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org, mreitz@redhat.com
Cc: kwolf@redhat.com

On 10/24/18 6:26 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Mao,
>=20
> On 24/10/18 11:40, Mao Zhongyi wrote:
>> run
>> git grep '\$here' tests/qemu-iotests

Correct. You want both the \ and the $ to be handed to the grep regex.

>=20
> This command doesn't look correct, I believe you have to use either
>=20
> - git grep '$here'

Nope - here, $ is unquoted to grep, so it matches end of line, and you=20
can't match 'here' after end of line.

> or
> - git grep \$here

Ditto.

>=20
>>
>> has 0 hits, which means we are setting a variable that
>> no use, so execute the following cmd to remove all of
>> the 'here=3D...' lines as dead code.
>=20
> This seems to have been removed in e8f8624d3b920de.

Worthwhile to mention in the commit message.

>=20
>>
>> sed -i '/here=3D/d' $(git grep -l 'here=3D' tests/qemu-iotests)
>>
>> Cc: kwolf@redhat.com
>> Cc: mreitz@redhat.com
>> Cc: eblake@redhat.com
>>
>> Suggested-by: Eric Blake <eblake@redhat.com>
>=20
> Please Cc Eric if he suggested, so he can review.

I was cc'd - but mailman is stupid and rewrites the cc line sent to the=20
list because of my settings (I really wish it wouldn't).

Reviewed-by: Eric Blake <eblake@redhat.com>

I might just queue this through my NBD tree, since I noticed the issue=20
again in test 233 just proposed by Dan.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

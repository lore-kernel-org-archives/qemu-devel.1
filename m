Received: from eggs.gnu.org ([2001:4830:134:3::10]:52098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq4R-0004ir-Hb
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVq4L-0007dK-IH
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:15:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVq4L-0007dC-Dd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 23:15:33 -0400
References: <20180619203918.65450-1-eblake@redhat.com>
	<9c14e207-829c-f43d-5a97-ac83d4f4c5c4@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cca94203-eca7-a105-2230-b0f6459b0926@redhat.com>
Date: Wed, 20 Jun 2018 22:15:31 -0500
MIME-Version: 1.0
In-Reply-To: <9c14e207-829c-f43d-5a97-ac83d4f4c5c4@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Simplify .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com

On 06/19/2018 04:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/19/2018 05:39 PM, Eric Blake wrote:
>> Commit 0bcc8e5b was yet another instance of 'git status' reporting
>> dirty files after an in-tree build, thanks to the new binary
>> tests/check-block-qdict.
>>
>> Instead of piecemeal exemptions of each new binary as they are
>> added, let's use git's negative globbing feature to exempt ALL
>> files that have a 'test-' or 'check-' prefix, except for the ones
>> ending in '.c' or '.sh'.  We still have a couple of generated
>> files that then need (re-)exclusion, but the overall list is a
>> LOT shorter, and less prone to needing future edits.
>=20
> Finally :)
>=20
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks; including it in my NBD queue for a pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

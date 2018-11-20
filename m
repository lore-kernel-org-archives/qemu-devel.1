Received: from eggs.gnu.org ([2001:4830:134:3::10]:55122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9hu-00032i-7z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP9hp-00010S-J3
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:21:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gP9hp-0000zH-Bk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:20:57 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-6-david@redhat.com>
	<27cfb4e6-b4db-10de-02c7-691f011d5f99@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5dd77c5-8d40-fe95-4fc8-69aa96fa4f13@redhat.com>
Date: Tue, 20 Nov 2018 11:20:52 -0600
MIME-Version: 1.0
In-Reply-To: <27cfb4e6-b4db-10de-02c7-691f011d5f99@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] test-string-input-visitor: Add more
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11/20/18 11:06 AM, Eric Blake wrote:
> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>> Test that very big/small values are not accepted and that ranges with
>> only one element work. Also test that ranges are ascending and cannot
>> have more than 65536 elements.
>>
>> Rename expect4 to expect5, as we will be moving that to a separate uli=
st
>> test after the rework.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> =C2=A0 tests/test-string-input-visitor.c | 41 ++++++++++++++++++++++++=
+++++--
>> =C2=A0 1 file changed, 39 insertions(+), 2 deletions(-)
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Do we also want to test garbage strings like:

"1-" (incomplete range)
"1X-2" (garbage suffix on first element)
"1-2X" (garbage suffix on second element)

and/or

"-2--1" (valid range of signed integers)
"-1--2" (questionable whether this is valid for the two largest unsigned=20
integers)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

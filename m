Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyFg-00045j-G4
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gJyFP-0007Zj-HE
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:06:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gJyFP-0007XJ-92
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:06:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861BA8762B
	for <qemu-devel@nongnu.org>; Tue,  6 Nov 2018 10:06:10 +0000 (UTC)
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
	<1540929011-19894-10-git-send-email-pbonzini@redhat.com>
	<50ff1d63-9165-41b3-22f8-c2d24a88ef19@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6538d551-d81f-02b0-d471-893bf35d3826@redhat.com>
Date: Tue, 6 Nov 2018 11:06:05 +0100
MIME-Version: 1.0
In-Reply-To: <50ff1d63-9165-41b3-22f8-c2d24a88ef19@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 09/10] scripts/dump-guest-memory:
 Synchronize with guest_phys_blocks_region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05/11/2018 16:46, Laszlo Ersek wrote:
> On 10/30/18 20:50, Paolo Bonzini wrote:
>> Recent patches have removed ram_device and nonvolatile RAM
>> from dump-guest-memory's output.  Do the same for dumps
>> that are extracted from a QEMU core file.
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  scripts/dump-guest-memory.py | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.=
py
>> index 5a857ce..f04697b 100644
>> --- a/scripts/dump-guest-memory.py
>> +++ b/scripts/dump-guest-memory.py
>> @@ -417,7 +417,9 @@ def get_guest_phys_blocks():
>>          memory_region =3D flat_range["mr"].dereference()
>> =20
>>          # we only care about RAM
>> -        if not memory_region["ram"]:
>> +        if not memory_region["ram"] \
>> +           or memory_region["ram_device"] \
>> +           or memory_region["nonvolatile"]:
>>              continue
>> =20
>>          section_size =3D int128_get64(flat_range["addr"]["size"])
>>
>=20
> Sorry about the late comment, I've been away.
>=20
> The line continuation style in the python script is inconsistent. When =
I
> wrote the original version, my understanding was that the "Pythonic" wa=
y
> to break up lines was to open a new parenthesized subexpression. This
> way the logical "or" operator could be left at the end of the line. See
> e.g. in the "get_guest_phys_blocks" method.
>=20
> https://www.python.org/dev/peps/pep-0008/#maximum-line-length
>=20
>> The preferred way of wrapping long lines is by using Python's implied
>> line continuation inside parentheses, brackets and braces. Long lines
>> can be broken over multiple lines by wrapping expressions in
>> parentheses. These should be used in preference to using a backslash
>> for line continuation.
>=20
> However, several trailing backslashes have been added since, and I've
> totally failed to catch them. I guess at this point either style should
> be acceptable, in this script.
>=20
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Fixed this one, thanks.

Paolo

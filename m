Received: from eggs.gnu.org ([2001:4830:134:3::10]:34710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4TD0-0008H0-B1
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f4TCx-0007JK-6x
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:23:22 -0400
References: <20180327202152.1799131-1-eblake@redhat.com>
	<46f09a31-addb-32e0-d9b6-827166690a72@redhat.com>
	<82cc73cb-ba8a-be38-496a-5dc66d2c6850@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1417354e-cb91-3f1c-a7b7-5e46a6142b2e@redhat.com>
Date: Fri, 6 Apr 2018 17:23:08 +0200
MIME-Version: 1.0
In-Reply-To: <82cc73cb-ba8a-be38-496a-5dc66d2c6850@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] dump: Fix build with newer gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 06/04/2018 17:06, Eric Blake wrote:
> On 04/03/2018 01:46 PM, Eric Blake wrote:
>> On 03/27/2018 03:21 PM, Eric Blake wrote:
>>> gcc 8 on rawhide is picky enough to complain:
>>>
>>> /home/dummy/qemu/dump.c: In function 'create_header32':
>>> /home/dummy/qemu/dump.c:817:5: error: 'strncpy' output truncated befo=
re terminating nul copying 8 bytes from a string of the same length [-Wer=
ror=3Dstringop-truncation]
>>>      strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE))=
;
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> But we already have SIG_LEN defined as the right length without needi=
ng
>>> to do a strlen(), and memcpy() is better than strncpy() when we know
>>> we do not want a trailing NUL byte.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  dump.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> I'll include this in my qapi+misc pull request for 2.12-rc2
>=20
> That pull request was abandoned; Paolo, do you want to pick this up in
> your misc tree?
>=20

Ok.

Paolo

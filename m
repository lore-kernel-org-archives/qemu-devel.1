Received: from eggs.gnu.org ([2001:4830:134:3::10]:51180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehsT8-0002OS-BK
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehsT5-0006DQ-68
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehsT5-0006D9-0F
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 02:42:35 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-16-armbru@redhat.com>
	<5a7bf20e-4787-e173-258c-a2254e97ff9d@redhat.com>
Date: Sat, 03 Feb 2018 08:42:31 +0100
In-Reply-To: <5a7bf20e-4787-e173-258c-a2254e97ff9d@redhat.com> (Eric Blake's
	message of "Fri, 2 Feb 2018 13:59:48 -0600")
Message-ID: <87607eecyg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 15/15] target: Use qemu_log() instead of
 fprintf(stderr, ...)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@xilinx.com

Eric Blake <eblake@redhat.com> writes:

> On 02/02/2018 12:37 PM, Markus Armbruster wrote:
>> From: Alistair Francis <alistair.francis@xilinx.com>
>> 
>> Convert fprintf(stderr, ...) to use qemu_log(). Double prints in
>> target/ppc/translate.c were manually remove. A fprintf() in
>> target/sh4/translate.c was kept as it's inside a #if 0. The #if 0 and
>> fflush() was removed around the unimplemented log in
>> target/sh4/translate.c as well.
>> 
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> [Trivial conflict with 6f1c2af641d resolved]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  dtc                          |  2 +-
>>  target/cris/translate.c      |  2 +-
>>  target/ppc/translate.c       | 36 ++++++++++--------------------------
>>  target/sh4/translate.c       |  7 ++-----
>>  target/unicore32/translate.c |  2 +-
>>  5 files changed, 15 insertions(+), 34 deletions(-)
>> 
>> diff --git a/dtc b/dtc
>> index e54388015a..558cd81bdd 160000
>> --- a/dtc
>> +++ b/dtc
>> @@ -1 +1 @@
>> -Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
>> +Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
>
> Intentional?

Rebase accident, good catch!

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cHDYh-000731-F0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cHDYe-0002Dq-Bs
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:41:39 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dje@google.com>) id 1cHDYe-00026T-6c
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:41:36 -0500
Received: by mail-io0-f182.google.com with SMTP id d9so46602081ioe.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:41:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <08b0eb45-e85e-a68c-aa45-721d8d046376@redhat.com>
References: <001a113dca8274572005406e03c3@google.com>
	<08b0eb45-e85e-a68c-aa45-721d8d046376@redhat.com>
From: Doug Evans <dje@google.com>
Date: Wed, 14 Dec 2016 09:39:32 -0800
Message-ID: <CADPb22Ri5nntLLxghgA2SRBmvObkvHTAC61OO4yZTE85aZxphw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] x86: Fix x86_64 'g' packet response to gdb
 from 32-bit mode.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, Dec 14, 2016 at 9:14 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 04/11/2016 00:35, Doug Evans wrote:
>> The remote protocol can't handle flipping back and forth
>> between 32-bit and 64-bit regs. To compensate, pretend "as if"
>> on 64-bit cpu when in 32-bit mode.
>>
>> Signed-off-by: Doug Evans <dje@google.com>
>> ---
>>  target-i386/gdbstub.c | 52
>> ++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 39 insertions(+), 13 deletions(-)
>> ...
>
> Queued for 2.9, thanks.

Awesome! Thanks very much!

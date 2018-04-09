Received: from eggs.gnu.org ([2001:4830:134:3::10]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Yfy-00064V-5F
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Yfx-0003g3-5e
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:25:46 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5Yfx-0003fh-0E
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:25:45 -0400
Received: by mail-oi0-x244.google.com with SMTP id 188-v6so7991611oih.8
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 08:25:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cdc75c37-85ab-3218-423d-4f50f895b4fc@redhat.com>
References: <20180408145933.1149-1-f4bug@amsat.org>
	<20180409055825.GB4848@stefanha-x1.localdomain>
	<cdc75c37-85ab-3218-423d-4f50f895b4fc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 16:25:23 +0100
Message-ID: <CAFEAcA_NLYgkXM9D-Khn7Gar6Te25txXYsmPASbHURM-nYOF6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] gdbstub: fix off-by-one in
 gdb_handle_packet()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 April 2018 at 10:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 09/04/2018 07:58, Stefan Hajnoczi wrote:
>> On Sun, Apr 08, 2018 at 11:59:33AM -0300, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> memtohex() adds an extra trailing NUL character.
>>>
>>> Reported-by: AddressSanitizer
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> (gdb) dump binary memory /tmp/dram.bin 0x94000000 0x94100000
>>> Remote connection closed
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> =3D=3D22732=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addr=
ess 0x7ffe43018340 at pc 0x55f2655fde81 bp 0x7ffe43017210 sp 0x7ffe43017208
>>> WRITE of size 1 at 0x7ffe43018340 thread T0
>>>
>>> ---
>>>  gdbstub.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Peter, can you apply this directly to master?

Applied, thanks. (patchwork and patches made a pig's ear of this
for some reason, I think they got confused about where the
commit message stopped and the patch started, so I had to
hand-edit the files.)

-- PMM

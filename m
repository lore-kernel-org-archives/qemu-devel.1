Received: from eggs.gnu.org ([2001:4830:134:3::10]:57650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dZkSI-0002zG-Ry
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dZkSI-0001GZ-6d
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:59:54 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <12087bf6-7ff4-58f4-5a4a-1bdf1661abfb@redhat.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-3-f4bug@amsat.org>
	<12087bf6-7ff4-58f4-5a4a-1bdf1661abfb@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 24 Jul 2017 13:59:18 -0700
Message-ID: <CAKmqyKNo18_JGveUWZMjspRyTPY-g2q3JcOP3tt7s8q15Wogrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 02/35] loader: check
 get_image_size() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jul 24, 2017 at 11:38 AM, Eric Blake <eblake@redhat.com> wrote:
> On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> since a negative value means it errored.
>>
>> hw/core/loader.c:149:9: warning: Loss of sign in implicit conversion
>>     if (size > max_sz) {
>>         ^~~~
>> hw/core/loader.c:171:9: warning: Loss of sign in implicit conversion
>>     if (size > memory_region_size(mr)) {
>>         ^~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/core/loader.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>

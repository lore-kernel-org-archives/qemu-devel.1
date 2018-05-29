Received: from eggs.gnu.org ([2001:4830:134:3::10]:54186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNgVk-0002vd-K9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNgVj-0000rJ-Q9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:26:08 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNgVj-0000qI-Lj
	for qemu-devel@nongnu.org; Tue, 29 May 2018 11:26:07 -0400
Received: by mail-oi0-x243.google.com with SMTP id h79-v6so6913114oig.13
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:26:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4f0eec20-64a6-fb8f-58ae-1fab9ef34f53@redhat.com>
References: <20180426140253.3918-1-peter.maydell@linaro.org>
	<4f0eec20-64a6-fb8f-58ae-1fab9ef34f53@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 16:25:46 +0100
Message-ID: <CAFEAcA86RRfz-YQivsPDRqAbZqOtdNpRnnBeKC24B5yYzY1=zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vl.c: Don't zero-initialize statics for
 serial_hds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Ping for application via qemu-trivial?

thanks
-- PMM

On 26 April 2018 at 15:19, Thomas Huth <thuth@redhat.com> wrote:
> On 26.04.2018 16:02, Peter Maydell wrote:
>> checkpatch reminds us that statics shouldn't be zero-initialized:
>>
>> ERROR: do not initialise statics to 0 or NULL
>> #35: FILE: vl.c:157:
>> +static int num_serial_hds = 0;
>>
>> ERROR: do not initialise statics to 0 or NULL
>> #36: FILE: vl.c:158:
>> +static Chardev **serial_hds = NULL;
>>
>> I forgot to fix this in 6af2692e86f9fdfb3d; do so now.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I wouldn't bother with this except that I forgot to fold
>> it in when applying the serial-limits patchset.
>>
>>  vl.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 616956adf1..6d8b869dad 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -154,8 +154,8 @@ QEMUClockType rtc_clock;
>>  int vga_interface_type = VGA_NONE;
>>  static DisplayOptions dpy;
>>  int no_frame;
>> -static int num_serial_hds = 0;
>> -static Chardev **serial_hds = NULL;
>> +static int num_serial_hds;
>> +static Chardev **serial_hds;
>>  Chardev *parallel_hds[MAX_PARALLEL_PORTS];
>>  Chardev *virtcon_hds[MAX_VIRTIO_CONSOLES];
>>  Chardev *sclp_hds[MAX_SCLP_CONSOLES];
>>
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

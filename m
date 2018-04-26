Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBgW3-0001gS-D2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBgVx-0005Tb-Li
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:00:51 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:35229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBgVx-0005Sk-Fp
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:00:45 -0400
Received: by mail-ot0-x241.google.com with SMTP id h8-v6so25574418otb.2
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:00:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d28ba1e3-7fb5-04e7-7743-b7cd980f4d6f@amsat.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-14-peter.maydell@linaro.org>
	<d28ba1e3-7fb5-04e7-7743-b7cd980f4d6f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 14:00:22 +0100
Message-ID: <CAFEAcA8TT6hTZgfJYE_ccdz8Q0SVDQF30PeTph8Fd=u95tWycQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/13] vl.c: new function max_serial_hds()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 20 April 2018 at 18:50, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> On 04/20/2018 11:52 AM, Peter Maydell wrote:
>> Create a new function max_serial_hds() which returns the number of
>> serial ports defined by the user. This is needed only by spapr.
>> This allows us to remove the MAX_SERIAL_PORTS define.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/sysemu/sysemu.h | 6 ++++--
>>  hw/ppc/spapr.c          | 2 +-
>>  vl.c                    | 5 +++++
>>  3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 989cbc2b7b..612659a718 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -159,10 +159,12 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const=
 QDict *qdict);
>>
>>  /* serial ports */
>>
>> -#define MAX_SERIAL_PORTS 4
>> -
>>  /* Return the Chardev for serial port i, or NULL if none */
>>  Chardev *serial_hd(int i);
>> +/* return the number of serial ports defined by the user. serial_hd(i)
>> + * will always return NULL for any i which is greater than or equal to =
this.
>> + */
>> +int max_serial_hds(void);
>
> What about naming it serial_hds_count() to keep this under the serial_
> namespace?

OK, makes sense.

> And about using a size_t for num_serial_hds?

This doesn't seem worthwhile though.

Since the rename of max_serial_hds is the only change here, I
propose to apply this to master (fixing up the function name in
this patch in the process), to reduce the number of conflicts
with other changes currently in-flight.

thanks
-- PMM

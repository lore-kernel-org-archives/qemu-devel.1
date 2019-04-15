Received: from eggs.gnu.org ([209.51.188.92]:39849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFyyg-0001ce-3R
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hFyyf-00064Z-2W
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hFyye-00064C-Qm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:36:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so19728083wmk.4
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 03:36:40 -0700 (PDT)
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
	<29f79530-fd9e-ea60-8cf3-df593b855f10@reactos.org>
	<CACXAS8De=OS0O4O2=Q721KCUc9RuQryOGNfedejM+yzWcX9aOg@mail.gmail.com>
	<4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5665d408-512e-2ad4-aa4e-481287fc39e7@redhat.com>
Date: Mon, 15 Apr 2019 12:36:36 +0200
MIME-Version: 1.0
In-Reply-To: <4eec1d45-01a6-1c96-ee49-6c3131823b83@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base
 year
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: "open list:PReP" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 4/14/19 11:24 PM, Hervé Poussineau wrote:
> Le 14/04/2019 à 20:53, Artyom Tarasenko a écrit :
>> On Sun, Apr 14, 2019 at 7:01 PM Hervé Poussineau
>> <hpoussin@reactos.org> wrote:
>>>
>>> Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
>>>> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
>>>>
>>>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
>>>> ---
>>>>    hw/isa/i82378.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
>>>> index a5d67bc..546c928 100644
>>>> --- a/hw/isa/i82378.c
>>>> +++ b/hw/isa/i82378.c
>>>> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error
>>>> **errp)
>>>>        isa = isa_create_simple(isabus, "i82374");
>>>>
>>>>        /* timer */
>>>> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
>>>> +    isa = isa_create(isabus, TYPE_MC146818_RTC);
>>>> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
>>>> +    qdev_init_nofail(DEVICE(isa));
>>>
>>> I am not sure the base_year should be hardcoded in i82378. I can
>>> assume other machines with a i82378 can have another base_year.
>>
>> I doubt it to be honest. How would it work in the hardware? Is there a
>> pin which would switch a year?
>> I do believe the different i823xx may have the different base years
>> though.

There is no RTC on the i82378, this should be moved to the board code
and set the date there. Do you want me to send this patch?

Regards,

Phil.

Received: from eggs.gnu.org ([209.51.188.92]:60758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqMhD-0004rA-SR
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 13:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqMhD-0008RU-2b
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 13:40:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gqMhB-0008K7-Cz
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 13:40:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so12158637wrx.9
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 10:40:37 -0800 (PST)
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
	<f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
	<74cf6f64-254f-1a15-4071-0b73daef02a6@redhat.com>
	<d65eda71-c173-5ca2-1e57-162acaaf223f@redhat.com>
	<e67a7cb3-954f-c497-c51c-cc8cdde4011a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <52f766b2-16e9-7b6e-8086-11914142816f@redhat.com>
Date: Sun, 3 Feb 2019 19:40:35 +0100
MIME-Version: 1.0
In-Reply-To: <e67a7cb3-954f-c497-c51c-cc8cdde4011a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tests/uefi-test-tools: add build
 scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 2/2/19 12:27 AM, Laszlo Ersek wrote:
> On 02/02/19 00:03, Philippe Mathieu-Daudé wrote:
>> On 2/1/19 11:35 PM, Laszlo Ersek wrote:
>>> On 01/31/19 19:55, Laszlo Ersek wrote:
[...]
>>> (f) So, the solution is to prefix the "./build.sh" recipe with a "+"
>>> sign, to mark it as "recursive":
>>>
>>>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/Makefile
>>>> index 61d263861e..449b81d8ba 100644
>>>> --- a/tests/uefi-test-tools/Makefile
>>>> +++ b/tests/uefi-test-tools/Makefile
>>>> @@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
>>>>  .NOTPARALLEL:
>>>>
>>>>  Build/bios-tables-test.%.efi: build-edk2-tools
>>>> -	./build.sh $(edk2_dir) BiosTablesTest $* $@
>>>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
>>
>> Yes :) This fixed it!
>>
>>>>
>>>>  build-edk2-tools:
>>>>  	$(MAKE) -C $(edk2_dir)/BaseTools
>>>
>>> This fixes the issue for me on Fedora 29, without breaking the behavior
>>> on RHEL7.
>>
>> Excellent! I triggered Travis builds (Ubuntu/Debian).

FYI, everthing build fine there.

>>>
>>> I'll submit v3 later. Thank you for catching this error.
[...]

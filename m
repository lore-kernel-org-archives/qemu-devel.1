Received: from eggs.gnu.org ([209.51.188.92]:52237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpiDv-0001o7-OP
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:27:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gpiDp-0008FZ-9w
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:27:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gpiDj-00082n-C4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:27:41 -0500
References: <20190124203959.30875-1-lersek@redhat.com>
	<20190124203959.30875-5-lersek@redhat.com>
	<6d5868f5-70b4-71e2-3495-8d47156148c1@redhat.com>
	<f39b4b89-bd10-de9c-d3d2-c38411594f70@redhat.com>
	<74cf6f64-254f-1a15-4071-0b73daef02a6@redhat.com>
	<d65eda71-c173-5ca2-1e57-162acaaf223f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e67a7cb3-954f-c497-c51c-cc8cdde4011a@redhat.com>
Date: Sat, 2 Feb 2019 00:27:05 +0100
MIME-Version: 1.0
In-Reply-To: <d65eda71-c173-5ca2-1e57-162acaaf223f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 02/02/19 00:03, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/1/19 11:35 PM, Laszlo Ersek wrote:
>> On 01/31/19 19:55, Laszlo Ersek wrote:

>>> (1) How *exactly* does it fail for you?
>=20
> In my mailbox the mail appears with Message-ID:
> cf693646-58c8-8810-58a1-a6e503636d39@redhat.com in response to
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06393.html but
> I can't see the mail on the public archives :/

Ouch. I've now searched my mailbox for the Message-ID above, and there's
no match. Too bad your email got lost.

>> (f) So, the solution is to prefix the "./build.sh" recipe with a "+"
>> sign, to mark it as "recursive":
>>
>>> diff --git a/tests/uefi-test-tools/Makefile b/tests/uefi-test-tools/M=
akefile
>>> index 61d263861e..449b81d8ba 100644
>>> --- a/tests/uefi-test-tools/Makefile
>>> +++ b/tests/uefi-test-tools/Makefile
>>> @@ -87,7 +87,7 @@ Build/%.fat: Build/%.efi
>>>  .NOTPARALLEL:
>>>
>>>  Build/bios-tables-test.%.efi: build-edk2-tools
>>> -	./build.sh $(edk2_dir) BiosTablesTest $* $@
>>> +	+./build.sh $(edk2_dir) BiosTablesTest $* $@
>=20
> Yes :) This fixed it!
>=20
>>>
>>>  build-edk2-tools:
>>>  	$(MAKE) -C $(edk2_dir)/BaseTools
>>
>> This fixes the issue for me on Fedora 29, without breaking the behavio=
r
>> on RHEL7.
>=20
> Excellent! I triggered Travis builds (Ubuntu/Debian).
>=20
>>
>> I'll submit v3 later. Thank you for catching this error.
>=20
> Now that we are happy, maybe Michael can do this change when applying,
> but I guess you'd prefer first to write a line about this '+' in the
> commit message or the Makefile.

That's right, I'd like to extend the comment that we already have in the
Makefile about .NOTPARALLEL, with a note on the "+" indicator.

>=20
> With the +:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Awesome, thank you! :)

>=20
> Thanks a lot for figuring this out alone and fixing it!

It definitely helped that you mentioned your use of Fedora 29 earlier :)

Also, we're very lucky that GNU Make's documentation is so nice.

Thanks,
Laszlo

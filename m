Received: from eggs.gnu.org ([2001:4830:134:3::10]:53066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eWITp-0004Mp-F4
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 04:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eWITo-0008Al-Jc
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 04:03:29 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eWITo-0008A6-D6
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 04:03:28 -0500
Received: by mail-wr0-x242.google.com with SMTP id p69so39055579wrb.8
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 01:03:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOvqHj4P17JQ=bJqpZsA3n-sfw927Sad3-YD2FUHff1zhpanGA@mail.gmail.com>
References: <20171207065639.164900-1-lepton@google.com>
	<CAOvqHj4P17JQ=bJqpZsA3n-sfw927Sad3-YD2FUHff1zhpanGA@mail.gmail.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Tue, 2 Jan 2018 01:03:25 -0800
Message-ID: <CAOvqHj7Cx7dJLq2kYgpG3M-RoeBd64XM-BT0Hs4=vvnTg9zgAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/input/hid: Add support for several keys.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com, mjt@tls.msk.ru, Laurent Vivier <laurent@vivier.eu>, Tao Wu <lepton@google.com>

Ping?

On Thu, Dec 14, 2017 at 1:25 PM, Tao Wu(=E5=90=B4=E6=B6=9B@Eng) <lepton@goo=
gle.com> wrote:
> Anybody can merge this?
>
> It's a simple change:  actually it only changed 4 bytes in hid usage
> table to enable 4 keys: audiomute volumeup volumedown and power.
>
> It's easy to verify what the patch is doing:
>
> Boot some guest os with argument "-usbdevice keyboard"  and use qemu
> monitor console to do "sendkey audiomute", without this patch, nothing
> happend inside guest os. with this patch,  all these 4 keys work correctl=
y.
>
> On Wed, Dec 6, 2017 at 10:56 PM, Tao Wu <lepton@google.com> wrote:
>> Add support for these keys: audiomute volumedown volumeup power.
>> Tested with "sendkey" command in monitor and verify the behavior
>> in guest OS.
>>
>> Signed-off-by: Tao Wu <lepton@google.com>
>> ---
>>  hw/input/hid.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/input/hid.c b/hw/input/hid.c
>> index 0d049ff61c..aa4fb826fd 100644
>> --- a/hw/input/hid.c
>> +++ b/hw/input/hid.c
>> @@ -57,14 +57,14 @@ static const uint8_t hid_usage_keys[0x100] =3D {
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x58, 0xe4, 0x00, 0x00,
>> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
>> +    0x7f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x00,
>> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
>>      0xe6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x48, 0x4a,
>>      0x52, 0x4b, 0x00, 0x50, 0x00, 0x4f, 0x00, 0x4d,
>>      0x51, 0x4e, 0x49, 0x4c, 0x00, 0x00, 0x00, 0x00,
>> -    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x00, 0x00,
>> +    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x66, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> --
>> 2.15.1.424.g9478a66081-goog
>>

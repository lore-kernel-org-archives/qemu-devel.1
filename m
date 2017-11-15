Received: from eggs.gnu.org ([2001:4830:134:3::10]:51820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEoeF-0002Pr-4s
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEoeE-0001h1-1n
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:45:59 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEoeD-0001fz-RX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 22:45:57 -0500
Received: by mail-wm0-x242.google.com with SMTP id z3so236930wme.5
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 19:45:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8f332ba7-87f3-2f7e-1549-ba2435e090d1@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CLEUxM=BRnxOtni2-VU10Ho7mvzcSAMP3S2MLQtjwSbrA@mail.gmail.com>
	<8f332ba7-87f3-2f7e-1549-ba2435e090d1@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Nov 2017 04:45:55 +0100
Message-ID: <CAJ+F1CLjU+xN5QNzLgvEHfemKm95DwFD6rEyA1eGr6MrrYvcFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 3/3] tpm_tis: Return 0 for
 every register in case of failure mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi

On Wed, Nov 15, 2017 at 2:18 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 11/14/2017 06:47 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi
>>
>> On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
>> <stefanb@linux.vnet.ibm.com> wrote:
>>>
>>> Rather than returning ~0, return 0 for every register in case of
>>> failure mode. The '0' is better to indicate that there's no device
>>> there.
>>
>> For most registers, 0 makes more sense. However, I wonder if we
>> shouldn't just fail to start qemu in this case...
>>
>> Not convincing me this is 2.11 material either. Does this fix a specific
>> bug?
>
>
> Yes, SeaBIOS detects the ~0 when it probes and thinks there's a device
> there. It then hangs trying to set flags and read registers to be able to
> use the device.
>

Please update the commit message with that added,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>    Stefan
>
>
>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>>   hw/tpm/tpm_tis.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>>> index fec2fc6..42d647d 100644
>>> --- a/hw/tpm/tpm_tis.c
>>> +++ b/hw/tpm/tpm_tis.c
>>> @@ -545,7 +545,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque,
>>> hwaddr addr,
>>>       uint8_t v;
>>>
>>>       if (tpm_backend_had_startup_error(s->be_driver)) {
>>> -        return val;
>>> +        return 0;
>>>       }
>>>
>>>       switch (offset) {
>>> --
>>> 2.5.5
>>>
>>
>>
>



--=20
Marc-Andr=C3=A9 Lureau

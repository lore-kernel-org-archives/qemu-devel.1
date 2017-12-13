Received: from eggs.gnu.org ([2001:4830:134:3::10]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ePBfu-0004dK-BD
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ePBfr-0006wh-4K
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:22:34 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:32541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ePBfq-0006oa-TU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:22:31 -0500
Date: Wed, 13 Dec 2017 19:22:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
Message-ID: <alpine.BSF.2.21.1712131914560.26243@zero.eik.bme.hu>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
	<7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 13 Dec 2017, Programmingkid wrote:
>> On Dec 13, 2017, at 4:14 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>>
>> On Tue, Dec 12, 2017 at 12:49:34PM -0500, Programmingkid wrote:
>>>
>>>> On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange <berrange@redhat.com> wrote:
>>>>
>>>> On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
>>>>> On Macintosh keyboards there is a key called fn that is used to give the
>>>>> function keys more functionality. Does this key exist in the keyboard keys
>>>>> database?
>>>>
>>>> When you say "Macintosh keyboards" are you talking about the old style
>>>> keyboards with Apple's custom ADB connector, or simply Apple branded
>>>> USB keyboards ?
>>>
>>> USB keyboards.
>>>
>>>>
>>>> If its the latter (USB), then please plug it into a Linux machine, and
>>>> in a text console (ie not X11) run 'showkey' and press this 'fn' key on
>>>> its own and tell me what (if any) hex code gets printed.
>>>
>>> There was no response to the fn key.
>>
>> Doh, I made a mistake - you need to run   'showkey -s'  to get raw scancodes.
>> Can you try this again, pressing 'fn' on its own, and also press 'fn' in
>> combination with some function keys.
>
> Sorry but showkey still did not register the fn key being pushed.

I don't know how the fn key is handled but the Linux driver knows about it 
so maybe it could help to understand:

https://github.com/torvalds/linux/blob/master/drivers/hid/hid-apple.c

Regards,
BALATON Zoltan

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diQIE-0008JJ-I3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 15:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diQIA-0001a7-Ik
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 15:17:22 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diQIA-0001Zw-Dl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 15:17:18 -0400
Received: by mail-qt0-x241.google.com with SMTP id c15so7087230qta.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 12:17:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<2897c32f34b415aadcf43a5ae296cf5f6e15e757.1501280035.git.alistair.francis@xilinx.com>
	<87valqw9x0.fsf@dusky.pond.sub.org>
	<CAKmqyKPA6v3RpZAFOibfNeOZVzai5phfXo2njDkD6PxsBgqVrw@mail.gmail.com>
	<87lgmluw2g.fsf@dusky.pond.sub.org>
	<ab184e25-19f5-5fd2-494a-7ea04e48f6c7@redhat.com>
	<87fucq86wh.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <42a323c8-94ae-2d9c-01e8-f34b2ad7d41f@amsat.org>
Date: Thu, 17 Aug 2017 16:17:14 -0300
MIME-Version: 1.0
In-Reply-To: <87fucq86wh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] Convert single line fprintf() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On 08/17/2017 02:02 PM, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> On 15/08/2017 09:30, Markus Armbruster wrote:
>>> The stupid fix is to repeat libraries until the link succeeds:
>>>
>>>      test-util-obj-y = libqemuutil.a libqemustub.a libqemuutil.a
>>>
>>> You may have seen this with -lX11 if you're old enough.
>>>
[...]
>>>
>>> The smart solution is not to have .a reference each other.
>>
>> Nah, I think we should teach those new kids on the block about -lX11
>> instead. :)

haha

>>
>>> Paolo, what do you think?
>>
>> Another possibility is to just merge the two static libraries into one.
> 
> Sounds good to me!

it makes sens to only keep libqemuutil.a with stub included.

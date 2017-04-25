Received: from eggs.gnu.org ([2001:4830:134:3::10]:33417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2pw7-0002k5-GS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2pw6-0003C2-I5
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:10:39 -0400
MIME-Version: 1.0
In-Reply-To: <1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
	<7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
	<7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
	<f9ce81bc-72d5-d436-5cb6-58c9dbb10aa4@redhat.com>
	<1cdac8de-6340-ac1a-9d2b-3546a4c7ffd3@redhat.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Tue, 25 Apr 2017 10:10:37 +0800
Message-ID: <CAOGPPbdcqBCEPBwb9kgG1=9edkS4REfPvx912MjH=iw0_wedvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Lidong Chen <lidongchen@tencent.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, mreitz@redhat.com

On Mon, Apr 24, 2017 at 11:53 PM, Eric Blake <eblake@redhat.com> wrote:
> On 04/24/2017 10:47 AM, Eric Blake wrote:
>> On 04/24/2017 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>>>>>  /*
>>>>> - * Returns true iff the first sector pointed to by 'buf' contains at
>>>>> least
>>>>> - * a non-NUL byte.
>>>>> + * Returns true if the first sector pointed to by 'buf' contains at
>>>>> least
>>>>> + * a non-NULL byte.
>>>>
>>>> NACK to both changes.  'iff' is an English word that is shorthand for
>>>> "if and only if".  "NUL" means the one-byte character, while "NULL"
>>>> means the 8-byte (or 4-byte, on 32-bit platform) pointer value.
>>>
>>> I agree with Lidong shorthands are not obvious from non-native speaker.
>>>
>>> What about this?
>>>
>>>  * Returns true if (and only if) the first sector pointed to by 'buf'
>>> contains
>>
>> That might be okay.
>>
>>>  * at least a non-null character.
>>
>> But that still doesn't make sense.  The character name is NUL, and
>> non-NULL refers to something that is a pointer, not a character.
>
> What's more, the NUL character can actually occupy more than one byte
> (think UTF-16, where it is the two-byte 0 value).  Referring to NUL byte
> rather than NUL character (or even the ' byte') makes it obvious
> that this function is NOT encoding-sensitive, and doesn't start
> mis-behaving just because the data picks a multi-byte character encoding.

How about this?

 * Returns true  if (and only if) the first sector pointed to by 'buf'
contains at least
 * a non-zero byte.

Thanks.

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>

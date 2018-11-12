Received: from eggs.gnu.org ([2001:4830:134:3::10]:53220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM7yb-0005z3-UD
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gM7wl-0003fn-47
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gM7wk-0003cE-NG
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:51:51 -0500
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<20181109111731.vxdmqmkorblcnntx@sirius.home.kraxel.org>
	<20181109112953.w4wtltwxpl4z2lpj@sirius.home.kraxel.org>
	<1724064a-acdc-5571-4f54-f0ac021027d0@redhat.com>
	<6e7304f6-b81a-982f-a94c-d8df4202a82e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8eb6042f-a3d8-539f-2df6-adb56869a5d9@redhat.com>
Date: Mon, 12 Nov 2018 09:51:39 +0100
MIME-Version: 1.0
In-Reply-To: <6e7304f6-b81a-982f-a94c-d8df4202a82e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Andrzej Zaborowski <balrog@zabor.org>, Andrzej Zaborowski <andrew.zaborowski@intel.com>, Andrzej Zaborowski <andrew@openedhand.com>

On 2018-11-09 14:16, Paolo Bonzini wrote:
> On 09/11/2018 13:39, Thomas Huth wrote:
>> On 2018-11-09 12:29, Gerd Hoffmann wrote:
>>> On Fri, Nov 09, 2018 at 12:17:31PM +0100, Gerd Hoffmann wrote:
>>>>   Hi,
>>>>
>>>>> I am also suspicious about hw/bt/ but don't know enough
>>>>> about that subsystem to say if it could benefit from
>>>>> using QOM objects more.
>>>>
>>>> I'm wondering whenever anyone would even notice if we just rm -rf hw=
/bt
>>>>
>>>> Looking through the changelog for the last five years (after hw/ spl=
it)
>>>> the only thing I see is fixing warnings from compiler or coverity,
>>>> adapting to changes in other systems (chardev for example) and treew=
ide
>>>> changes.  Not a *single* patch specific to bluetooth ...
>>>
>>> Tried this after studying docs:
>>>
>>>   qemu -usb -device usb-bt-dongle -bt hci,vlan=3D0 -bt device:keyboar=
d
>>>
>>> Segfaults right anway on first keypress.
>>> I guess that qualifies as "broken and obviously unused".
>>
>> Thanks for checking! I guess that means we could even get rid of it
>> without deprecating it first if it is broken already for more than two
>> releases...?
>=20
> I think what others were using bluetooth passthrough.  But it's
> certainly possible that it's broken.

Since there haven't been any non-trivial changes to the files in
*years*, and apparently none of the current QEMU developers is
interested in maintaining this subsystem, I think it is really very
likely that it's broken. So unless someone has got some hardware that
could be used for testing it, I think we really should mark this as
deprecated - we could keep it in that state a little bit longer to see
whether a user speaks up and says that it is still useful, but in case
nobody uses this anymore, there is really no need that we carry this
code with us forever.

 Thomas

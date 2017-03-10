Received: from eggs.gnu.org ([2001:4830:134:3::10]:38641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIP5-0000MA-JF
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cmIP1-0007eN-8r
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:08:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cmIP1-0007e4-10
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:08:07 -0500
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
	<16223ebe-e08d-c686-7ff3-a58db88e3a01@redhat.com>
	<d897339f-9451-d350-6fd5-72c68a2da677@imgtec.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1aeb7375-d41f-1be4-cbb5-d7bd27801110@redhat.com>
Date: Fri, 10 Mar 2017 19:07:59 +0800
MIME-Version: 1.0
In-Reply-To: <d897339f-9451-d350-6fd5-72c68a2da677@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 18:20, Yongbok Kim wrote:
>
> On 09/03/2017 09:53, Jason Wang wrote:
>>
>> On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 16:50, Thomas Huth wrote:
>>> On 09.03.2017 03:21, Jason Wang wrote:
>>>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 19:22, Thomas Huth wrote:
>>>>> On 08.03.2017 11:03, Peter Maydell wrote:
>>>>>> On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
>>>>>>> But anyway, the more important thing that keeps me concerned is:
>>>>>>> Someone
>>>>>>>     once told me that we should get rid of old parameters and int=
erfaces
>>>>>>> (like HMP commands) primarily only when we're changing to a new m=
ajor
>>>>>>> version number. As you all know, QEMU has a lot of legacy options=
,
>>>>>>> which
>>>>>>> are likely rather confusing than helpful for the new users nowada=
ys,
>>>>>>> e.g. things like the "-net channel" option (which is fortunately =
even
>>>>>>> hardly documented), but maybe also even the whole vlan/hub concep=
t in
>>>>>>> the net code, or legacy parameters like "-usbdevice". If we switc=
h to
>>>>>>> version 3.0, could we agree to remove at least some of them?
>>>>>> I think if we are going to deprecate and remove options we need
>>>>>> a clear transition plan for doing so, which means at least one
>>>>>> release where options are "still works, but warn that they
>>>>>> are going away with pointer to documentation or similar info
>>>>>> about their replacement syntax", before actually dropping them.
>>>>> Yes, that's certainly a good idea. But as Daniel suggested in his m=
ail,
>>>>> I think we should also have the rule that the option should be mark=
ed as
>>>>> deprecated in multiple releases first - so that the users have a ch=
ance
>>>>> to speak up before something gets really removed (otherwise the opt=
ion
>>>>> could be removed right on the first day after the initial release w=
ith
>>>>> the deprecation message, so there is no time for the user to notice=
 this
>>>>> and complain). Not sure whether we need three releases, as Daniel
>>>>> suggested, though, but if that's common sense, that's fine for me, =
too.
>>>>>
>>>>> Anyway, I've now started a Wiki page where we could track the remov=
al of
>>>>> deprecated interfaces:
>>>>>
>>>>>     http://wiki.qemu-project.org/Features/LegacyRemoval
>>>>>
>>>>> Feedback / updates / addition of other legacy interfaces is welcome=
!
>>>>>
>>>>>     Thomas
>>>>>
>>>> I think we may want to add mipsnet to the list too. It's kernel driv=
er
>>>> was removed about 3 years ago.
>>> But that's still the default network of the "mipssim" machine ...
>>> is that machine considered as deprecated, too?
>>>
>>>    Thomas
>> I think so, according to [1], it was deprecated.
>>
>> [1] https://www.linux-mips.org/wiki/MIPSsim
>>
>> Thanks
> Indeed but we still use the platform to verify architectural
> compatibilities even for newer MIPS architectures.
>
> Regards,
> Yongbok
>

I see, but I believe it may need some modifications in the code to=20
support newer architectures? If yes, plan to send them upstream? Since=20
it has been deprecated, if no new codes it makes sense to deprecate it=20
in qemu too. You can still use exist qemu versions to do the verification=
.

Thanks

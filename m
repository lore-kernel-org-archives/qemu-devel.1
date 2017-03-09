Received: from eggs.gnu.org ([2001:4830:134:3::10]:34912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clulG-0006R9-F0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clulD-00007J-C3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:53:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clulD-000072-3G
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 04:53:27 -0500
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16223ebe-e08d-c686-7ff3-a58db88e3a01@redhat.com>
Date: Thu, 9 Mar 2017 17:53:18 +0800
MIME-Version: 1.0
In-Reply-To: <b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>



On 2017=E5=B9=B403=E6=9C=8809=E6=97=A5 16:50, Thomas Huth wrote:
> On 09.03.2017 03:21, Jason Wang wrote:
>>
>> On 2017=E5=B9=B403=E6=9C=8808=E6=97=A5 19:22, Thomas Huth wrote:
>>> On 08.03.2017 11:03, Peter Maydell wrote:
>>>> On 8 March 2017 at 09:26, Thomas Huth <thuth@redhat.com> wrote:
>>>>> But anyway, the more important thing that keeps me concerned is:
>>>>> Someone
>>>>>    once told me that we should get rid of old parameters and interf=
aces
>>>>> (like HMP commands) primarily only when we're changing to a new maj=
or
>>>>> version number. As you all know, QEMU has a lot of legacy options,
>>>>> which
>>>>> are likely rather confusing than helpful for the new users nowadays=
,
>>>>> e.g. things like the "-net channel" option (which is fortunately ev=
en
>>>>> hardly documented), but maybe also even the whole vlan/hub concept =
in
>>>>> the net code, or legacy parameters like "-usbdevice". If we switch =
to
>>>>> version 3.0, could we agree to remove at least some of them?
>>>> I think if we are going to deprecate and remove options we need
>>>> a clear transition plan for doing so, which means at least one
>>>> release where options are "still works, but warn that they
>>>> are going away with pointer to documentation or similar info
>>>> about their replacement syntax", before actually dropping them.
>>> Yes, that's certainly a good idea. But as Daniel suggested in his mai=
l,
>>> I think we should also have the rule that the option should be marked=
 as
>>> deprecated in multiple releases first - so that the users have a chan=
ce
>>> to speak up before something gets really removed (otherwise the optio=
n
>>> could be removed right on the first day after the initial release wit=
h
>>> the deprecation message, so there is no time for the user to notice t=
his
>>> and complain). Not sure whether we need three releases, as Daniel
>>> suggested, though, but if that's common sense, that's fine for me, to=
o.
>>>
>>> Anyway, I've now started a Wiki page where we could track the removal=
 of
>>> deprecated interfaces:
>>>
>>>    http://wiki.qemu-project.org/Features/LegacyRemoval
>>>
>>> Feedback / updates / addition of other legacy interfaces is welcome!
>>>
>>>    Thomas
>>>
>> I think we may want to add mipsnet to the list too. It's kernel driver
>> was removed about 3 years ago.
> But that's still the default network of the "mipssim" machine ...
> is that machine considered as deprecated, too?
>
>   Thomas

I think so, according to [1], it was deprecated.

[1] https://www.linux-mips.org/wiki/MIPSsim

Thanks

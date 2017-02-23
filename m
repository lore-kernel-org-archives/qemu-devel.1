Received: from eggs.gnu.org ([2001:4830:134:3::10]:47770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgvDP-0002sV-Mi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgvDM-0007hn-E1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:21:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cgvDM-0007ha-7a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:21:52 -0500
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
Date: Thu, 23 Feb 2017 16:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>



On 23/02/2017 15:35, Peter Maydell wrote:
> On 23 February 2017 at 12:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>> On 23/02/2017 13:26, Peter Maydell wrote:
>>> On 23 February 2017 at 11:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> On 23/02/2017 12:34, Peter Maydell wrote:
>>>>> We should probably update the doc comment to note that the
>>>>> pointer is to host-endianness memory (and that this is not
>>>>> like normal RAM which is target-endian)...
>>>>
>>>> I wouldn't call it host-endianness memory, and I disagree that normal
>>>> RAM is target-endian---in both cases it's just a bunch of bytes.
>>>>
>>>> However, the access done by the MemoryRegionOps callbacks needs to match
>>>> the endianness declared by the MemoryRegionOps themselves.
>>>
>>> Well, if the guest stores a bunch of integers to the memory, which
>>> way round do you see them when you look at the bunch of bytes?
>>
>> You see them in whatever endianness the guest used.
> 
> I'm confused. I said "normal RAM and this ramdevice memory are
> different", and you seem to be saying they're the same. I don't
> think they are (in particular I think with a BE guest on an
> LE host they'll look different).

No, they look entirely the same.  The only difference is that they go
through MemoryRegionOps instead of memcpy.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dFi1n-00060u-Ch
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dFi1j-0005d9-Ad
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:43 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:33117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dFi1j-0005d2-5T
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:21:39 -0400
Received: by mail-it0-x243.google.com with SMTP id l145so9689893ita.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 07:21:38 -0700 (PDT)
In-Reply-To: <CAFEAcA8wCfDuSbs-+o-D8Sogrfda_U6kSCH0x5SrAGfAiknYyQ@mail.gmail.com>
References: <mailman.73115.1495441935.22737.qemu-devel@nongnu.org>
	<BBC4E515-FE7D-4600-A5CA-BBCE26059415@gmail.com>
	<87efvghzb9.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170524023303.GA12163@pacoca> <20170525200537.GA12666@pacoca>
	<CAFEAcA8wCfDuSbs-+o-D8Sogrfda_U6kSCH0x5SrAGfAiknYyQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A81FD5C7-4D51-4003-B1D9-027D7548862D@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Tue, 30 May 2017 10:21:36 -0400
Subject: Re: [Qemu-devel] [PATCH risu] ppc64: Fix patterns for rotate
 doubleword instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Sandipan Das <sandipandas1990@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, aNikunj A Dadhania <nikunj@linux.vnet.ibm.com>


On May 30, 2017, at 8:01 AM, Peter Maydell wrote:

> On 25 May 2017 at 21:05,  <joserz@linux.vnet.ibm.com> wrote:
>> What do you think about sharing the same ppc64.risu file to ppc
>> and ppc64/ppc64le. Then, instead of:
>>
>> <NAME> PPC64LE 01111...
>>
>> we'd have:
>>
>> <NAME> PPC 01111...
>>
>> So, specific instructions would be:
>>
>> <NAME> PPC64LE 01111...
>> <NAME> PPC64 01111...
>> <NAME> PPC32 01111...
>>
>> It will allow users to select the arch by using patterns like: ./ 
>> risugen
>> --pattern "PPC64*", or --pattern "PPC32*".
>
> I think we should aim to share the files, but that we should
> have a better mechanism than just a convention on the pattern
> name (which is easy to make mistakes with and also makes it
> harder to use the --pattern argument for the purpose it was
> intended for, since you have to combine your desired pattern
> with the pattern to select the right bit of the instruction set).
> This isn't limited to PPC either -- for ARM we'd like to be
> able to mark instructions as ARMv7/ARMv8/present in some
> optional instruction set extension, etc.

Do you want to add an architecture option?

--pattern 'F.*' --arch PPC32

In this example only the instructions that begin with the letter F  
and have PPC32 as an encodingname are used.

>
> We could perhaps do that with an optional field in the
> lines in the risu file to mark what part of the instruction
> set they're in, and a command line argument to select the
> instruction set variant(s) desired.

I thought we already had this feature.

 From the readme file:

insnname encodingname bitfield ... [ [ !blockname ] { blocktext } ]

Isn't the encodingname field the field we could use to select the  
variant we want?


> Another possible approach would be to have the PPC32 insns
> in their own file, and some sort of #include directive to
> pull them into the PPC64 file.
>
> This is all "adding extra features to risu", though, so I
> don't insist it be done.

The #include directive does sound interesting but if you really want  
one PowerPC risu file then Jose's way would be the way to go. Risu as  
it is can handle this.

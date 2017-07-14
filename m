Received: from eggs.gnu.org ([2001:4830:134:3::10]:37085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2UQ-0005ba-La
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2UN-0000dw-AG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:26:46 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2UN-0000cz-42
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:26:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so10319985qte.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:26:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-23-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-B+aChqZBSnGws7RXheEyg+cutaqvXP8qVgNoUgzQAJA@mail.gmail.com>
	<4f304a14-572d-2835-cb0e-9d93c1c6dece@redhat.com>
	<CAFEAcA-vuPxc0GZc4Her1Trtak-RL9wcMR1L9SGRhzGg3wUGEA@mail.gmail.com>
	<55c62a5d-2ac5-4a89-f20a-100b19f8b0e9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <61a76ac4-23f9-7c99-92e5-8097516de2a9@amsat.org>
Date: Fri, 14 Jul 2017 12:26:36 -0300
MIME-Version: 1.0
In-Reply-To: <55c62a5d-2ac5-4a89-f20a-100b19f8b0e9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 22/42] configure: factor out list of
 supported Xen/KVM/HAX targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

what about this RFC series?
http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg02513.html

On 07/10/2017 01:28 PM, Paolo Bonzini wrote:
> On 10/07/2017 18:24, Peter Maydell wrote:
>> On 10 July 2017 at 17:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 10/07/2017 17:49, Peter Maydell wrote:
>>>> On 5 July 2017 at 08:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>> This will be useful when the functions are called, early in the configure
>>>>> process, to filter out targets that do not support hardware acceleration.
>>>>>
>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>
>>>>> +supported_xen_target() {
>>>>> +    test "$xen" = "yes" || return 1
>>>>> +    glob "$1" "*-softmmu" || return 1
>>>>> +    case "${1%-softmmu}:$cpu" in
>>>>> +        arm:arm | aarch64:aarch64 | \
>>>>> +        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
>>>>> +            return 0
>>>>> +        ;;
>>>>
>>>> This says that arm-on-arm and aarch64-on-aarch64 are supported
>>>> Xen targets...
>>>
>>> Hmm, this comes from my old patches.  IIRC the reason for the change,
>>> when it wasn't a change (many conflicts ago) was that Xen folks were
>>> using --disable-tcg because their device model for Xen PV on ARM was
>>> actually an x86_64 QEMU.
>>>
>>> Stefano and Anthony, is this still true?  If so, would it make sense to
>>> add the Xen PV machine type to qemu-system-arm---that is, is it
>>> something you can whip up easily, or should I just remove that line?
>>
>> I think you should just fix configure for the moment, because
>> this patch wasn't supposed to change anything about what we
>> build (AIUI). We can think about changing the Xen PV on ARM
>> build setup as a separate thing if we want to, I suspect it
>> is more invasive than a couple of lines changing in configure.
> 
> Yes, definitely more invasive.
> 
> I'll prepare a fix.
> 
> Paolo
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhEO-0004o4-0I
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhEK-0003gM-OG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:10:23 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:33855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhhEK-0003gF-JO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:10:20 -0400
Received: by mail-qt0-x22c.google.com with SMTP id s6so9489247qtc.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 12:10:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170815163959.6632-1-f4bug@amsat.org>
	<20170815163959.6632-2-f4bug@amsat.org>
	<a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
	<4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
	<CAFEAcA88ygrba_8oGp1vLadJJ9+J66RnDm4HZ4LcdhDq9_GDSA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1717b7b5-3396-4e92-4c30-8b9a0156bddd@amsat.org>
Date: Tue, 15 Aug 2017 16:10:15 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88ygrba_8oGp1vLadJJ9+J66RnDm4HZ4LcdhDq9_GDSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] libqtest: add qtest_accel() to
 avoid warnings when kvm is not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 08/15/2017 03:39 PM, Peter Maydell wrote:
> On 15 August 2017 at 19:27, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 08/15/2017 03:13 PM, Eric Blake wrote:
>>>
>>> On 08/15/2017 11:39 AM, Philippe Mathieu-Daudé wrote:
>>>>
>>>> only warn once about it.
>>>>
>>>> - kernel without kvm:
>>>>
>>>>       # make check-qtest-x86_64
>>>>         GTESTER check-qtest-x86_64
>>>>       Could not access KVM kernel module: No such device
>>>>       qemu-system-x86_64: failed to initialize KVM: No such device
>>>>       qemu-system-x86_64: Back to tcg accelerator
>>>
>>>
>>> How does this differ from what commit 2f6b38d1 was trying to do?
>>
>>
>> I'd say 2f6b38d1 is for common end-user usage while this is for QA/testers
>> usage. If you run N qtests with the same machine arguments, having this
>> warning displayed only once is enough and allow you to focus on the tests
>> output.
> 
> I think I'd rather we just straightforwardly didn't complain at
> all in the 'make check' output. There's no benefit to this
> for all these tests, especially given that they pretty much
> don't care whether they run under KVM or TCG because they're

Oh you mean checking qtest_enabled() within configure_accelerator()? Ok, 
clever :)

> not trying to test that. (If they *are* trying to test KVM
> specific functionality then they should either skip the
> test quietly if KVM isn't present or they should fail it;
> printing useless waffle to the logs isn't helpful IMHO.)
> 
> thanks
> -- PMM
> 

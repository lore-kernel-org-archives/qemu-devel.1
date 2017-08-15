Received: from eggs.gnu.org ([2001:4830:134:3::10]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhgkp-0004Cv-H3
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhgko-0002ji-R8
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:39:51 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhgko-0002hP-Iw
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 14:39:50 -0400
Received: by mail-wm0-x22a.google.com with SMTP id f15so16200045wmg.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 11:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
References: <20170815163959.6632-1-f4bug@amsat.org>
	<20170815163959.6632-2-f4bug@amsat.org>
	<a2773ebe-e841-4f3f-0234-d89e48811336@redhat.com>
	<4837e428-461c-ef00-b584-42e4c22e8fc7@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 19:39:28 +0100
Message-ID: <CAFEAcA88ygrba_8oGp1vLadJJ9+J66RnDm4HZ4LcdhDq9_GDSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/15/2017 03:13 PM, Eric Blake wrote:
>>
>> On 08/15/2017 11:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>> only warn once about it.
>>>
>>> - kernel without kvm:
>>>
>>>      # make check-qtest-x86_64
>>>        GTESTER check-qtest-x86_64
>>>      Could not access KVM kernel module: No such device
>>>      qemu-system-x86_64: failed to initialize KVM: No such device
>>>      qemu-system-x86_64: Back to tcg accelerator
>>
>>
>> How does this differ from what commit 2f6b38d1 was trying to do?
>
>
> I'd say 2f6b38d1 is for common end-user usage while this is for QA/tester=
s
> usage. If you run N qtests with the same machine arguments, having this
> warning displayed only once is enough and allow you to focus on the tests
> output.

I think I'd rather we just straightforwardly didn't complain at
all in the 'make check' output. There's no benefit to this
for all these tests, especially given that they pretty much
don't care whether they run under KVM or TCG because they're
not trying to test that. (If they *are* trying to test KVM
specific functionality then they should either skip the
test quietly if KVM isn't present or they should fail it;
printing useless waffle to the logs isn't helpful IMHO.)

thanks
-- PMM

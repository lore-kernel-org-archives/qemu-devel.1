Received: from eggs.gnu.org ([2001:4830:134:3::10]:33788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fpB4O-0004IO-SR
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fpB4J-0004cB-Vi
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:31:32 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fpB4J-0004by-NB
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:31:27 -0400
Received: by mail-wm0-x244.google.com with SMTP id c14-v6so8491011wmb.4
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 04:31:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-5-quintela@redhat.com>
	<b30ab0a9-8250-b0da-7c2c-c455db0dddcd@redhat.com>
	<87r2j6v5q7.fsf@trasno.org>
	<51fa5967-1e9e-3f43-b79b-4a45930562c6@redhat.com>
	<87a7puuu89.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c4d5eb16-10ee-2339-3e5f-aa90c4bbd9ec@redhat.com>
Date: Mon, 13 Aug 2018 13:31:24 +0200
MIME-Version: 1.0
In-Reply-To: <87a7puuu89.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/22] check: Only test isa-testdev when
 it is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On 10/08/2018 17:17, Juan Quintela wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 10/08/2018 13:08, Juan Quintela wrote:
>>>> Emanuele's qos-test would do this automatically.  It would be nicer to
>>>> convert the whole ISA subsystem to use libqos and qos-test...
>>> Can we get this in until we get some volunteer for that other work?
>>> /me full of things on his plate at the moment.
>>
>> Sure, but since this is RFC, I commented. :)
> 
> I didn't expect less of you O:-)
> 
>> With qos-test, all tests
>> end up in a single binary that is generic for all QEMU targets, and
>> there's no need to synchronize the configuration with the testing.
>>
>> The disadvantage of doing it at the Makefile level is that it relies on
>> the devices being either in all targets or none.  For example
>> CONFIG_ISA_TESTDEV cannot be removed from just
>> default-configs/ppc-softmmu.mak if you are building both a PPC and an
>> x86 target.

Anyway, I'm not opposed to merging this part, it's just that they may be
unnecessary in the future.  The virtio split is more interesting to me,
and I am very happy that you are doing it!

Paolo

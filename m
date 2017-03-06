Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cktqO-0004iL-2A
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cktqK-0005s9-SK
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:42:36 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cktqK-0005rz-L1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 09:42:32 -0500
Received: by mail-wm0-x233.google.com with SMTP id v203so4707405wmg.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 06:42:32 -0800 (PST)
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87k282im0q.fsf@linaro.org>
	<6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
Date: Mon, 06 Mar 2017 14:42:37 +0000
Message-ID: <87innmii02.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com


Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:

> Hi,
>
> On 06.03.2017 14:15, Alex Bennée wrote:
>> I found the virtualbox.iso on your branch but I can't trigger the
>> assert. Running:
>>
>> #!/bin/sh
>>
>> QEMU="$@"
>>
>> ${QEMU} -s -no-kvm -display sdl -m 512 -cpu phenom -nographic -cdrom virtualbox.iso
>>
>> I get:
>>
>> NOVA Microhypervisor v7-2436fe2 (x86_32): Feb 25 2017 17:58:48 [gcc 4.9.2]
>> [init -> log_terminal]
>> [init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550 Quad-Core Processor
>> qemu: fatal: invalid tss type
>
>
>> Which is a guest error?
>
> It's a race which happens in Qemu (not on hardware), so I still
> investigating it within Qemu. Because of that on [0] the commit before
> the virtualbox.iso is one commit to avoid this for the moment in order
> to continue.

How can a single-threaded system emulation race with itself?

>
>>> [0] https://github.com/alex-ab/qemu/commits/genode_svm_issue
>
> Alex.


--
Alex Bennée

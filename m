Received: from eggs.gnu.org ([2001:4830:134:3::10]:35841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eoSFr-0005tI-13
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eoSFp-0007nI-2H
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:08:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eoSFo-0007ma-Me
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:08:04 -0500
Received: by mail-wr0-x242.google.com with SMTP id v65so3276486wrc.11
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 03:08:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <030fbb91-837b-9817-dc87-28dade530cf3@redhat.com>
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
	<CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
	<20180115125933.GA11737@stefanha-x1.localdomain>
	<CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
	<20180220103643.GC19724@stefanha-x1.localdomain>
	<030fbb91-837b-9817-dc87-28dade530cf3@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 21 Feb 2018 11:08:02 +0000
Message-ID: <CAJSP0QVNp-wAG4foPaK+XhAeFTa1iaBtqNKSLBhKOwQHPcXJug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>, Alistair Francis <alistair23@gmail.com>

On Tue, Feb 20, 2018 at 11:13 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 20/02/2018 11:36, Stefan Hajnoczi wrote:
>> === Multi-CPU cluster support for GDB server in QEMU ===
>>
>> There are many examples in modern computing where multiple CPU
>> clusters are grouped together in a single SoC. This is common in the
>> ARM world especially. There are numerous examples such as ARM's
>> big.LITTLE implementations and Xilinx's 4xA53s and 2xR5s on the ZynqMP
>> SoC. The goal of this task is to add support to the GDB server to
>> allow users to debug across these clusters.
>>
>> This is another step towards single binary QEMU as well.
>>
>>  Detailed description of the project.
>>
>> Xilinx has an out of tree implementation that can be used as a
>> starting point. Work will need to be done on top of this to prepare it
>> for upstream submission and to ensure the implementation is more
>> generic.
>>
>> This will mostly involve extending GDB server to tell GDB about
>> different architectures and then allow the user to swap between them.
>>
>> The Xilinx implementation can be seen here:
>> https://github.com/Xilinx/qemu/blob/master/gdbstub.c
>> There has been some steps in preparing the work to go upstream, which
>> can be seen here:
>> https://github.com/Xilinx/qemu/tree/mainline/alistair/gdb
>
> I agree this is interesting.

Thanks!  I have added it to the wiki:

https://wiki.qemu.org/Google_Summer_of_Code_2018#Multi-CPU_cluster_support_for_GDB_server_in_QEMU

Stefan

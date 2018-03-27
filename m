Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0vlU-0000dj-R1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0vlT-0003ey-Ty
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:04:20 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0vlT-0003eo-P0
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:04:19 -0400
Received: by mail-ot0-x241.google.com with SMTP id x6-v6so318158otg.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 14:04:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c586efc7-029d-b98b-727c-fc439239270b@adacore.com>
References: <1521538773-30802-1-git-send-email-frederic.konrad@adacore.com>
	<c586efc7-029d-b98b-727c-fc439239270b@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 22:03:58 +0100
Message-ID: <CAFEAcA8dAuV3KuQS9Eh=75-oijFEfnDAQk++WX8cZwJXOSE3Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] gdbstub: send a termination
 packet instead of crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 27 March 2018 at 10:31, KONRAD Frederic <frederic.konrad@adacore.com> wr=
ote:
> Peter, can this be cherry-picked in 2.12-rc1?
>
> Thanks,
> Fred
>
>
> On 03/20/2018 10:39 AM, KONRAD Frederic wrote:
>>
>> Since the commit:
>> commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>> Date:   Wed Mar 7 14:42:05 2018 +0000
>>
>>      vl: introduce vm_shutdown()
>>
>> GDB crashes when qemu exits (at least on sparc-softmmu):
>> Remote communication error.  Target disconnected.: Connection reset by
>> peer.
>> Quitting: putpkt: write failed: Broken pipe.
>>
>> So send a packet to exit GDB before we exit QEMU:
>> [Inferior 1 (Thread 0) exited normally]
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---

Applied to master, thanks.

-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:54424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gi3P0-0005zq-7S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gi3Oz-0005KC-Bn
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:27:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gi3Oz-0005J0-2B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:27:37 -0500
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
	<8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
	<CABiizERPJa06YNEyUxEAgDaSgjJny4bTa4qpTDCwKzKMn5Ji=Q@mail.gmail.com>
	<0387b8e9-2b4f-ce1a-05df-b508851b84f0@redhat.com>
	<CAMAxoC1m2g3AB6X5u=+L+K1avq36gSHeBRv-nDXobAJNc2d3qA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69559aca-a3e8-bf1e-7622-4b9ebe9f404e@redhat.com>
Date: Fri, 11 Jan 2019 21:27:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAMAxoC1m2g3AB6X5u=+L+K1avq36gSHeBRv-nDXobAJNc2d3qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Metzman <metzman@google.com>
Cc: Max Moroz <mmoroz@google.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On 11/01/19 20:09, Jonathan Metzman wrote:
> Could you clarify what you think the relationship between the qtest
> process, QEMU, and afl-fuzz will look like when fuzzing?
> 
> Is it something like this:
> 1. afl-fuzz mutates a buffer, starts a qtest process, and gives the
> qtest process the mutated buffer.
> 2. The qtest process starts a QEMU process and interacts with QEMU
> process based on the buffer AFL gave it (qtest).
> 3. goto 1
> 
> I don't think this works (under normal circumstances). AFL will think it
> is fuzzing qtest and will not learn about coverage or crashes from qsym.
> There probably are ways to get this working, but I just want to make
> sure I understand.

It should be possible to turn the qtest process into a test
postprocessor, and remove the second process.  It's much harder to
remove the QEMU process as well and turn it into a TestOneInput function.

Paolo

Received: from eggs.gnu.org ([209.51.188.92]:37415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghyp7-0007At-TA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghyp7-0001YL-99
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:34:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghyp7-0001Xy-1Z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:34:17 -0500
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
	<e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
	<CAJSP0QUFrs=rPvcSdNzwjk2Zyc2Sfu81SM_KZsO9djSGK1beUA@mail.gmail.com>
	<CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ebdfb3b-f99b-4dbc-0389-b96b3f9fb633@redhat.com>
Date: Fri, 11 Jan 2019 16:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <CABiizES5O1zGF_7CxnSCfVQL39=Ov0Bf61-U2XwvoS1_xDi2ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Moroz <mmoroz@google.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On 11/01/19 16:04, Max Moroz wrote:
> We usually have a single fuzzing process, it starts with a fuzzing
> engine's main function and is calling=C2=A0LLVMFuzzerTestOneInput with
> various inputs and keep mutating them based on the coverage feedback.
> Running a second process which you don't care too much about might be
> fine, but the fuzzing process should be "replacing" or should I say
> "imitating" the process whose coverage you're interested in.

What do you mean by replacing or imitating?

Avoiding fork would probably be hard.  I'm mostly afraid that some state
guest state is not resetted properly across runs, and this would result
in non-reproducible crashes.

It seems to me that the task can be approached with AFL and a test case
postprocessor to generate the qtest input; however, my knowledge of
libFuzzer is very very limited.

Paolo

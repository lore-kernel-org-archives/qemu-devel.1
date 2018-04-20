Received: from eggs.gnu.org ([2001:4830:134:3::10]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9ZUz-0006Gf-6Q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9ZUy-0002IZ-B3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:01 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9ZUy-0002HR-3T
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:07:00 -0400
Received: by mail-ot0-x22b.google.com with SMTP id 77-v6so4264869otd.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:07:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7c7d48b8-dc72-9c22-85e5-4dead88c991e@redhat.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-13-peter.maydell@linaro.org>
	<7c7d48b8-dc72-9c22-85e5-4dead88c991e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 18:06:39 +0100
Message-ID: <CAFEAcA9E4K=EUxPGHALp4reqSL3AYojBre97N+zsUfPdFCTdng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 12/13] vl.c: Remove compile time limit on
 number of serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 20 April 2018 at 17:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 20/04/2018 16:52, Peter Maydell wrote:
>> Instead of having a fixed sized global serial_hds[] array,
>> use a local dynamically reallocated one, so we don't have
>> a compile time limit on how many serial ports a system has.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Just one question, would it make sense to use a GPtrArray instead?

Hmm. Looking at the GPtrArray API there's no API for
"tell me the length of this pointer array", so we'd still
have to do the manual bookkeeping for that. And we don't
need most of the functionality it provides. So it doesn't
really seem like it gains us much over g_renew() to me.

thanks
-- PMM

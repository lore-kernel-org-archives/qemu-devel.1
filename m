Received: from eggs.gnu.org ([2001:4830:134:3::10]:56621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYa74-0004zM-MS
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYa73-0000Ga-Po
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:54 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYa73-0000GU-KD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:12:53 -0500
Received: by mail-vk0-x230.google.com with SMTP id x75so238834207vke.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 07:12:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<b1e5af37-6547-e688-0365-2bb1bfe45954@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 15:12:32 +0000
Message-ID: <CAFEAcA-UPQrgq8h1LbqsUWP-MKwkOBLsAk0R0u0YuSfyA=nQAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 31 January 2017 at 15:03, Eric Blake <eblake@redhat.com> wrote:
> On 01/31/2017 08:43 AM, Michael S. Tsirkin wrote:
>> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
>> if the C file including that header happens to have
>> QEMU_BUILD_BUG_ON at the same line number.
>>
>> Fix using a widely available extension: __COUNTER__.
>
> gcc 4.3 and later; clang documents it but doesn't say when it was added.
>
>> If unavailable, provide a stub.
>
> What fails in our build farm if we don't provide the stub? Can we just
> require that our compiler is new enough to have __COUNTER__, or will
> that break some of our existing targets?

I think the problem is not so much our build farm (which is
I think all recent enough to postdate introduction of
__COUNTER__) but the probability of there being users
out there who are still using older compilers to build
QEMU releases. We don't need to enforce compile time
asserts on those old compilers but given that it's
trivial to avoid actually breaking the build for them,
why not provide the do-nothing fallback?

thanks
-- PMM

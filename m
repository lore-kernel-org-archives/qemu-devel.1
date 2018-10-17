Received: from eggs.gnu.org ([2001:4830:134:3::10]:56017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCql2-00013z-V9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCqkt-00006J-S0
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:41:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCqkt-00005F-K2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 14:41:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id u22so27193088ota.12
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 11:41:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
	<d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Oct 2018 19:40:51 +0100
Message-ID: <CAFEAcA_gyQvmq48QquNiFhGef-FWPeDKRUSk3wf7hS=_=xm_XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On 17 October 2018 at 18:38, Cleber Rosa <crosa@redhat.com> wrote:
>
>
> On 10/17/18 12:29 PM, Eduardo Habkost wrote:
>> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
>>> So, why does the test code need to care? It's not clear
>>> from the patch... My expectation would be that you'd
>>> just test all the testable target architectures,
>>> regardless of what the host architecture is.
>>
>> I tend to agree.  Maybe the right solution is to get rid of the
>> os.uname().  I think the default should be testing all QEMU
>> binaries that were built, and the host architecture shouldn't
>> matter.

Yes, looking at os.uname() also seems like an odd thing
for the tests to be doing here. The test framework
should be as far as possible host-architecture agnostic.
(For some of the KVM cases there probably is a need to
care, but those are exceptions, not the rule.)

> I'm in favor of exercising all built targets, but that seems to me to be
> on another layer, above the test themselves. This change is about the
> behavior of a test when not told about the target arch (and thus binary)
> it should use.

At that level, I think the right answer is "tell the user
they need to specify the qemu executable they are trying to test".
In particular, there is no guarantee that the user has actually
built the executable for the target that corresponds to the
host, so it doesn't work to try to default to that anyway.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9aGT-0001W5-9b
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9aGP-0007ow-9b
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:56:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37472 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9aGP-0007o0-3w
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:56:01 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-13-peter.maydell@linaro.org>
	<7c7d48b8-dc72-9c22-85e5-4dead88c991e@redhat.com>
	<CAFEAcA9E4K=EUxPGHALp4reqSL3AYojBre97N+zsUfPdFCTdng@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fed0635-d757-ca96-6d71-9daa8fab7e14@redhat.com>
Date: Fri, 20 Apr 2018 19:55:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9E4K=EUxPGHALp4reqSL3AYojBre97N+zsUfPdFCTdng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 20/04/2018 19:06, Peter Maydell wrote:
> On 20 April 2018 at 17:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 20/04/2018 16:52, Peter Maydell wrote:
>>> Instead of having a fixed sized global serial_hds[] array,
>>> use a local dynamically reallocated one, so we don't have
>>> a compile time limit on how many serial ports a system has.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Just one question, would it make sense to use a GPtrArray instead?
> 
> Hmm. Looking at the GPtrArray API there's no API for
> "tell me the length of this pointer array", so we'd still
> have to do the manual bookkeeping for that. And we don't
> need most of the functionality it provides. So it doesn't
> really seem like it gains us much over g_renew() to me.

GPtrArray is a public struct, so you can use array->pdata and
array->len.  There is a disadvantage, which is that you lose type-safety
on dereference.

Paolo

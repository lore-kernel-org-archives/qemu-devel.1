Received: from eggs.gnu.org ([2001:4830:134:3::10]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCpmi-0006IK-O9
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gCpmd-0002tJ-RG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gCpmd-0002su-KE
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:38:59 -0400
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<20181017162944.GF31060@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <d5f32475-df5b-0c5c-591f-5fae8e641c11@redhat.com>
Date: Wed, 17 Oct 2018 13:38:53 -0400
MIME-Version: 1.0
In-Reply-To: <20181017162944.GF31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>



On 10/17/18 12:29 PM, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 01:34:41PM +0100, Peter Maydell wrote:
>> On 17 October 2018 at 00:22, Cleber Rosa <crosa@redhat.com> wrote:
>>> The host arch name is not always the target arch name, so it's
>>> necessary to have a mapping.
>>>
>>> The configure scripts contains what is the authoritative and failproof
>>> mapping, but, reusing it is not straightforward, so it's replicated in
>>> the acceptance tests supporting code.
>>
>> So, why does the test code need to care? It's not clear
>> from the patch... My expectation would be that you'd
>> just test all the testable target architectures,
>> regardless of what the host architecture is.
> 
> I tend to agree.  Maybe the right solution is to get rid of the
> os.uname().  I think the default should be testing all QEMU
> binaries that were built, and the host architecture shouldn't
> matter.
> 

I'm in favor of exercising all built targets, but that seems to me to be
on another layer, above the test themselves. This change is about the
behavior of a test when not told about the target arch (and thus binary)
it should use.

> That said, I think the dictionary is a nice temporary workaround
> until we fix that.
> 

I think even with a switch towards "use the target(s) built", we'd still
need to pick one at the test execution level.  A job may include running
the same test with different targets, though.  So, I'm not sure this
would be just temporary.

- Cleber.

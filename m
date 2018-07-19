Received: from eggs.gnu.org ([2001:4830:134:3::10]:38983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg48r-0003Od-Ux
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg48n-0006hG-GT
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:18:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fg48n-0006gX-7x
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:18:25 -0400
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	<87a7qnk9qa.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c00a41f7-65eb-646a-73e4-2424140d04fb@redhat.com>
Date: Thu, 19 Jul 2018 10:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <87a7qnk9qa.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Why do we typedef every struct on QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19.07.2018 08:42, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On 17 July 2018 at 20:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> I have been looking at patches that touch typedefs.h and
>>> wondering: why do we make typedefs.h necessary at all?  Why do we
>>> always add typedefs for every struct and union type in QEMU?
>>>
>>> Why do we prefer to write this:
>>>
>>> ----- qemu/typedefs.h:
>>> typedef struct SomeType SomeType;
>>> ----------------------
>>>
>>> ----- qemu/somecode.h:
>>> #include <qemu/typedefs.h>
>>>
>>> int some_function(SomeType *a);
>>> ----------------------
>>>
>>>
>>> ...instead of simply writing this:?
>>>
>>> ----- qemu/somecode.h:
>>> struct SomeType;
>>> int some_function(struct SomeType *a);
>>> ----------------------
>>>
>>> Is the maintenance burden of typedefs.h worth it?
>>
>> Personally I don't like typing "struct " all the time
>> when I'm using the type...
> 
> For a different point of view (which I happen to share), see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=024ddc0ce1049298bd3cae60ae45d9c5f0fb8b9c#n318

FWIW, as somebody who also has to write some kernel code occasionally,
I'd also prefer if we could get closer to the kernel coding style here
again.

That would also avoid problems like this that we used to hit regularly:

 https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg02695.html

(well, that problem will likely go away automatically since we now don't
support these distros anymore, but still...)

 Thomas

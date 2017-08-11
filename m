Received: from eggs.gnu.org ([2001:4830:134:3::10]:53290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dg8iI-0007gd-5k
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dg8iF-0006A6-0K
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 08:06:50 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org> <87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
	<20170810104604.342af354.cohuck@redhat.com>
	<CAFEAcA-GP53g+vfgDH1mNQnPHcrNULb+gkQk4JeJhb=8UCt+YA@mail.gmail.com>
	<20170810122520.48403984.cohuck@redhat.com>
	<20170811075455.GC27391@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ac44263-dc9a-b16e-df10-09253b566b1b@redhat.com>
Date: Fri, 11 Aug 2017 14:06:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170811075455.GC27391@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 11/08/2017 09:54, Fam Zheng wrote:
> On Thu, 08/10 12:25, Cornelia Huck wrote:
>>> I think the UI (giving no consideration to how we might implement
>>> this!) would ideally be something like:
>>>  * if anybody mails a patch which touches an "unmaintained" file,
>>>    a robot should send a reply along the lines of "thanks for the
>>>    patch; unfortunately file X is not maintained so it may be
>>>    tricky to get patch review for this. You'll need to be
>>>    persistent and do more of the legwork than if you were patching
>>>    a file that did have an active maintainer" so contributors
>>>    know when they've wandered into the swamp
>>
>> That's a good idea.
>>
>>>  * some mechanism for easily finding patches to unmaintained
>>>    files which haven't got review yet, so that anybody with some
>>>    spare time and interest can move some of them along (the idea
>>>    being to spread the load rather than trying to designate a
>>>    particular "owner" for this headache)
>>
>> Can maybe patchew set a special flag for patches that only touch
>> unmaintained files?
> 
> Interesting idea. We have a number of patch status tracking feature requests for
> patchew already. We can tackle them one by one. (The next priority is implement
> "merged".)

Do you use github issues?

Paolo

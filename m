Received: from eggs.gnu.org ([2001:4830:134:3::10]:46457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvQEg-0005RC-0k
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dvQEb-0001oH-2J
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:51:25 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:48162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dvQEa-0001no-Rf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:51:20 -0400
Received: by mail-wr0-f170.google.com with SMTP id 108so1253411wra.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:51:20 -0700 (PDT)
References: <CAEgYsbFZGT3GARy7LEkU7uvb4__Xg6AdA2oU9wHtctmKhewkmw@mail.gmail.com>
	<CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e9861b1a-296c-6233-4e47-6af3f8dc37e7@redhat.com>
Date: Fri, 22 Sep 2017 17:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_UDk4cwtq4G_XArGCH4LC3hLUnmVHO28RJnm+7=YD_BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] SunOS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Peter Tribble <peter.tribble@gmail.com>
Cc: Kamil Rytarowski <n54@gmx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22/09/2017 14:05, Peter Maydell wrote:
> On 20 September 2017 at 19:50, Peter Tribble <peter.tribble@gmail.com> wrote:
>> To introduce myself: I'm a member of the illumos community (the successor
>> to OpenSolaris, to those unfamiliar with us), and I maintain my own illumos
>> distribution.
>>
>> Having seen the scary 'SUPPORT FOR THIS HOST OS WILL GO AWAY'
>> message, I'm reaching out to see what needs to be done so that support for
>> SunOS (not just illumos, I include Oracle's Solaris in the same family)
>> needs to be kept and, where possible, enhanced.
>>
>> I'm willing to act as a contact in this effort, and can work with others in
>> the illumos community to see if there are other resources we can bring to bear.
> 
> Hi; thanks for getting in touch with us. Kamil Rytarowski (who I've
> cc'd) is also interested in keeping Solaris-variant support working.
> 
> Essentially what we need as upstream is:
>  * access to a machine which we can use for our continuous
>    integration build testing, so we don't break compile
>    support for the platform. This is ideally a machine that
>    somebody else admins and we just use (because we don't
>    want to become solaris/illumos admins ;-)), but failing
>    that, instructions on how to get a VM running under
>    KVM on Linux would also be OK (that's how we've ended
>    up handling the BSDs)

I would even reverse the order since now we're handling the BSDs using
the VM test infrastructure.  Let's say having both would be best.

Paolo

>  * somebody to look at the places where 'make && make check'
>    currently fails and submit upstream patches for them. Kamil
>    has been doing a great job here but would probably
>    appreciate extra help :-)
>  * somebody who's willing to be listed in our MAINTAINERS file
>    as maintaining the port, so we can ask them questions if/when
>    any platform-specific issues come up in future
> 
> Overall we're happy to continue to support hosts that people
> are still using -- we just want to avoid blindly maintaining
> code for platforms we can't test and where we don't have
> any idea if anybody's even using it (for instance we just
> dropped the support for AIX and for Itanium CPUs...)
> 
> thanks
> -- PMM
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cniCs-0006yA-3l
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cniCm-00044a-48
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cniCl-00044L-UP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:53:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170314081312.GB13140@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 14 Mar 2017 16:13:12 +0800")
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
Reply-To: quintela@redhat.com
Date: Tue, 14 Mar 2017 09:53:17 +0100
Message-ID: <871su0utmq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] KVM call for 2017-03-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>

Stefan Hajnoczi <stefanha@gmail.com> wrote:

>>   - on the "VM support" side, QEMU is more used because it's the only
>>     production-quality option in this space, rather than because its
>>     users love it. (cf the Google choice to replace it.) It's also got
>>     a pretty poor security record. It wouldn't be too surprising if
>>     some time in the next five years somebody writes a replacement in
>>     a safer language (perhaps also targeting only the VM support role)
>>     and it got enough mindshare and takeup to eclipse QEMU.
>>     [Is it too early/daft to think about prototyping being able to
>>      write QEMU device emulation in Rust ?]
>
> We can move to a safer language starting with the device emulation
> layer.  Keep the rest in C for now.  Use a language that has good C
> interoperability or a convenient foreign function interface.
>
> Start writing new device models in the new language.  Convert existing
> devices if they are good candidates, like the e1000 NIC emulation.
>
> The minimum requirements for the new language:
> 1. Does it support the host operating systems that QEMU runs on?
> 2. Does it support the host architectures that QEMU runs on?
> 3. Is it safer than C even when writing code to operate on guest RAM
>    (i.e. it's no good if you must use unsafe primitives to do the
>    systems programming tasks that QEMU requires)?
> 4. Is C interoperability convenient and high performance?

That is one approach.  Other is to move to a "safer" language the parts
that are not performance sensitive.  Our command line parsing and device
object done is C just make things much, much worse for no gain.  A
language better for dealing with strings and things like that?

Later, Juan.

PD.  And before anyone asked, a language that is not able to get right:
   a = "hello"
   b = "world"
   c = a + " " + b

   (put any syntax you like) without having to wonder about memory
   allocation, sizes, etc is not really valid to work with strings IMHO.
   

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fg4IE-0006ZS-91
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fg4IB-0002VH-5V
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:28:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fg4IA-0002V9-Uq
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:28:07 -0400
References: <20180717195028.GA6691@localhost.localdomain>
	<CAFEAcA-pPsvfn7ARu_pn0HH03rZh05fLP=wr+p=hx5douSf7vA@mail.gmail.com>
	<87a7qnk9qa.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3492ade0-96bb-5821-f75d-0ca437aaf87d@redhat.com>
Date: Thu, 19 Jul 2018 10:28:03 +0200
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 19/07/2018 08:42, Markus Armbruster wrote:
> For a different point of view (which I happen to share), see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=024ddc0ce1049298bd3cae60ae45d9c5f0fb8b9c#n318

I think that does not entirely apply to us:

> It's a **mistake** to use typedef for structures and pointers. When you see a
> 
> .. code-block:: c
> 
> 
> 	vps_t a;
> 
> in the source, what does it mean?
> In contrast, if it says
> 
> .. code-block:: c
> 
> 	struct virtual_container *a;
> 
> you can actually tell what ``a`` is.

We can actually tell that "a" is a struct in QEMU, because that's the
only place where we use CamelCase identifiers (typedefs for integer
types use lowercase names).  I agree with Linus that it's bad to use
typedef for pointers.

Thanks,

Paolo

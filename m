Received: from eggs.gnu.org ([2001:4830:134:3::10]:43420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQZFh-0003Jw-7M
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dQZFe-0000tG-GB
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dQZFe-0000sa-9n
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:12:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
Date: Thu, 29 Jun 2017 15:12:49 +0200
In-Reply-To: <CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
	(Peter Maydell's message of "Thu, 29 Jun 2017 10:05:13 +0100")
Message-ID: <87vanfuecu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Khem Raj <raj.khem@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
>> The ucontext_t type had a tag struct ucontext until now
>> but newer glibc will drop it so we need to adjust and use
>> the exposed type instead
>
> If true this seems like a bug in glibc to break
> existing working programs, and it should be fixed there...

I'd support that notion.  However, SUSv2 documents ucontext_t, not
struct ucontext.  Using the former instead of the latter makes sense as
a portability improvement, doesn't it?

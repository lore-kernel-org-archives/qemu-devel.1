Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dY6Iu-0005MG-JV
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dY6It-0004oL-Qs
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:24 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:43360
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dY6It-0004ne-Je
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:23 -0400
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
	<bb8781a1-602b-d77d-a103-6f8d23d7ff5f@adacore.com>
	<20170719122943.GJ2103@work-vm>
	<3fe1df9e-6b49-621f-53b6-271fd2f77305@adacore.com>
	<CAFEAcA83H+9b2t2MhE0wDCDK_-DuPSuBZrzbQrevhjCh1SEBDA@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8feb72ef-243c-fc45-ad16-6af92796e54f@adacore.com>
Date: Thu, 20 Jul 2017 09:55:07 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83H+9b2t2MhE0wDCDK_-DuPSuBZrzbQrevhjCh1SEBDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 07/19/2017 06:25 PM, Peter Maydell wrote:
> On 19 July 2017 at 17:22, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
>> Scary.. Yes your right. I still think it doesn't need to be
>> migrated.. But how..
>>
>> BTW taking a look at this I found the comment below which seems
>> to implies that the content won't be migrated?
> 
> That's a comment that I added just recently under a
> slight misapprehension. Once we've figured out what
> the right thing is we can fix it, or make the code do
> what the comment says.
> 
> The actual current situation is "this function does nothing
> to ensure the RAMBlock is correctly migrated, so if you
> do nothing then you'll wind up with migration being silently
> broken, if more than one thing is doing this at once in
> the system, but if one and only one RAMblock is in this
> situation then it'll work by luck". Which is definitely not
> behaviour we are doing on purpose :-)
> 

Ok thanks!
Fred

> thanks
> -- PMM
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez62q-0005pf-Sq
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ez62m-0003Lb-Uq
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:38:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ez62m-0003LP-QS
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 15:38:36 -0400
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<2ced1950-9cbb-9230-578a-162741713ff7@amsat.org>
	<CAHNT7NsnE2ci24E8JPFRZUda2E1ZMrQaa1hyrB0NpePWp7te8A@mail.gmail.com>
	<CAFEAcA8Fx-ZtdaLk10mu_yczk2+NOko28nFZwDM6Ppm+EwpzPQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb7beba3-8c31-4597-5dea-31386f34d391@redhat.com>
Date: Thu, 22 Mar 2018 14:38:17 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Fx-ZtdaLk10mu_yczk2+NOko28nFZwDM6Ppm+EwpzPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Michael Clark <mjc@sifive.com>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, QEMU Developers <qemu-devel@nongnu.org>

On 03/22/2018 02:10 PM, Peter Maydell wrote:

[snip lots of good advice]

> Code review isn't only about "does this behave as the
> secification requires". It can also catch:
>   * simple logic bugs
>   * places where the code is more complicated than it needs to be
>   * style issues
>   * places where a QEMU utility routine could have been used
>   * misunderstandings about QEMU internal APIs
>   * memory leaks or memory corruption bugs

     * grammar/typo fixes in comments/documentation/user-visible error 
strings

> Review by somebody who is familiar with QEMU is just as useful
> as review by somebody familiar with the target ISA.

Indeed.  Not everyone is an expert on every subject, but the more people 
that get involved, each in their own area of expertise, the wider the 
review coverage can be for a better end product.  And I'm very much okay 
with a reviewer stating up front "I'm only commenting on aspect XYZ, but 
will leave the rest of your patch to someone more familiar with ABC" - 
even that admission of a partial review is still helpful.

> If your queue of unsubmitted or unreviewed patches is steadily
> getting longer then something is going wrong; you should be
> aiming for it to be as short as possible.

More on this point - typically, the review process is OFTEN the long 
pole in open source projects, where patches are submitted faster than 
reviewers can keep up.  While the following advice is by no means a 
requirement that everyone should follow, my personal goal is that I 
review at least two patches for every one that I submit, to help 
alleviate the review bottleneck.  And doing so has made ME a better 
programmer, as I get to explore coding paradigms and portions of the 
tree that I was previously unfamiliar with.

Furthermore, providing reviews to other's patches in addition to writing 
your own patches has some nice benefits: you gain some name recognition 
in the community, and it is obvious that you care more about the project 
as a whole than just about getting your stuff merged.  That in turn 
tends to have an interesting effect that your own patches get reviewed 
faster.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

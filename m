Received: from eggs.gnu.org ([2001:4830:134:3::10]:39771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybcw-0006T0-FI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybcr-0008A8-Ce
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:09:54 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eybcr-00089u-5C
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:09:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id s18so4749339wrg.9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 04:09:49 -0700 (PDT)
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81a5f105-5225-556a-a226-0bdfbf919095@redhat.com>
Date: Wed, 21 Mar 2018 12:09:46 +0100
MIME-Version: 1.0
In-Reply-To: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 21/03/2018 08:05, Thomas Huth wrote:
> On 20.03.2018 23:25, Michael Clark wrote:
>> The following changes since commit f1a63fcfcd92c88be8942b5ae71aef9749a4f135:
>>
>>   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
>>
>> are available in the git repository at:
>>
>>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
>>
>> for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679:
>>
>>   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:13 -0700)
>>
>> ----------------------------------------------------------------
>> This is a series of spec conformance bug fixes and code cleanups
>> that we would like to get in before the QEMU 2.12 release.
> 
>  Hi Michael,
> 
> for future PULL request, could you please send out all patches again
> that should be pulled, and not send the cover letter alone? I.e. do a
> "git format-patch --subject-prefix PULL ..." and then replace the
> contents of the cover letter with the output of "git request-pull".
> 
> ... this is how all other maintainers are sending PULL requests (at
> least as far as I know) and this way everybody gets a very final chance
> to have a look at the patches in their final state (it does not happen
> very often that someone replies to such patches, but in some rare cases
> we already found problems this way).

In fact, I already explained on the mailing list that this patch:

      RISC-V: Hold rcu_read_lock when accessing memory

is fixing the wrong place, so please remove it from the pull request too.

Thanks,

Paolo

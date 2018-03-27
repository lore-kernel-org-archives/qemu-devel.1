Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0l7u-0004T1-0a
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0l7s-0004P3-Op
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:46 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:35659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0l7s-0004Ow-JE
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:42:44 -0400
Received: by mail-ot0-x234.google.com with SMTP id r30-v6so23799518otr.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 02:42:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<CAFEAcA_4MnAhSyRc2nhaWtrDvLEGP_eEDXu+tzdmOHY_Sp2oqQ@mail.gmail.com>
	<CAHNT7Nt3XZi1aXBe79SrPjOW_4DEBbRweyTRZzhmHRgH5rqJPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 10:42:23 +0100
Message-ID: <CAFEAcA9k2e76o+DXEu0NN770o5ZDwY4g2UKnSxA2VhwRBq6F=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [patches] Re: [PATCH v6 00/26] RISC-V: Fixes and
 cleanups for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: RISC-V Patches <patches@groups.riscv.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 26 March 2018 at 19:07, Michael Clark <mjc@sifive.com> wrote:
> On Sun, Mar 25, 2018 at 8:03 AM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
>> Hi. It looks to me like a fair number of these patches
>> are already reviewed, so we don't need to wait on the
>> rest being reviewed to get those into master.
>>
>> My suggestion is that you send a pullrequest now for the
>> reviewed patches, and send a patchset for review for the
>> new ones or the ones that still need review. (If there
>> are patches that are reviewed but depend on earlier ones
>> that need to go in set 2 then they go in set 2 as well.)
>>
>
> Unfortunately the reviewed patches are mostly just minor cleanups. It's
> almost not worth making a PR for them as *none* of the reviewed patches are
> actually bug fixes. They are things like removing unused definitions or
> replacing hardcoded constants with enums, removing unnesscary braces, etc,
> etc

No, what I'm saying is that it is very much worth it. You
want to shorten the size of your set of uncommitted patches.
Large pull requests increase the chances that some
random thing in there hits a compile issue or other minor
problem that means I have to bounce the whole thing and
you need to respin it. Smaller ones are more likely to
go in. This is especially true during the freeze part
of the release cycle, when we do an RC every week -- having
patches in earlier RCs reduces the risk. I do not want
to still see a 26 patch set unapplied by the time we get
to RC3 or RC4.

Or if you don't think the minor cleanups are worth putting
into 2.12, that's fine too (it's a submaintainer judgement
you can make). In that case you can put those to one side
and trim down the size of the patchset you're sending out
(ie make it an 01/11...11/11 patchset or whatever).

> 26 patches is a lot to still be carrying around much
>> beyond rc1, so I would like to see the size of this set
>> reducing rather than increasing. As the release process
>> moves forward the bar for "can this still go in" gradually
>> goes up -- by about rc3 it is at about "is this a
>> really critical bug or regression from the previous
>> release".
>>
>> (Also something seems to have unhelpfully decided to eat
>> or delay about half of your emails in this patchset :-(
>> Patchew only sees 14 of the 26. Our mailing list server
>> does seem to do that occasionally so that would be my
>> first guess at the culprit, but it's possible it's
>> something at your end.)
>>
>
> Phil asked that I send out only the patches that don't have review, so
> that's what I did.

I think that was a miscommunication. You should always
send out entire patchsets, not just parts of one.
Philippe said:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06038.html
"You could have sent a PR of the reviewed patches, and
respin the unreviewed patches separately.", which is the
same thing I'm suggesting here.

thanks
-- PMM

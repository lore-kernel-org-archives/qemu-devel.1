Received: from eggs.gnu.org ([209.51.188.92]:35229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsFw-0004fv-OL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwsFv-0002kH-En
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwsFv-0002k1-8C
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:35:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so10084702wmh.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:35:31 -0800 (PST)
References: <20190221155359.8247-1-davidkiarie4@gmail.com>
	<aac6b5d0-ecdd-577c-5b38-8c875ea1dffc@redhat.com>
	<6cdbaddf-57d8-3333-c9a0-7c5f46cecab7@siemens.com>
	<87h8cxxf2o.fsf@dusky.pond.sub.org>
	<3c29b265-7add-61e2-2beb-6601d5ad02dd@siemens.com>
	<87y369vzdr.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d3bf1cce-0146-af2b-ca83-3cfb1ef29c86@redhat.com>
Date: Thu, 21 Feb 2019 18:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <87y369vzdr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/1] snip my name and email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: alexaltea123@gmail.com, David Kiarie <davidkiarie4@gmail.com>, qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com

On 2/21/19 6:13 PM, Markus Armbruster wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 21.02.19 17:48, Markus Armbruster wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 21.02.19 17:05, Eric Blake wrote:
>>>>> On 2/21/19 9:53 AM, David Kiarie wrote:
>>>>>> the occurrence of my name and email on the files below may have led to
>>>>>> some confusion in the reporting of a few recent bugs.
>>>>>>
>>>>>> i have therefore choosen to snip it.
>>>>>
>>>>> Dropping an email from the copyright line makes sense; dropping the
>>>>> Copyright declaration altogether is a bit odd (the GPL works only in
>>>>> tandem with a copyright assertion) - but as you are the author of the
>>>>> line and copyright holder of your contributions, I am not in a position
>>>>> to say you are wrong in removing it, only that it looks odd.
>>>>>
>>>>
>>>> Yeah, indeed.
>>>>
>>>> David, also note that you probably have been addressed because
>>>> scripts/get_maintainer.pl will look into the git history of files that
>>>> some patch addresses and pick up significant and/or recent
>>>> contributors from there.
>>>
>>> MAINTAINERS covers these files, so the most common use of
>>> get_maintainer.pl won't list anyone not listed there:
>>>
>>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch]
>>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>>>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
>>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>>
>>> David's contributions have aged out of --git:
>>>
>>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git
>>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commit_signer:12/7=100%,commit_signer:10/5=100%)
>>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>>>      Richard Henderson <rth@twiddle.net> (maintainer:X86,commit_signer:1/7=14%)
>>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>>>      Peter Xu <peterx@redhat.com> (commit_signer:6/7=86%,commit_signer:4/5=80%)
>>>      Brijesh Singh <brijesh.singh@amd.com> (commit_signer:5/7=71%,commit_signer:4/5=80%)
>>>      "Alex Bennée" <alex.bennee@linaro.org> (commit_signer:1/7=14%)
>>>      Jan Kiszka <jan.kiszka@siemens.com> (commit_signer:1/5=20%)
>>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>>
>>> However, --git-blame still lists him:
>>>
>>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git-blame
>>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86,commits:7/24=29%)
>>>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86,commits:7/24=29%)
>>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commits:26/24=100%,commits:14/8=100%)
>>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>>      David Kiarie <davidkiarie4@gmail.com> (authored lines:1176/1645=71%,authored lines:274/373=73%)
>>>      Brijesh Singh <brijesh.singh@amd.com> (authored lines:403/1645=24%,authored lines:93/373=25%,commits:4/8=50%)
>>>      Peter Xu <peterx@redhat.com> (commits:10/24=42%,commits:4/8=50%)
>>>      David Gibson <david@gibson.dropbear.id.au> (commits:7/24=29%)
>>>      Jan Kiszka <jan.kiszka@siemens.com> (commits:1/8=12%)
>>>      Prasad J Pandit <pjp@fedoraproject.org> (commits:1/8=12%)
>>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>>
>>> --help admonishes:
>>>
>>>    Using "--git-blame" is slow and may add old committers and authors
>>>        that are no longer active maintainers to the output.
>>>
>>>>                           There should be some opt-out statement from
>>>> that, but I don't recall how.
>>>
>>> I don't think get_maintainer.pl supports a blacklist of people who don't
>>> want to be pestered anymore.
>>>
>>
>> # cat linux/.get_maintainer.ignore
>> Christoph Hellwig <hch@lst.de>
>>
>> That's why I remembered it vaguely.
> 
> Ah!
> 
> commit 435de0782b658c993350049e853ea9a8795df4e2
> Author: Joe Perches <joe@perches.com>
> Date:   Thu Jun 25 15:01:50 2015 -0700
> 
>     get_maintainer.pl: add .get_maintainer.ignore file capability
>     
>     Some people prefer not to be cc'd on patches.  Add an ability to have a
>     file (.get_maintainer.ignore) with names and email addresses that are
>     excluded from being listed except when specifically listed as a maintainer
>     in a section.
>     
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Can we resync with the kernel's script to get this feature?  Or should
> we cherry-pick it?

I think we are out-of-sync and only cherry-picking.

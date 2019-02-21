Received: from eggs.gnu.org ([209.51.188.92]:59041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwruk-0000n7-Rv
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwrui-0006j9-I5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:13:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gwrui-0006Yv-9U
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 12:13:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190221155359.8247-1-davidkiarie4@gmail.com>
	<aac6b5d0-ecdd-577c-5b38-8c875ea1dffc@redhat.com>
	<6cdbaddf-57d8-3333-c9a0-7c5f46cecab7@siemens.com>
	<87h8cxxf2o.fsf@dusky.pond.sub.org>
	<3c29b265-7add-61e2-2beb-6601d5ad02dd@siemens.com>
Date: Thu, 21 Feb 2019 18:13:04 +0100
In-Reply-To: <3c29b265-7add-61e2-2beb-6601d5ad02dd@siemens.com> (Jan Kiszka's
	message of "Thu, 21 Feb 2019 17:52:24 +0100")
Message-ID: <87y369vzdr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] snip my name and email
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, alexaltea123@gmail.com, David Kiarie <davidkiarie4@gmail.com>

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 21.02.19 17:48, Markus Armbruster wrote:
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> On 21.02.19 17:05, Eric Blake wrote:
>>>> On 2/21/19 9:53 AM, David Kiarie wrote:
>>>>> the occurrence of my name and email on the files below may have led to
>>>>> some confusion in the reporting of a few recent bugs.
>>>>>
>>>>> i have therefore choosen to snip it.
>>>>
>>>> Dropping an email from the copyright line makes sense; dropping the
>>>> Copyright declaration altogether is a bit odd (the GPL works only in
>>>> tandem with a copyright assertion) - but as you are the author of the
>>>> line and copyright holder of your contributions, I am not in a position
>>>> to say you are wrong in removing it, only that it looks odd.
>>>>
>>>
>>> Yeah, indeed.
>>>
>>> David, also note that you probably have been addressed because
>>> scripts/get_maintainer.pl will look into the git history of files that
>>> some patch addresses and pick up significant and/or recent
>>> contributors from there.
>>
>> MAINTAINERS covers these files, so the most common use of
>> get_maintainer.pl won't list anyone not listed there:
>>
>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch]
>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> David's contributions have aged out of --git:
>>
>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git
>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commit_signer:1=
2/7=3D100%,commit_signer:10/5=3D100%)
>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>>      Richard Henderson <rth@twiddle.net> (maintainer:X86,commit_signer:1=
/7=3D14%)
>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>>      Peter Xu <peterx@redhat.com> (commit_signer:6/7=3D86%,commit_signer=
:4/5=3D80%)
>>      Brijesh Singh <brijesh.singh@amd.com> (commit_signer:5/7=3D71%,comm=
it_signer:4/5=3D80%)
>>      "Alex Benn=C3=A9e" <alex.bennee@linaro.org> (commit_signer:1/7=3D14=
%)
>>      Jan Kiszka <jan.kiszka@siemens.com> (commit_signer:1/5=3D20%)
>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> However, --git-blame still lists him:
>>
>>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git-blame
>>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86,commits:7/24=3D=
29%)
>>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86,commits:7/24=
=3D29%)
>>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commits:26/24=
=3D100%,commits:14/8=3D100%)
>>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>>      David Kiarie <davidkiarie4@gmail.com> (authored lines:1176/1645=3D7=
1%,authored lines:274/373=3D73%)
>>      Brijesh Singh <brijesh.singh@amd.com> (authored lines:403/1645=3D24=
%,authored lines:93/373=3D25%,commits:4/8=3D50%)
>>      Peter Xu <peterx@redhat.com> (commits:10/24=3D42%,commits:4/8=3D50%)
>>      David Gibson <david@gibson.dropbear.id.au> (commits:7/24=3D29%)
>>      Jan Kiszka <jan.kiszka@siemens.com> (commits:1/8=3D12%)
>>      Prasad J Pandit <pjp@fedoraproject.org> (commits:1/8=3D12%)
>>      qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> --help admonishes:
>>
>>    Using "--git-blame" is slow and may add old committers and authors
>>        that are no longer active maintainers to the output.
>>
>>>                           There should be some opt-out statement from
>>> that, but I don't recall how.
>>
>> I don't think get_maintainer.pl supports a blacklist of people who don't
>> want to be pestered anymore.
>>
>
> # cat linux/.get_maintainer.ignore
> Christoph Hellwig <hch@lst.de>
>
> That's why I remembered it vaguely.

Ah!

commit 435de0782b658c993350049e853ea9a8795df4e2
Author: Joe Perches <joe@perches.com>
Date:   Thu Jun 25 15:01:50 2015 -0700

    get_maintainer.pl: add .get_maintainer.ignore file capability
=20=20=20=20
    Some people prefer not to be cc'd on patches.  Add an ability to have a
    file (.get_maintainer.ignore) with names and email addresses that are
    excluded from being listed except when specifically listed as a maintai=
ner
    in a section.
=20=20=20=20
    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Can we resync with the kernel's script to get this feature?  Or should
we cherry-pick it?

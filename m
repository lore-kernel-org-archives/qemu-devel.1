Received: from eggs.gnu.org ([209.51.188.92]:54030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1gwraP-00022R-6V
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1gwraN-0002aM-A7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:52:37 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:48172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1gwraM-0002T0-CE
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:52:34 -0500
References: <20190221155359.8247-1-davidkiarie4@gmail.com>
	<aac6b5d0-ecdd-577c-5b38-8c875ea1dffc@redhat.com>
	<6cdbaddf-57d8-3333-c9a0-7c5f46cecab7@siemens.com>
	<87h8cxxf2o.fsf@dusky.pond.sub.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3c29b265-7add-61e2-2beb-6601d5ad02dd@siemens.com>
Date: Thu, 21 Feb 2019 17:52:24 +0100
MIME-Version: 1.0
In-Reply-To: <87h8cxxf2o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, David Kiarie <davidkiarie4@gmail.com>, qemu-devel@nongnu.org, alexaltea123@gmail.com, peterx@redhat.com, mst@redhat.com

On 21.02.19 17:48, Markus Armbruster wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
>> On 21.02.19 17:05, Eric Blake wrote:
>>> On 2/21/19 9:53 AM, David Kiarie wrote:
>>>> the occurrence of my name and email on the files below may have led =
to
>>>> some confusion in the reporting of a few recent bugs.
>>>>
>>>> i have therefore choosen to snip it.
>>>
>>> Dropping an email from the copyright line makes sense; dropping the
>>> Copyright declaration altogether is a bit odd (the GPL works only in
>>> tandem with a copyright assertion) - but as you are the author of the
>>> line and copyright holder of your contributions, I am not in a positi=
on
>>> to say you are wrong in removing it, only that it looks odd.
>>>
>>
>> Yeah, indeed.
>>
>> David, also note that you probably have been addressed because
>> scripts/get_maintainer.pl will look into the git history of files that
>> some patch addresses and pick up significant and/or recent
>> contributors from there.
>=20
> MAINTAINERS covers these files, so the most common use of
> get_maintainer.pl won't list anyone not listed there:
>=20
>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch]
>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>      qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> David's contributions have aged out of --git:
>=20
>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git
>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commit_signer:=
12/7=3D100%,commit_signer:10/5=3D100%)
>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
>      Richard Henderson <rth@twiddle.net> (maintainer:X86,commit_signer:=
1/7=3D14%)
>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
>      Peter Xu <peterx@redhat.com> (commit_signer:6/7=3D86%,commit_signe=
r:4/5=3D80%)
>      Brijesh Singh <brijesh.singh@amd.com> (commit_signer:5/7=3D71%,com=
mit_signer:4/5=3D80%)
>      "Alex Benn=C3=A9e" <alex.bennee@linaro.org> (commit_signer:1/7=3D1=
4%)
>      Jan Kiszka <jan.kiszka@siemens.com> (commit_signer:1/5=3D20%)
>      qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> However, --git-blame still lists him:
>=20
>      $ scripts/get_maintainer.pl -f hw/i386/amd_iommu.[ch] --git-blame
>      Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86,commits:7/24=3D=
29%)
>      Richard Henderson <rth@twiddle.net> (maintainer:X86)
>      Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86,commits:7/24=
=3D29%)
>      "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC,commits:26/24=3D=
100%,commits:14/8=3D100%)
>      Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>      David Kiarie <davidkiarie4@gmail.com> (authored lines:1176/1645=3D=
71%,authored lines:274/373=3D73%)
>      Brijesh Singh <brijesh.singh@amd.com> (authored lines:403/1645=3D2=
4%,authored lines:93/373=3D25%,commits:4/8=3D50%)
>      Peter Xu <peterx@redhat.com> (commits:10/24=3D42%,commits:4/8=3D50=
%)
>      David Gibson <david@gibson.dropbear.id.au> (commits:7/24=3D29%)
>      Jan Kiszka <jan.kiszka@siemens.com> (commits:1/8=3D12%)
>      Prasad J Pandit <pjp@fedoraproject.org> (commits:1/8=3D12%)
>      qemu-devel@nongnu.org (open list:All patches CC here)
>=20
> --help admonishes:
>=20
>    Using "--git-blame" is slow and may add old committers and authors
>        that are no longer active maintainers to the output.
>=20
>>                           There should be some opt-out statement from
>> that, but I don't recall how.
>=20
> I don't think get_maintainer.pl supports a blacklist of people who don'=
t
> want to be pestered anymore.
>=20

# cat linux/.get_maintainer.ignore
Christoph Hellwig <hch@lst.de>

That's why I remembered it vaguely.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

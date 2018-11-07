Received: from eggs.gnu.org ([2001:4830:134:3::10]:41896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKTiw-0000u1-AA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKTiu-0004sX-La
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:42:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKTis-0004jZ-9J
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:42:44 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so15673951oth.4
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 11:42:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b0e9b3f-5d88-9ef2-d0c5-f241067001d0@redhat.com>
References: <1541528230-31817-1-git-send-email-thuth@redhat.com>
	<c0febf9a-f098-112d-9c8d-c320cc66b04a@redhat.com>
	<12974ebb-09de-c6e9-1dd7-5199a8ae6b05@redhat.com>
	<CAFEAcA-B74FQgj3COyGZ_SAAvSUA6=OaLdy5--NoAgHgEGZkpg@mail.gmail.com>
	<87k1louaze.fsf@dusky.pond.sub.org>
	<4b0e9b3f-5d88-9ef2-d0c5-f241067001d0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Nov 2018 19:42:11 +0000
Message-ID: <CAFEAcA_N7zeuMGGvUBC6xu-AK2gH0n+aNwJOkhs7yWFx_3DbsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2018 at 19:39, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-07 17:08, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On 6 November 2018 at 18:52, Thomas Huth <thuth@redhat.com> wrote:
>>>> On 2018-11-06 19:49, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 6/11/18 19:17, Thomas Huth wrote:
>>>>>> There is no active maintainer, but since Peter is picking up
>>>>>> patches via qemu-arm@nongnu.org, I think we could at least use
>>>>>> "Odd Fixes" as status here.
>>>>>
>>>>> This looks more as "Orphan" to me...
>>>>
>>>> I'll leave it up to Peter for the final decision...
>>>
>>> I think we're not very consistent[*] in our usage of the various
>>> statuses in the MAINTAINERS file. I guess "Odd Fixes" makes
>>> sense in that, well, if you send a patch to this
>>> code and cc me I'll review it and put it in the tree. (This
>>> is true of any of the arm boards we have.)
>>>
>>> [*] We have one thing tagged Orphan, which is bsd-user/,
>>> and some things tagged Odd Fixes with no listed maintainer,
>>> and some things tagged Odd Fixes which are in practice more
>>> like Orphan (for instance sh4), and we list "fpu/" as
>>> Odd Fixes despite having given it a pretty thorough
>>> overhaul very recently, and so on...
>>>
>>> If you wanted a mechanizable rule, you could try something
>>> like "every file which is in status Odd Fixes or better
>>> must list with M: at least one named individual who has
>>> submitted a pull request in the last nine months" :-)
>>
>> Sounds like an excellent idea to me!
>
> Well, for me "odd fixes" means that there is someone around who might
> pick up the patch and throw it into a PULL request. "Orphan" means it's
> mostly in vain to send patches for this subsystem, since there is nobody
> going to pick up your patch. So for the ARM boards, I'd say that "odd
> fixes" is a better choice, since Peter still picks up most of the
> patches via the "L: qemu-arm@nongnu.org" (big thanks for this, by the way=
!).

I think there should be a named person, though. A list
isn't a maintainer (at least not for the big whole
subsystem lists we have).

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfk3y-00044W-49
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfk3u-0002Yx-U4
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:47:34 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org> <87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
	<3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
	<CAFEAcA80HQXTgLUUb4LjM+Vw=7ZTj09rbCsiyvC07GN+NywM_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91e62cd2-947b-5c7b-3371-b1d116710fc7@redhat.com>
Date: Thu, 10 Aug 2017 11:47:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80HQXTgLUUb4LjM+Vw=7ZTj09rbCsiyvC07GN+NywM_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 10/08/2017 11:35, Peter Maydell wrote:
>> actual default for un-matched: "recent contributors" + qemu-devel@
>>
>>   $ ./scripts/get_maintainer.pl -f disas.c
>>   get_maintainer.pl: No maintainers found, printing recent contributor=
s.
>>   get_maintainer.pl: Do not blindly cc: them on patches!  Use common s=
ense.
>>   Peter Maydell <peter.maydell@linaro.org> (commit_signer:2/3=3D67%)
>>   Richard Henderson <rth@twiddle.net> (commit_signer:1/3=3D33%)
>>   Thomas Huth <thuth@redhat.com> (commit_signer:1/3=3D33%)
>>   Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/3=3D33%)
>>   Julian Brown <julian@codesourcery.com> (commit_signer:1/3=3D33%)
>>   qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> I find the un-matched "recent contributors" list often confuse, due to=
 files
>> being moved, header updated, checkpatch indented.
>=20
> Yes, the recent-contributors list is often unhelpful, which
> is partly why the script warns about them. We might perhaps
> switch the default to --no-git-fallback".

Note that if a patch touches both maintained and unmaintained files, the
recent contributors list is omitted:

    $ scripts/get_maintainer.pl -f util/cutils.c hw/ide/core.c
    John Snow <jsnow@redhat.com> (supporter:IDE)
    qemu-devel@nongnu.org (open list:All patches CC here)
    qemu-block@nongnu.org (open list:IDE)

"--no-git-fallback" is probably the right thing to do when sending a
patch series.  The maintainer that shepherds the series will take care
of unmaintained files too.

However, when sending a single patch to an unmaintained file the
contributors list usually does get the patch to the inbox of a
maintainer.  This increases the odds of getting someone's attention.
Because inexperienced contributors usually don't send large series, my
feeling is that overall "--git-fallback"'s advantage are more than the
disadvantages, especially with the above logic that was introduced in
commit c6561586f0 ("get_maintainer.pl: restrict cases where it falls
back to --git", 2014-10-23).

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfYYm-0005S2-K6
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfYYi-0007WW-TK
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:30:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org> <87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
	<87fud0vmak.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e66742f-04c5-51b7-de3a-f692c0637bc5@amsat.org>
Date: Wed, 9 Aug 2017 18:30:25 -0300
MIME-Version: 1.0
In-Reply-To: <87fud0vmak.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

[I added mails of other person who reply to this series, this mail is 
not directly addressed to Alex]

On 08/09/2017 11:38 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
[...]
>> Do you think there should be another entry in "Block QAPI, monitor,
>> command line"?
>> or this file (and related include) rather deserves an own section
>> (possibly tagged Odd Fixes) to unburden Richard?
> 
> Well the default for un-matched files is qemu-devel right? It would be
> nice for it to be properly maintained but that requires someone to
> step-up to the plate.

I wonder if I'm understanding correctly what the MAINTAINERS file is for 
and how to use it.

 From an submitter view I feel a bit confused. I thought 
./get_maintainer.pl would give me the list of person to email the 
changes I did on some file from the repository. This script seems 
correctly named, I'm looking for some ./get_reviewers.pl instead, to 
know who I'v to keep updated, apart from the ./get_maintainer.pl.

currently we have:
"M: Mail patches to: FullName <address@domain>"
Does this imply FullName is a maintainer?
If so is it ok I do this change:

-    M: Mail patches to: FullName <address@domain>
+    M: Maintainer: FullName <address@domain>
+       These maintainers must be mailed on patches.
      R: Designated reviewer: FullName <address@domain>
         These reviewers should be CCed on patches.


actual default for un-matched: "recent contributors" + qemu-devel@

   $ ./scripts/get_maintainer.pl -f disas.c
   get_maintainer.pl: No maintainers found, printing recent contributors.
   get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
   Peter Maydell <peter.maydell@linaro.org> (commit_signer:2/3=67%)
   Richard Henderson <rth@twiddle.net> (commit_signer:1/3=33%)
   Thomas Huth <thuth@redhat.com> (commit_signer:1/3=33%)
   Michael Tokarev <mjt@tls.msk.ru> (commit_signer:1/3=33%)
   Julian Brown <julian@codesourcery.com> (commit_signer:1/3=33%)
   qemu-devel@nongnu.org (open list:All patches CC here)

I find the un-matched "recent contributors" list often confuse, due to 
files being moved, header updated, checkpatch indented.
Most of the time you get the list of queue maintainers since they accept 
patches and sign-of the pull request.

Having to use 'git log --follow' and 'git blame' to figure out is not 
bad, to be aware of who modified this file before you, but there are 
some files I already hit 3 times in different series, and wondered about 
how avoid those manual steps.

Anyway I now understand these recent contributors are not maintainers 
but no-designated reviewers, unwilling to be maintainers (else they'd 
have added a section/entry by themselves).

I also understand why Fam said it sounds weird to add an new section as 
"Orphan".

For the linux-headers case, if people want to be notified of changes the 
easiest seems to modify the update-linux-headers.sh script.

I'll review the whole series thinking differently and resend when 2.11 
opens.

Regards,

Phil.

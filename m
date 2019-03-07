Received: from eggs.gnu.org ([209.51.188.92]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1yNa-0003KC-MO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1yNZ-0003E9-Se
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 14:08:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-7-armbru@redhat.com>
	<5b779d47-f381-a7e1-961d-a676304abfc2@redhat.com>
Date: Thu, 07 Mar 2019 20:08:15 +0100
In-Reply-To: <5b779d47-f381-a7e1-961d-a676304abfc2@redhat.com> (Eric Blake's
	message of "Thu, 7 Mar 2019 11:59:34 -0600")
Message-ID: <87o96mmrj4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 06/12] vl: Factor configure_blockdev()
 out of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, lersek@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 3/7/19 11:23 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> 
>> # Conflicts:
>> #	vl.c
>
> How'd you get git to preserve the leading #? Generally, I find conflicts
> details useful for cherry-picked backports, but pointless for rebased
> patches intended as original upstream material. And git defaults to
> stripping lines with leading # when composing a commit message.

I've messed up too many commit message by having fill-paragraph flow a #
to the beginning of a line, so I added

    [commit]
            cleanup = scissors

to my .gitconfig.  I've been messing up commit messages with leftover
crap ever since, but leftover crap has proven less confusing to my
reviewers than missing lines.

>                                                                 May be
> worth cleaning up before the actual pull request.

Certainly.


git-commit(1):

       --cleanup=<mode>
           This option determines how the supplied commit message should be
           cleaned up before committing. The <mode> can be strip, whitespace,
           verbatim, scissors or default.

           strip
               Strip leading and trailing empty lines, trailing whitespace,
               commentary and collapse consecutive empty lines.

           whitespace
               Same as strip except #commentary is not removed.

           verbatim
               Do not change the message at all.

           scissors
               Same as whitespace except that everything from (and including)
               the line found below is truncated, if the message is to be
               edited. "#" can be customized with core.commentChar.

                   # ------------------------ >8 ------------------------

           default
               Same as strip if the message is to be edited. Otherwise
               whitespace.

           The default can be changed by the commit.cleanup configuration
           variable (see git-config(1)).

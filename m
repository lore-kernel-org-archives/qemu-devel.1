Received: from eggs.gnu.org ([209.51.188.92]:55990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Auf-0005vm-UZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:31:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Aue-0001rb-4P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:31:29 -0500
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-7-armbru@redhat.com>
	<5b779d47-f381-a7e1-961d-a676304abfc2@redhat.com>
	<87o96mmrj4.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d48e2cc0-6179-83d5-c498-5e3394a2246c@redhat.com>
Date: Fri, 8 Mar 2019 09:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <87o96mmrj4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com

On 03/07/19 20:08, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 3/7/19 11:23 AM, Markus Armbruster wrote:
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> # Conflicts:
>>> #	vl.c
>>
>> How'd you get git to preserve the leading #? Generally, I find conflicts
>> details useful for cherry-picked backports, but pointless for rebased
>> patches intended as original upstream material. And git defaults to
>> stripping lines with leading # when composing a commit message.
> 
> I've messed up too many commit message by having fill-paragraph flow a #
> to the beginning of a line, so I added
> 
>     [commit]
>             cleanup = scissors

I'm going to steal this now. :)

> 
> to my .gitconfig.  I've been messing up commit messages with leftover
> crap ever since, but leftover crap has proven less confusing to my
> reviewers than missing lines.
> 
>>                                                                 May be
>> worth cleaning up before the actual pull request.
> 
> Certainly.
> 
> 
> git-commit(1):
> 
>        --cleanup=<mode>
>            This option determines how the supplied commit message should be
>            cleaned up before committing. The <mode> can be strip, whitespace,
>            verbatim, scissors or default.
> 
>            strip
>                Strip leading and trailing empty lines, trailing whitespace,
>                commentary and collapse consecutive empty lines.
> 
>            whitespace
>                Same as strip except #commentary is not removed.
> 
>            verbatim
>                Do not change the message at all.
> 
>            scissors
>                Same as whitespace except that everything from (and including)
>                the line found below is truncated, if the message is to be
>                edited. "#" can be customized with core.commentChar.
> 
>                    # ------------------------ >8 ------------------------
> 
>            default
>                Same as strip if the message is to be edited. Otherwise
>                whitespace.
> 
>            The default can be changed by the commit.cleanup configuration
>            variable (see git-config(1)).
> 

Yeah I can tell this documentation was written by a programmer. The
documentation most likely follows the implementation closely (nested
"if"s?), with the "double except". Just try to expand the definition of
"scissors" without a mental stack overflow:

    Same as strip except #commentary is not removed except that
    everything from (and including) the line found below is truncated

Geez.

Anyway, thank you again for the tip!
Laszlo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx5C-0006yi-Ra
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZx5B-0001kp-R7
	for qemu-devel@nongnu.org; Sat, 04 Feb 2017 04:56:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<bfb329d2-245f-8175-7f02-7f806d022d99@redhat.com>
Date: Sat, 04 Feb 2017 10:56:27 +0100
In-Reply-To: <bfb329d2-245f-8175-7f02-7f806d022d99@redhat.com> (Max Reitz's
	message of "Fri, 3 Feb 2017 21:28:22 +0100")
Message-ID: <87mve26zzo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] Non-flat command line option argument
 syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> I like both JSON and dot syntax. But I like them differently in
> different places.
>
> I love JSON when it's in some file where I can turn out syntax
> highlighting and let my $EDITOR match brackets and braces.
>
> I hate JSON when it's on the command line. You have to escape, you get
> strings in strings, and at least for QMP you sometimes even get strings
> in strings in strings (yes, I like my "echo | qemu -qmp stdio" with
> human-monitor-command). Apart from that, usually I don't format anything
> nicely on the command line anyway, so JSON and dot syntax are equally
> illegible then.
>
> JSON is great for reading, when formatted correctly. If it's not
> formatted nicely and you don't have a good editor with highlighting,
> it's pretty bad.
> It's good for writing in an editor. It's not so nice for writing in a shell.

Pro-tip: M-x shell blinks parenthesis.

But point taken.

> OTOH, it's hard to read dot syntax when formatted correctly and it's
> just as bad as JSON when it isn't. But even if you have an editor at
> hand, you can't make it better.
> It's very easy to write dot syntax, however. Just write down what you
> want. Oh, forgot a parameter for that dict three arrays ago? Just write
> it down now. Doesn't matter where you put it. How many braces do I need
> to close now? Oh, right, I don't need to close any. Nice!
>
> So dot syntax is pretty much a write-only syntax. But it's very good at
> that.

Tiresomely repetitive, though.

> On the command line I absolutely adore the dot syntax. It doesn't force
> you to quote, you can put everything anywhere and you don't need to
> count braces. I love it.
>
> However, nobody can read what you wrote. Usually doesn't matter. But for
> docs, that's bad. For scripts, it depends, but again, it usually is bad.
> For configuration files, there is pretty much no excuse. So in general,
> I'm very skeptic about dot syntax in files, to say the least.

Me too.

> So I think it would be good to allow full-JSON configuration. Put it in
> a file, great.
>
> But at the same time, I do not think that JSON is good for the command
> line. Dot syntax works fine and in my opinion it often doesn't actually
> matter whether it's legible or not.
>
>
> I don't like structured values very much because to me they are just
> "JSON light". Well, you don't have to quote keys and values (so no
> "string in string" mess), but other than that you still have to quote
> everything and you still have to count braces.
>
> Max
>
>
> PS: I personally actually think that structured representations such as
> JSON may in some situations be less legible than the dot syntax if you
> do not have syntax highlighting and it's not formatted nicely; and
> that's because you have to count braces not just when writing but also
> when reading. Imagine the following:
>
> a.b.c.d.e.f=42,a.b.c.g=23
>
> {"a":{"b":{"c":{"d":{"e":{"f":42}}},"g":23}}}
>
> I can read the first one much better than the second one. Of course,
> that's different with nice formatting and a good editor, but the above
> is how I would write it on the command line.
>
> I know it's a fabricated example and you'd just need to switch "g" and
> "d", but "}}}}}}" actually makes me a bit dizzy, so that may be even
> worse. Anyway, I just wanted to make the point that I think that compact
> JSON and dot syntax are both pretty much illegible.

Quoting myself: "both variants are basically illegible.  This is simply
something that belongs into a config file rather than the command line."

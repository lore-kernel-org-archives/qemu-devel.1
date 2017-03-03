Received: from eggs.gnu.org ([2001:4830:134:3::10]:39206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjqXo-0003xx-4J
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjqXl-0004G0-38
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:59:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjqXk-0004Fg-U5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:59:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
	<CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
	<CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
Date: Fri, 03 Mar 2017 17:58:57 +0100
In-Reply-To: <CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
	(Peter Maydell's message of "Fri, 3 Mar 2017 16:31:27 +0000")
Message-ID: <878tomnvou.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 March 2017 at 15:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>> make check failures on OSX host:
>
>> May or may not be this pull's fault.
>
> I gave the pull another test, since I've pretty much run out of
> other stuff in the queue, but it failed again in the same way,
> on both OSX and x86-64 Linux.

Thanks, I appreciate it.  I already tracked down the problem (I think),
NAKed the pull request containing it[1], and posted revised patches for
review [2].  I now realize I should have NAKed the one depending on it,
too.  Sorry if this wasted your time!

[...]


[1] [PULL 00/26] QAPI patches for 2017-02-28
[2] [PATCH v4 00/28] qapi: QMP dispatch and input visitor work

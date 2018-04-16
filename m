Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f84rM-0005qo-Qh
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f84rG-0001vJ-UU
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:11:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f84rG-0001uh-Qm
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:11:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180312131806.23209-1-stefanha@redhat.com>
	<CAFEAcA8VxyrDVMija0C219E5cPtKLC13YHcLFbB+VMRw9uCA_A@mail.gmail.com>
Date: Mon, 16 Apr 2018 16:11:32 +0200
In-Reply-To: <CAFEAcA8VxyrDVMija0C219E5cPtKLC13YHcLFbB+VMRw9uCA_A@mail.gmail.com>
	(Peter Maydell's message of "Mon, 12 Mar 2018 13:34:27 +0000")
Message-ID: <871sffp7fv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 12 March 2018 at 13:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> Warn if files are added/renamed/deleted without MAINTAINERS file
>> changes.  This has helped me in Linux and we could benefit from this
>> check in QEMU.
>>
>> This patch is a manual cherry-pick of Linux commit
>> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
>> file add/move/delete") by Joe Perches <joe@perches.com>.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>
> Unfortunately the patch doesn't magically cause maintainers
> to appear for the new files :-)

Fortunately, the patch can get new files non-magically rejected unless a
maintainers appears :)

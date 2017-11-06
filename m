Received: from eggs.gnu.org ([2001:4830:134:3::10]:41336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBakX-0008C9-8r
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBakT-00060p-FD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:19:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eBakT-0005wY-9S
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 01:19:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1507696406-11168-1-git-send-email-jiang.biao2@zte.com.cn>
	<CAFEAcA_EefcYLjt5aG1D+rcQes9vig6OFZGJrxNhgp5q2vfqbw@mail.gmail.com>
Date: Mon, 06 Nov 2017 07:19:01 +0100
In-Reply-To: <CAFEAcA_EefcYLjt5aG1D+rcQes9vig6OFZGJrxNhgp5q2vfqbw@mail.gmail.com>
	(Peter Maydell's message of "Wed, 11 Oct 2017 13:03:15 +0100")
Message-ID: <87h8u8gca2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] checkpatch: replace ERROR with WARN for
 extern checking.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jiang Biao <jiang.biao2@zte.com.cn>, zhong.weidong@zte.com.cn, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 11 October 2017 at 05:33, Jiang Biao <jiang.biao2@zte.com.cn> wrote:
>> There are some rare cases which need external declarations in .c
>> files. patchew.org and checkpatch.pl will complain errors on
>> patches for these declarations.
>>
>> Degrade ERROR to WARN to erase the error complaints taking
>> checkpatch.pl in kernel as reference.
>>
>> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
>> ---
>>  scripts/checkpatch.pl | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I'd rather not drop this to a warning for the sake of a single
> use case that's already in the tree (and which if you really

Concur.  Rare false positives from checkpatch are tolerable.

> cared about you could work around by putting the link_error()
> declaration in a header file I suppose, though I wouldn't
> bother personally.)

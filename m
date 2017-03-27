Received: from eggs.gnu.org ([2001:4830:134:3::10]:39870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZLf-0002lT-CI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csZLb-00050I-Ex
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csZLb-0004zN-94
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:26:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42C4E811AC
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 18:26:30 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-6-git-send-email-armbru@redhat.com>
	<bfae4dc1-ba50-385a-1c8e-7c760b34da88@redhat.com>
Date: Mon, 27 Mar 2017 20:26:28 +0200
In-Reply-To: <bfae4dc1-ba50-385a-1c8e-7c760b34da88@redhat.com> (Max Reitz's
	message of "Mon, 27 Mar 2017 18:29:10 +0200")
Message-ID: <87shlyefu3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 05/11] rbd: Don't accept
 -drive driver=rbd, keyvalue-pairs=...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdurgin@redhat.com, jcody@redhat.com

Max Reitz <mreitz@redhat.com> writes:

> On 27.03.2017 15:26, Markus Armbruster wrote:
>> The way we communicate extra key-value pairs from
>> qemu_rbd_parse_filename() to qemu_rbd_open() exposes option parameter
>> "keyvalue-pairs" on the command line.  It's not wanted there.  Hack:
>> rename the parameter to "=keyvalue-pairs" to make it inaccessible.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>  block/rbd.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks!

> (Or you could just use x- like blkdebug does...)

Yes.

An "x-" prefix tells you "don't use this", which you're free to ignore.
The "=" prefix cannot be ignored, because the QemuOpts parser will
choke on it.

Matter of taste, I guess.

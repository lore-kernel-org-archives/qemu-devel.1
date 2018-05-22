Received: from eggs.gnu.org ([2001:4830:134:3::10]:37587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fL6cc-0004m3-NX
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fL6cY-00057x-Lj
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:42:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fL6cY-00057f-HM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:42:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180522065922.GA3462@rnd>
Date: Tue, 22 May 2018 14:42:27 +0200
In-Reply-To: <20180522065922.GA3462@rnd> (Pavel Balaev's message of "Tue, 22
	May 2018 09:59:24 +0300")
Message-ID: <87in7fq2to.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Add save/load/del[vm] QMP api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Balaev <mail@void.so>
Cc: qemu-devel@nongnu.org

Pavel Balaev <mail@void.so> writes:

> Hello,
>
> Now savevm, loadvm and delvm commands only allowed from hmp monitor.
> This patch adds ability to send them via QMP api. 
>
> Signed-off-by: Pavel Balaev <mail@void.so>

Quoting my reply to a prior similar patch:

    savevm and loadvm are HMP only precisely because an exact QMP
    equivalent wouldn't be a sane interface, and designing a sane QMP
    interface would be work.  Things that won't do for QMP include
    automatic selection of the block device receiving the VM state, and
    synchronous operation.

    Building blocks might be a better fit for QMP than a
    one-size-fits-all savevm command.

Message-ID: <87po5m2odo.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00615.html

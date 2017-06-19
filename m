Received: from eggs.gnu.org ([2001:4830:134:3::10]:46376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMsrF-0006nD-Ql
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dMsrB-0006Vz-Qe
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 05:20:29 -0400
References: <1495486409-5197-1-git-send-email-thuth@redhat.com>
	<20170616161954.GD4366@noname.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62da550f-bbf6-736d-6ed8-9503e8aaf97c@redhat.com>
Date: Mon, 19 Jun 2017 11:20:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170616161954.GD4366@noname.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Move the qemu-ga description
 into a separate chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 16.06.2017 18:19, Kevin Wolf wrote:
> Am 22.05.2017 um 22:53 hat Thomas Huth geschrieben:
>> The qemu-ga description is currently a subsection of the Disk Images
>> chapter - which does not make much sense since the qemu-ga is not
>> directly related to disk images. So let's move this information
>> into a separate chapter instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> This patch messed up the start of the manpage (qemu.1).
> 
> It refers to "qemu-ga - QEMU Guest Agent" now and the synopsis section
> includes the description of a part of the targets as well as some
> literal texinfo code.

I just had a look at it, and the qemu-ga patch just triggered another
problem in qemu-doc.texi to become more obvious: There were some
sections opened with "@c man begin OPTIONS" but never closed again.
After closing them properly, the man page looks right again (and the
badly marked sections now also show up in the man page correctly). I
just sent a patch.
Maybe we should also add some logic to scripts/texi2pod.pl that emits a
warning when a "@c man" section is not closed properly? (Someone with
the right Perl-foo around here?)

 Thomas

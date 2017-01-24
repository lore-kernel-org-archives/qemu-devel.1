Received: from eggs.gnu.org ([2001:4830:134:3::10]:35698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVz6k-0000Co-3B
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cVz6j-0005II-6B
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:17:50 -0500
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
Date: Tue, 24 Jan 2017 12:17:40 +0100
MIME-Version: 1.0
In-Reply-To: <877f5l1tak.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>



On 23/01/2017 20:16, Markus Armbruster wrote:
>>                                                      Could we change
>> those messages to errors
> 
> Fine with me, but when it comes to arguing for backward compatibility of
> our byzantine command line, I'm kind of like a lethargic public defender
> with an overly deep relationship to Bourbon.  "Your honor, sure capital
> punishment is called for?  Yes?  Okay then."
> 
> I vaguely recall discussing the topic with Peter (cc'ed).  If memory
> serves, one concern was breaking usage of -device with -drive lacking
> if=...  Works fine (no warning) with machines that don't pick up drives
> with their default block interface type, i.e. most of them.  But PATCH 3
> changes their default to if=none, so that usage wouldn't actually break.

I think that tips the scale in favor of having errors.

> What would break is -device with -drive if=T, where T is not none and
> not picked up by the board.  Such usage is certainly questionable[*],
> but it's questionable enough for us to break it?
> 
>>                          and then drop PC if=scsi support altogether?
> 
> Different backward compatibility question: here we break usage of
> if=scsi with PC machine types.  Legacy way to do things, but it's
> documented in qemu.1.  Are we happy to break it?

That usage is wrong after this patch, since it mentions
qemu-system-i386.  So it's documented, but almost useless and the
example is not exactly correct.  Let's deprecate it in 2.9 and remove in
2.10.

Paolo

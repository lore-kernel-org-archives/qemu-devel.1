Received: from eggs.gnu.org ([2001:4830:134:3::10]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elF9o-0002k9-80
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elF9n-0003u5-F6
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:32:36 -0500
References: <20180207163622.29935-1-pbonzini@redhat.com>
	<20180207163622.29935-3-pbonzini@redhat.com>
	<20180208013517.GB24289@lemon.usersys.redhat.com>
	<5ac0b76e-213a-60c3-c010-87512d3a564a@redhat.com>
	<20180212135206.GG5103@localhost.localdomain>
	<81af35f9-4934-0c21-e3b1-b27c2fa7fdd9@redhat.com>
	<20180212143040.GH5103@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d6031b0-7d75-c3ab-e466-ce3d87d630df@redhat.com>
Date: Mon, 12 Feb 2018 15:32:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180212143040.GH5103@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: add block job opblockers for
 scsi-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 12/02/2018 15:30, Kevin Wolf wrote:
>>> We shouldn't be adding new instances of BLOCK_OP_* at all. I couldn't
>>> find the time yet to remove the existing ones, but any new protections
>>> should be using the permission system.
>> I agree.  But does this include not fixing bugs wherever clients are
>> using the old op blockers?
> I'm not saying that we shouldn't fix the bug, just that we should fix it
> properly with the best infrastructure we have.
> 
> The old op blockers are "fixing" the problem at the symptom level, and
> you have to check for each high-level operation if it does something
> problematic internally. You have to repeat this analysis every time you
> add a new operation or modifiy an existing one (which noone ever does).
> The risk that this breaks sooner or later is pretty high.
> 
> The new permission system, on the other hand, directly addresses the
> root cause, and any new feature that uses dirty bitmaps will then
> automatically get the protection, too.
> 
> So in fact, I would say that the bug isn't really fixed (but at best
> papered over) until we add a proper fix on the permission level.

Okay, we are in agreement about this and you expressed very well why I
(at the gut feeling level) didn't like the old op blockers.  But you
bypassed the real question, which is: should I send a pull request for
these two patches or not? :)

Paolo

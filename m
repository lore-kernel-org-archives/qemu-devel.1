Received: from eggs.gnu.org ([2001:4830:134:3::10]:41720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi6ME-0005JF-51
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 19:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fi6MD-00083X-4Z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 19:04:42 -0400
References: <20180724221750.16282-1-lbloch@janustech.com>
	<0e4edd44-ee9a-9846-b19b-547888bba6a7@janustech.com>
	<7ae44fed-2ba3-0557-251c-18e1f8fd461a@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <b033d2f9-3ed1-1f34-0813-07d7a5a24a61@janustech.com>
Date: Wed, 25 Jul 2018 02:04:05 +0300
In-Reply-To: <7ae44fed-2ba3-0557-251c-18e1f8fd461a@redhat.com>
Content-Language: en-GB-large
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Introduction of l2-cache-full
 option for qcow2 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

   Thanks for the review and for the comments, Eric!
   One quick remark: I do usually leave blank lines around inline replies,
   but this time Thunderbird made it look as if there are blank lines when
   I was writing, when apparently there were not. :]
   Leonid.

   On 07/25/2018 01:44 AM, Eric Blake wrote:

     On 07/24/2018 05:20 PM, Leonid Bloch wrote:
     meta-comment: a hint for more effective emails below

     -------------------------
     Differences from v2:
     1) A separate patch for the grammar fix for 3.0
     2) A separate patch for existing documentation fixes for 3.0
     3) Separated back the iotests patch, because the grammar fix is
     separate now
     -------------------------
     Differences from v2:

     * from v3

     1) Grammar change commit message fix

     Visually, it's hard to pick out an inline reply prefixed with "*"
     amid a bunch of lines prefixed with ">", with no other hinting.
     (Actually, I'm finding it easier to read your email in my reply
     window, where thunderbird chose to use ">>" for double-quoted lines
     vs. "> *" for the single quoted line, which has a distinct
     whitespace change in column 2 that the original email window did
     not.  But then again, I've been bitten by Thunderbird displaying
     quoting differently to me than it renders to the end recipient, so I
     don't know if "> *" will still have a space by the time you see this
     reply of mine).
     I find that it is much more legible to always include a blank line
     around both ends of any text I type, as the eye is much quicker at
     picking out the absence of any character in column 1 than it is on
     deciphering which marks in column 1 serve as the indicator of
     transitions between quoted vs. new content in the thread.

     2) Rewording the documentation more concisely
     3) Squashing the l2-cache-full docs commit to the one that
     introduces this
         feature

     Also, when replying to an archived list, it's okay to trim quoted
     text down to just the context relevant to the reply, to let the
     reader quickly reach the new content, rather than preserving the
     entire original email and forcing the reader to scroll through a
     wall of text just to locate the added thoughts. (Yes, some mail
     clients do a better job of coloring quoted text differently, and/or
     collapsing quoted material, so that not every reader has to scroll,
     but not everyone agrees on the ideal mail client). This email wasn't
     too bad, but you'll find instances of me making these same
     metacomments on other emails over the years if you search the
     archives :)
     Finally, thanks for contributing, and for your rapid turnaround
     incorporating suggestions from my earlier reviews!  I know that
     sometimes when I make observations about making the review process
     more efficient for everyone involved, it makes me come across as a
     curmudgeonly old miser. In my efforts to be terse, I often forget to
     also be human and compliment contributors for making an effort in
     the first place, regardless of whether future efforts can be made
     even more efficient.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctfT1-0004YZ-SP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ctfSy-0005dW-Lk
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 15:10:43 -0400
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
	<0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <71b59e1b-caf0-d7b0-0648-b98d62e66c6b@acm.org>
Date: Thu, 30 Mar 2017 14:10:35 -0500
MIME-Version: 1.0
In-Reply-To: <0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>, Corey Minyard <cminyard@mvista.com>

On 03/30/2017 12:53 PM, Eric Blake wrote:
> On 03/30/2017 12:28 PM, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> Macro parameters should almost always have () around them when used.
>> llvm reported an error on this.
>>
>> Remove redundant parenthesis and put parenthesis around the entire
>> macros with assignments in case they are used in an expression.
>>
>> Remove some unused macros.
>>
>> Reported in https://bugs.launchpad.net/bugs/1651167
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>>   1 file changed, 12 insertions(+), 22 deletions(-)
> Already reviewed by me, so now I'm just adding commentary: Is this still
> 2.9 material?  It silences a build warning under clang, although I
> didn't analyze whether the unpatched code actually caused an observable
> behavior bug or just compiler noise.
>
I don't believe the code has a bug, going through all the uses there is
no expression used as a parameter or set used in an expression.

That said, it's also not going to hurt anything and it's nice to silence the
warnings.

-corey

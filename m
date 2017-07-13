Received: from eggs.gnu.org ([2001:4830:134:3::10]:45135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVcC7-0001or-VA
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVcC4-0000l8-Rj
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:22:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVcC4-0000l1-LI
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:22:04 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499866456.git.alistair.francis@xilinx.com>
	<87vamxzjln.fsf@dusky.pond.sub.org>
	<CAKmqyKN_qjQn_am2HK=yAEi0=AzkEMfxP4b8qvLOYwMkrCFYQg@mail.gmail.com>
	<69e2fa77-5311-9874-34fc-297a062929d4@redhat.com>
Date: Thu, 13 Jul 2017 13:22:00 +0200
In-Reply-To: <69e2fa77-5311-9874-34fc-297a062929d4@redhat.com> (Eric Blake's
	message of "Thu, 13 Jul 2017 05:33:09 -0500")
Message-ID: <878tjsr38n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, philippe@mathieu-daude.net, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 07/13/2017 02:08 AM, Alistair Francis wrote:
>> On Wed, Jul 12, 2017 at 6:49 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>> Alistair Francis <alistair.francis@xilinx.com> writes:
>>>
>>>> QEMU currently has a standard method to report errors with
>>>> error_repot(). This ensure a sane and standard format when printing
>>>> errors. This series is attempting to extend this functionality for
>>>> warnings and information as well.
>>>>
>>>> This patch renames error_print_loc() function to be more clear, but I
>>>> didn't bother renaming the others. It seems silly to change
>>>> error_printf() to error_warning_printf() and printf is already taken so
>>>> I just left it as is.
>>>
>>> I can take this through my tree once PATCH 4 got some R-by from PC
>>> paintainers.  Whom you again neglected to cc; I just did that for you.
>>> I'll be happy to touch up minor issues like the ones I pointed out for
>>> v4.
>> 
>> Thanks for CCing them. I keep assuming git send-email will CC from the
>> suggested-by line, but apparently not.
>
> It will, if you add 'git config sendemail.cccmd
> "/path/to/scripts/get_maintainer.pl --nogit-fallback --noroles"'

Misunderstanding?  Your bit of configuration automates cc'ing
maintainers.  Alistair was wondering about Suggested-by lines.

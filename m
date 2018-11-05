Received: from eggs.gnu.org ([2001:4830:134:3::10]:57221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJh5p-0004EX-PP
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJh1a-0005rT-9K
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:42:47 -0500
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
	<6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
	<20181102141030.GH7521@dhcp-200-186.str.redhat.com>
	<0b2d802d-4b58-30de-44a8-9f04dc968b1b@redhat.com>
	<20181102152800.GI7521@dhcp-200-186.str.redhat.com>
	<66efaf0d-1e29-4583-f6d4-674d12a978a7@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97109c81-447a-0fb6-4b14-634df4ebd93e@redhat.com>
Date: Mon, 5 Nov 2018 09:42:37 -0600
MIME-Version: 1.0
In-Reply-To: <66efaf0d-1e29-4583-f6d4-674d12a978a7@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Alberto Garcia <berto@igalia.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 11/2/18 7:29 PM, Leonid Bloch wrote:
>>> Agreed. I didn't want it in the first place, arguing that if we want
>>> stringification of defaults, it would be better to have a runtime function
>>> do that, rather than adding a set of near-duplicate macro names.
> 
> A runtime function will not help here, as these are used in compile
> time. These result in strings that are actually compiled into the binaries.

Well, my point is that right now, QemuOpts outputs a hard-coded string 
(with no alternative), which does mean that things are compiled in.  Is 
it worth exploring an enhancement to QemuOpts that lets it decide 
between either a const char * hardcoded string, or a runtime formatter 
callback function, and convert all existing hardcoded strings with 
awkward contents to instead use a new runtime formatter?

Or is that just putting lipstick on a pig, since we are already trying 
to move away from QemuOpts into a more structured command line 
introspection?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIcFL-0007qB-77
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIcFH-000152-Ad
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:52:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIcFH-00014i-6g
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:52:11 -0400
References: <20180513085032.27773-1-sw@weilnetz.de>
	<e2b0f5a2-18df-79a2-7caa-45afdc09a172@redhat.com>
	<CAFEAcA_bbq_ckoUnYs1VvL+389R9KL6HOxxRD2oFMfE05rsg_w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2b3bb349-8a18-845b-15da-467adcf33bbd@redhat.com>
Date: Tue, 15 May 2018 10:52:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bbq_ckoUnYs1VvL+389R9KL6HOxxRD2oFMfE05rsg_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Use strings command from cross
 development tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, Mike Frysinger <vapier@gentoo.org>, QEMU Developer <qemu-devel@nongnu.org>

On 05/15/2018 10:04 AM, Peter Maydell wrote:

>> I'd much prefer this to be:
>>
>> if $strings -a $TMPO | grep...
>>
>> That's because if I have something like this in my environment:
>>
>> STRINGS='/path/to/strings -a'
>>
>> it will only work if you allow word splitting on my variable.
> 
> Conversely, if I have STRINGS='/path with spaces/to/strings'
> in my environment it will only work if you don't do word
> splitting on it :-)

Make convention has long been that /path with spaces/ is unacceptable 
for any of the typical tool replacements, and that you always perform 
unquoted (and thus word splitting) of a tool name.  My most common 
example is EDITOR='emacs -nw'.  You can always add a symlink to a tool 
from a path without spaces, if you want to provide a tool override to 
something that normally lives somewhere with spaces.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

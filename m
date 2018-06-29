Received: from eggs.gnu.org ([2001:4830:134:3::10]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzoW-0002vg-7G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYzoV-0006wc-7w
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:16:16 -0400
References: <CAFLvi203QwYCdfdhq6pb855xOZbt-bOiMsYU3cDSx6itHeu2=w@mail.gmail.com>
	<ceff4595-026d-ae13-5628-042cf043d0ac@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <007fb94d-5a04-0ee1-5d1b-6fd41e67c9a4@redhat.com>
Date: Fri, 29 Jun 2018 15:16:08 -0500
MIME-Version: 1.0
In-Reply-To: <ceff4595-026d-ae13-5628-042cf043d0ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [BUG] qed_aio_write_alloc: Assertion
 `s->allocating_acb == NULL' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Quytelda Kahja <quytelda@tamalin.org>, qemu-devel@nongnu.org
Cc: Qemu-block <qemu-block@nongnu.org>

On 06/29/2018 03:07 PM, John Snow wrote:
> CC Qemu Block; looks like QED is a bit busted.
> 
> On 06/27/2018 10:25 AM, Quytelda Kahja wrote:
>> Hello all,
>> I wanted to submit a bug report in the tracker, but it seem to require
>> an Ubuntu One account, which I'm having trouble with, so I'll just
>> give it here and hopefully somebody can make use of it.  The issue
>> seems to be in an experimental format, so it's likely not very
>> consequential anyway.

Analysis in another thread may be relevant:

https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08963.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

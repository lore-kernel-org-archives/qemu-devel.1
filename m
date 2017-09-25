Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwZnL-0006rT-9D
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwZnK-0004jd-ES
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:15:59 -0400
References: <87tvzyu3p4.fsf@igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f4f684b2-aef1-53aa-2e5d-dfddb39aedca@redhat.com>
Date: Mon, 25 Sep 2017 16:15:49 -0400
MIME-Version: 1.0
In-Reply-To: <87tvzyu3p4.fsf@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] RFC: Reducing the size of entries in
 the qcow2 L2 cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/19/2017 11:07 AM, Alberto Garcia wrote:
> Hi everyone,

>    - We need a proper name for these sub-tables that we are loading
>      now. I'm actually still struggling with this :-) I can't think of
>      any name that is clear enough and not too cumbersome to use (L2
>      subtables? => Confusing. L3 tables? => they're not really that).
> 

L2 <page | cluster | table> <segment | slice>.

"slice" might be the nicest as it's in common usage elsewhere in
software engineering and properly intuits that it's a division / portion
of a whole.

"l2 slice" ?

--js

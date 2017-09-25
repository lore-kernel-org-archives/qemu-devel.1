Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dwZsz-0000JJ-LX
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dwZsw-00076c-HC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 16:21:49 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f4f684b2-aef1-53aa-2e5d-dfddb39aedca@redhat.com>
References: <87tvzyu3p4.fsf@igalia.com>
	<f4f684b2-aef1-53aa-2e5d-dfddb39aedca@redhat.com>
Date: Mon, 25 Sep 2017 22:21:07 +0200
Message-ID: <w51fuba8r7w.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Mon 25 Sep 2017 10:15:49 PM CEST, John Snow <jsnow@redhat.com> wrote:

>>    - We need a proper name for these sub-tables that we are loading
>>      now. I'm actually still struggling with this :-) I can't think of
>>      any name that is clear enough and not too cumbersome to use (L2
>>      subtables? => Confusing. L3 tables? => they're not really that).
>
> L2 <page | cluster | table> <segment | slice>.
>
> "slice" might be the nicest as it's in common usage elsewhere in
> software engineering and properly intuits that it's a division /
> portion of a whole.
>
> "l2 slice" ?

Doesn't sound bad! Thanks for the suggestion.

Berto

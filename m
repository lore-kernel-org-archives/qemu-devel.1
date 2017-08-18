Received: from eggs.gnu.org ([2001:4830:134:3::10]:35547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1diott-0003rN-3b
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1diots-0000hw-DW
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:33:53 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
Date: Fri, 18 Aug 2017 17:33:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170818211542.5380-9-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/13] tests: Rely more on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>



On 08/18/2017 05:15 PM, Eric Blake wrote:
> libqtest provides two layers of functions: qtest_*() that operate
> on an explicit object, and a plain version that operates on the
> 'global_qtest' object.  However, very few tests care about the
> distinction, and even the tests that manipulate multiple qtest
> connections at once are just fine reassigning global_qtest around
> the blocks of code that will then operate on the updated global,
> rather than calling the verbose form.  Before the next few patches
> get rid of the qtest_* layer, we first need to update the remaining
> few spots that were using the long form where we can instead rely
> on the short form.
> 

Not a big fan of globals and implicit state, but I do at least agree
that we don't need two sets of functions.

(You just happen to be killing the set I like.)

eh, to-may-to to-mah-to.

> Signed-off-by: Eric Blake <eblake@redhat.com>

Acked-by: John Snow <jsnow@redhat.com>

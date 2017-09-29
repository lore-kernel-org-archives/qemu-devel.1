Received: from eggs.gnu.org ([2001:4830:134:3::10]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dy17H-0004Ng-BB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dy17G-00019G-ID
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:38:31 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-20-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c7c22b4d-292e-5a25-1b2b-880a1bf5b962@redhat.com>
Date: Fri, 29 Sep 2017 15:38:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-20-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 19/23] qemu-img: Change img_rebase() to
 be byte-based
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
List-ID: <qemu-devel.nongnu.org>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> In the continuing quest to make more things byte-based, change
> the internal iteration of img_rebase().  We can finally drop the
> TODO assertion added earlier, now that the entire algorithm is
> byte-based and no longer has to shift from bytes to sectors.
> 
> Most of the change is mechanical ('num_sectors' becomes 'size',
> 'sector' becomes 'offset', 'n' goes from sectors to bytes); some
> of it is also a cleanup (use of MIN() instead of open-coding,
> loss of variable 'count' added earlier in commit d6a644bb).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: John Snow <jsnow@redhat.com>

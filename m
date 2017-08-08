Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df6uR-0003fL-Kc
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1df6uQ-0007y0-Qs
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:59:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-30-git-send-email-armbru@redhat.com>
	<9c09b2bd-50e9-b354-8c67-c965d57dfef4@redhat.com>
Date: Tue, 08 Aug 2017 17:58:52 +0200
In-Reply-To: <9c09b2bd-50e9-b354-8c67-c965d57dfef4@redhat.com> (John Snow's
	message of "Mon, 7 Aug 2017 21:56:51 -0400")
Message-ID: <871som6og3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 29/56] block: Make BlockDirtyInfo byte
 count unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

John Snow <jsnow@redhat.com> writes:

> On 08/07/2017 10:45 AM, Markus Armbruster wrote:
>> Byte counts should use QAPI type 'size' (uint64_t).  BlockDirtyInfo
>> member @count is 'int' (int64_t).  bdrv_query_dirty_bitmaps() computes
>> @count from bdrv_get_dirty_count() in uint64_t, then implicitly
>> converts to int64_t.  Before the commit before previous, the
>> conversion was in bdrv_get_dirty_count() instead.
>> 
>> Change member @count to 'size'.
>> 
>> query-block now reports @count values above 2^63-1 correctly instead
>> of their (negative) two's complement.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Assuming there's no "gotcha" here introduced by changing the QAPI, then
> ACK; but you're the expert there, so I trust you!

Juan asked the same question on PATCH 15, see my reply there.

> Reviewed-by: John Snow <jsnow@redhat.com>

Thanks!

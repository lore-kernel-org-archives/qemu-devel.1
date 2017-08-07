Received: from eggs.gnu.org ([2001:4830:134:3::10]:56334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1delCB-0006bQ-A5
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1delC6-0004lx-IC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:47:59 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1502117160-24655-17-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Mon, 7 Aug 2017 16:45:20 +0200")
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-17-git-send-email-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 07 Aug 2017 18:47:32 +0200
Message-ID: <87h8xje34r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 16/56] migration: Make XBZRLE
 transferred size unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> Sizes should use QAPI type 'size' (uint64_t).  XBZRLECacheStats member
> @bytes is 'int' (int64_t).  save_xbzrle_page() computes the byte count
> increment in size_t, implicitly converts it to int, then adds that to
> @bytes.
>
> Change the XBZRLECacheStats member to 'size' and clean up
> save_xbzrle_page().
>
> query-migrate now reports transferred sizes above 2^63-1 correctly
> instead of their (negative) two's complement.
>
> HMP's "info migrate" already reported them correctly, because it
> printed the signed integer with PRIu64.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

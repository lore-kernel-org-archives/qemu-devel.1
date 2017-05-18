Received: from eggs.gnu.org ([2001:4830:134:3::10]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBQba-00048F-F4
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dBQbZ-0002zE-Hw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:58 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:33090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dBQbZ-0002y6-Bw
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:56:57 -0400
Date: Thu, 18 May 2017 20:56:45 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170518185645.i27m3w2pcpiybjqp@aurel32.net>
References: <1495128400-23759-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495128400-23759-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 2017-05-18 19:26, Thomas Huth wrote:
> TEST BLOCK was likely once used to execute basic memory
> tests, but nowadays it's just a (slow) way to clear a page.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v4:
>  - Switched TCG_CALL_NO_RWG back to TCG_CALL_NO_WG as indicated by Richard
> 
>  v3:
>  - Use TCG_CALL_NO_RWG instead of TCG_CALL_NO_WG
>  - Use potential_page_fault() since the helper can generate an exception
> 
>  v2:
>  - Use DEF_HELPER_FLAGS_2 instead for DEF_HELPER_2 for returning CC value
>  - Convert real to absolute address
>  - Added a check for valid RAM page
>  - Added low-address protection check
> 
>  target/s390x/cpu.h         |  1 +
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/mem_helper.c  | 28 ++++++++++++++++++++++++++++
>  target/s390x/mmu_helper.c  |  2 +-
>  target/s390x/translate.c   | 11 +++++++++++
>  6 files changed, 44 insertions(+), 1 deletion(-)
> 

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

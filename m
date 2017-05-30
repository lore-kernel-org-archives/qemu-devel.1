Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFdEI-0007Wu-BX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFdEE-00080N-4W
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:14:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFdED-0007zx-Ux
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:14:14 -0400
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-15-aurelien@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6455e0b-0201-e921-9ec6-7e1f0e2de93d@redhat.com>
Date: Tue, 30 May 2017 11:14:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-15-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/29] target/s390x: improve 24-bit and
 31-bit addresses read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 29.05.2017 21:24, Aurelien Jarno wrote:
> Improve fix_address to also handle the 24-bit mode. Rename fix_address
> to wrap_address to better explain what is changed.
> 
> Replace the calls to get_address with x2 = 0 and b2 = 0 by
> call to wrap_address, leading to the removal of this function. Rename
> get_address_31fix into get_address.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/mem_helper.c | 71 +++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 40 deletions(-)

Looks fine (but the EXECUTE patches from Richard have to be included
first, of course)...

Reviewed-by: Thomas Huth <thuth@redhat.com>

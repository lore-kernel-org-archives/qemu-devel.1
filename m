Received: from eggs.gnu.org ([2001:4830:134:3::10]:56240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwWNX-0001xK-Ci
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwWNU-0007Le-Ac
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:37:07 -0400
References: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7726e35d-4869-e5aa-4151-f40bed148825@redhat.com>
Date: Mon, 25 Sep 2017 18:37:00 +0200
MIME-Version: 1.0
In-Reply-To: <5DAE0523-80F8-4F68-93CB-0571C0C62B20@loffgren.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] thunk.h uses TARGET_ABI_BITS without
 including abitypes.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Loffgren <daniel@loffgren.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org


Did this cause any trouble? ... one of two sentences in the patch
description would be nice, I think.

 Thomas


On 25.09.2017 03:02, Daniel Loffgren wrote:
> 
> Signed-off-by: Daniel Loffgren <daniel@loffgren.org>
> ---
>  include/exec/user/thunk.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index f19ef4b230..12b5449d8c 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -19,6 +19,7 @@
>  #ifndef THUNK_H
>  #define THUNK_H
>  
> +#include "abitypes.h"
>  #include "cpu.h"
>  
>  /* types enums definitions */
> 

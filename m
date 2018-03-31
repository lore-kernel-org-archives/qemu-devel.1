Received: from eggs.gnu.org ([2001:4830:134:3::10]:44847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2KRH-0001WF-Sq
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2KRD-0004UO-KL
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:37:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2KRD-0004RE-Az
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 13:37:11 -0400
References: <20180331171615.21259-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1f03889d-507e-e32d-22e4-6cf360b91a1d@vivier.eu>
Date: Sat, 31 Mar 2018 19:36:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180331171615.21259-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: fix mq_getsetattr
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>

Le 31/03/2018 à 19:16, Max Filippov a écrit :
> mq_getsetattr implementation does not set errno correctly in case of
> error. Also in the presence of both 2nd and 3rd arguments it calls both
> mq_getattr and mq_setattr, whereas only the latter call would suffice.
> 
> Don't call mq_getattr in the presence of the 2nd argument. Don't copy
> output back to user in case of error. Use get_errno to set errno value.
> 
> This fixes test rt/tst-mqueue2 from the glibc testsuite.
> 
> Cc: Lionel Landwerlin <lionel.landwerlin@openwide.fr>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v2->v3:
> - don't defer get_errno call;
> 
> Changes v1->v2:
> - don't copy output back to user in case of error;
> - fix changelog.
> 
>  linux-user/syscall.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

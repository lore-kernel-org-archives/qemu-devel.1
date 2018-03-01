Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erKVu-0004Wb-Cm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erKVp-000588-D7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:28:34 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:48047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1erKVp-00057i-2y
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:28:29 -0500
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-9-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9d0eb30c-dc09-5154-a902-a317eaa58900@vivier.eu>
Date: Thu, 1 Mar 2018 10:28:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180228221609.11265-9-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 08/11] linux-user: drop unused
 target_msync function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 28/02/2018 à 23:16, Max Filippov a écrit :
> target_msync is not used, remove its declaration and implementation.
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/mmap.c | 17 -----------------
>  linux-user/qemu.h |  1 -
>  2 files changed, 18 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

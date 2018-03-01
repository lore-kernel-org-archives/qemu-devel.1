Received: from eggs.gnu.org ([2001:4830:134:3::10]:36973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erKjP-0008NY-GQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erKjM-00077E-F3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:42:31 -0500
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-8-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <38d12344-6664-f67d-2707-d59b6ee21905@vivier.eu>
Date: Thu, 1 Mar 2018 10:42:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180228221609.11265-8-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/11] linux-user: fix
 target_mprotect/target_munmap error return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 28/02/2018 à 23:16, Max Filippov a écrit :
> target_mprotect/target_munmap return value goes through get_errno at the
> call site, thus the functions must either set errno to host error code
> and return -1 or return negative guest error code. Do the latter.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/mmap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

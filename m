Received: from eggs.gnu.org ([2001:4830:134:3::10]:43299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2jzR-00063U-PO
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:54:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2jzN-0004J0-RL
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:54:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2jzN-0004I2-HV
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:54:09 -0400
References: <20180401203640.31617-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b83c07b1-5c24-d8d5-a12e-af35a8b46cdd@vivier.eu>
Date: Sun, 1 Apr 2018 22:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180401203640.31617-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target/xtensa: linux-user: fix sysv IPC
 structures
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

Le 01/04/2018 à 22:36, Max Filippov a écrit :
> - make target_ipc_perm fields match kernel definitions for xtensa;
> - add target_semid64_ds with proper order of times and reserved fields
>   for little/big endian specific for xtensa;
> - add missing reserved fields after time fields to the target_shmid_ds;
> - fix types of shm_cpid, shm_lpid and shm_nattch fields of
>   target_shmid_ds to match kernel definitions for xtensa.
> 
> These changes fix guest ipcs output and fix glibc testsuite tests
> sysvipc/test-sysvsem and sysvipc/test-sysvshm.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - remove little/big endian versions of target_shmid_ds layout to match
>   kernel definition.
> 
>  linux-user/xtensa/target_structs.h | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

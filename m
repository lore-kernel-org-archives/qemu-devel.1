Received: from eggs.gnu.org ([2001:4830:134:3::10]:45007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erLEg-00050G-A7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1erLEc-0002bm-Aw
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:14:50 -0500
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-7-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f3ec2221-4c9e-60b8-c483-bc1ff127fbdf@vivier.eu>
Date: Thu, 1 Mar 2018 11:14:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180228221609.11265-7-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 06/11] linux-user: fix assertion in shmdt
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
> shmdt fails to call mmap_lock/mmap_unlock around page_set_flags,
> resulting in the following assertion:
>   page_set_flags: Assertion `have_mmap_lock()' failed.
> 
> Wrap shmdt internals into mmap_lock/mmap_unlock.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/syscall.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

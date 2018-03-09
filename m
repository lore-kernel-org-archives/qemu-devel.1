Received: from eggs.gnu.org ([2001:4830:134:3::10]:42557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO9Q-0005rG-J2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1euO9L-0002i8-Qj
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 14:58:00 -0500
References: <20180228221609.11265-1-jcmvbkbc@gmail.com>
	<20180228221609.11265-8-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f5a9ec0e-b1dd-9f18-bad8-d419a4fafa37@vivier.eu>
Date: Fri, 9 Mar 2018 20:57:45 +0100
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org

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
> 

Applied to my 'linux-user-for-2.12' branch.

Thanks,
Laurent

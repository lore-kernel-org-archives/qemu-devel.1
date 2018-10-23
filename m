Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF11n-0006eU-Oq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 14:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF0p4-0007IQ-SI
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 13:50:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gF0oz-0007FA-NY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 13:50:28 -0400
References: <1540300056-7935-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540300056-7935-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <33595f9c-b463-d3c1-dcad-ec0aae1c67af@vivier.eu>
Date: Tue, 23 Oct 2018 18:49:38 +0100
MIME-Version: 1.0
In-Reply-To: <1540300056-7935-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] linux-user: Add support for
 SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, ysu@wavecomp.com

On 23/10/2018 14:07, Aleksandar Markovic wrote:
> From: Yunqiang Su <ysu@wavecomp.com>
> 
> Add support for SO_REUSEPORT, including strace support. SO_REUSEPORT
> was introduced relatively recently, since Linux 3.9, so use
> '#if defined SO_REUSEPORT'.
> 
> Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/strace.c  |  3 +++
>  linux-user/syscall.c | 10 ++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

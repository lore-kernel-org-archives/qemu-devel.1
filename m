Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbZM-0006gF-Jm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbZH-0002hy-H4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:30:20 -0500
References: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4c9db3a1-9ad7-3937-040d-529ec30e2b21@vivier.eu>
Date: Tue, 27 Nov 2018 12:30:02 +0100
MIME-Version: 1.0
In-Reply-To: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target: hax: replace
 g_malloc with g_new0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, alex.bennee@linaro.org, philmd@redhat.com, armbru@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 26/11/2018 10:56, Li Qiang wrote:
> And also the g_malloc doesn't need check return value,
> remove it.
> 
> Cc: qemu-trivial@nongnu.org
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

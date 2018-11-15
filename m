Received: from eggs.gnu.org ([2001:4830:134:3::10]:52750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gND7H-0005BH-U6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gND7C-0007Wb-Tq
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 03:35:11 -0500
References: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f72616d4-dc22-73c4-b73b-810c00aed5a2@vivier.eu>
Date: Thu, 15 Nov 2018 09:34:55 +0100
MIME-Version: 1.0
In-Reply-To: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target: hax: replace
 g_malloc with g_malloc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 15/11/2018 07:05, Li Qiang wrote:
> And also the g_malloc doesn't need check return value,
> remove it.
> 
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

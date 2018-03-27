Received: from eggs.gnu.org ([2001:4830:134:3::10]:51881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0kGJ-0005Kb-7R
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0kGG-0004XG-2p
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:47:23 -0400
Date: Tue, 27 Mar 2018 10:47:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180327104706.5363eda9.cohuck@redhat.com>
In-Reply-To: <20180323225739.17329-10-laurent@vivier.eu>
References: <20180323225739.17329-1-laurent@vivier.eu>
	<20180323225739.17329-10-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 v2 09/20] linux-user: move s390x
 signal.c parts to s390x directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org

On Fri, 23 Mar 2018 23:57:28 +0100
Laurent Vivier <laurent@vivier.eu> wrote:

> No code change, only move code from signal.c to
> s390x/signal.c, except adding includes and
> exporting setup_frame() and setup_rt_frame().
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/s390x/signal.c        | 309 +++++++++++++++++++++++++++++++++++++++
>  linux-user/s390x/target_signal.h |   6 +-
>  linux-user/signal.c              | 306 --------------------------------------
>  3 files changed, 314 insertions(+), 307 deletions(-)

I'm not too emotionally involved with linux-user, but

Acked-by: Cornelia Huck <cohuck@redhat.com>

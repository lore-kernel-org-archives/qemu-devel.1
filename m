Received: from eggs.gnu.org ([2001:4830:134:3::10]:53267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0kJQ-0007R7-5n
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f0kJN-000686-3Z
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:50:36 -0400
Date: Tue, 27 Mar 2018 10:50:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180327105029.26c97c5b.cohuck@redhat.com>
In-Reply-To: <20180326191603.10217-16-laurent@vivier.eu>
References: <20180326191603.10217-1-laurent@vivier.eu>
	<20180326191603.10217-16-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.13 15/19] linux-user: move s390x cpu
 loop to s390x directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On Mon, 26 Mar 2018 21:15:59 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> No code change, only move code from main.c to
> s390x/cpu_loop.c.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/main.c           | 146 --------------------------------------------
>  linux-user/s390x/cpu_loop.c | 139 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 139 insertions(+), 146 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

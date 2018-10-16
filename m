Received: from eggs.gnu.org ([2001:4830:134:3::10]:38343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCPiE-0006lA-Bo
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCPiD-0001Ph-Mv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:48:42 -0400
References: <442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
	<09ea4617167b5cc88f2a65cf3248ffbdab25093c.1539694545.git.artem.k.pisarenko@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60d5705a-7a16-d3f5-d15c-79a32fa0fb18@redhat.com>
Date: Tue, 16 Oct 2018 15:47:37 +0200
MIME-Version: 1.0
In-Reply-To: <09ea4617167b5cc88f2a65cf3248ffbdab25093c.1539694545.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Introduce attributes to qemu timer
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 16/10/2018 15:03, Artem Pisarenko wrote:
> +    if (!timer_list) {
> +        timer_list = main_loop_tlg.tl[type];
> +    }
> +    timer_init_full(ts, timer_list, scale, attributes, cb, opaque);

Please move this "if" to timer_init_full, so that here you can just pass
timer_list.  timer_init_full will then take a QEMUTimerListGroup* (NULL
defaults to &main_loop_tlg, aio_timer_new passes &ctx->tlg) and a
QEMUClockType instead of a QEMUTimerList*.

Paolo

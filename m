Received: from eggs.gnu.org ([209.51.188.92]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghu0Y-00026y-07
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghu0X-0000oH-9e
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghu0X-0000nv-2Q
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:25:45 -0500
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<000601d4a8e8$a8a10170$f9e30450$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa160cd8-483c-2eba-b459-8a0f50fb5e6d@redhat.com>
Date: Fri, 11 Jan 2019 11:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <000601d4a8e8$a8a10170$f9e30450$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce attributes for timers
 subsystem and remove QEMU_CLOCK_VIRTUAL_EXT clock type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

On 10/01/19 14:30, Pavel Dovgalyuk wrote:
> Now timerlist_deadline_ns uses all virtual timers for deadline calculat=
ion (including external
> ones).
> qemu_start_warp_timer uses the deadline for setting warp timer (which s=
hould be deterministic).

Can you introduce a variant of qemu_clock_deadline_ns_all that ignores
external timers, and use it in qemu_start_warp_timer?

timerlist_deadline_ns can be made static, so adding a bool argument to
it is not a big issue for API cleanliness.

In fact, qemu_clock_deadline_ns_all is only ever used with
QEMU_CLOCK_VIRTUAL, so you could also change it to

uint64_t virtual_clock_deadline_ns(bool include_external);

Paolo

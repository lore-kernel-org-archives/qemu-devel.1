Received: from eggs.gnu.org ([209.51.188.92]:36457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2BdL-0004rV-OU
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2BdL-0006YV-5v
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2BdK-0006Xa-T2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:17:39 -0500
References: <20190305195519.24303-1-svens@stackframe.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <54846608-cdbc-9cf2-917c-578bdb45df65@redhat.com>
Date: Fri, 8 Mar 2019 10:17:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190305195519.24303-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] LSI53C895 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05/03/19 20:55, Sven Schnelle wrote:
> Hi,
> 
> this series contains a few cosmetic cleanups and one small bugfix for the
> LSI53C895 emulation.
> 
> Regards
> Sven
> 
> Sven Schnelle (5):
>   lsi: use ldn_le_p()/stn_le_p()
>   lsi: use enum type for s->waiting
>   lsi: use enum type for s->msg_action
>   lsi: use SCSI phase names instead of numbers in trace
>   lsi: return dfifo value
> 
>  hw/scsi/lsi53c895a.c | 126 +++++++++++++++++++++++--------------------
>  hw/scsi/trace-events |   6 +--
>  2 files changed, 70 insertions(+), 62 deletions(-)
> 

Queued, thanks.

Paolo

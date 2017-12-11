Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQmj-0001sb-22
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOQmf-00081R-0Q
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:18:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOQme-00080q-Pv
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:18:24 -0500
References: <20171122181418.14180-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <70ae5021-a33f-55e0-517d-3dfa22ff709b@redhat.com>
Date: Mon, 11 Dec 2017 17:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171122181418.14180-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] hyperv: hv msr initialization fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>

On 22/11/2017 19:14, Roman Kagan wrote:
> These patches fix problems with hyperv msr initialization.
> 
> Evgeny Yakovlev (1):
>   hyperv: set partition-wide MSRs only on first vcpu
> 
> Roman Kagan (2):
>   hyperv: ensure SINTx msrs are reset properly
>   hyperv: make SynIC version msr constant
> 
>  target/i386/cpu.h |  6 ++++--
>  target/i386/kvm.c | 44 ++++++++++++++++++++++++--------------------
>  2 files changed, 28 insertions(+), 22 deletions(-)
> 

Queued, thanks.

Paolo

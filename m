Received: from eggs.gnu.org ([2001:4830:134:3::10]:45305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9tzy-0001Bs-0a
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9tzu-0001GX-Ov
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:32:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g9tzu-0001BO-AR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:32:34 -0400
References: <20181008112726.16140-1-vkuznets@redhat.com>
	<20181008112726.16140-2-vkuznets@redhat.com>
	<20181009122046.GC29982@rkaganb.sw.ru>
	<87va6bqnon.fsf@vitty.brq.redhat.com>
	<20181009131738.GE29982@rkaganb.sw.ru>
	<87sh1fqlrw.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <653740b2-5d92-e012-02c4-eec2693b4bcf@redhat.com>
Date: Tue, 9 Oct 2018 17:32:27 +0200
MIME-Version: 1.0
In-Reply-To: <87sh1fqlrw.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-headers: update to pre-4.20
 (kvm/queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On 09/10/2018 15:42, Vitaly Kuznetsov wrote:
> 
> $ scripts/update-linux-headers.sh PATH/TO/LINUX
> ...
> $ git diff --stat
>  include/standard-headers/linux/input.h |  9 +++++----
>  linux-headers/asm-arm/kvm.h            | 13 +++++++++++++
>  linux-headers/asm-arm64/kvm.h          | 13 +++++++++++++
>  linux-headers/asm-s390/kvm.h           |  2 ++
>  linux-headers/asm-x86/kvm.h            |  1 +
>  linux-headers/linux/kvm.h              |  3 +++
>  linux-headers/linux/vfio.h             |  2 ++
>  linux-headers/linux/vhost.h            |  2 +-
>  8 files changed, 40 insertions(+), 5 deletions(-)
> 
> I'm not sure if it would make sense to do this instead: the definition I
> need is currently in kvm/queue and I'm not exactly sure that updating
> other headers from there (e.g. linux/input.h) makes any sense.

True, but we always keep all headers in sync for simplicity (and to
avoid inconsistencies the next time someone runs the script).

I'll wait for kvm/queue to become kvm/next and then queue the patch.

Paolo

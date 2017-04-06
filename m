Received: from eggs.gnu.org ([2001:4830:134:3::10]:50964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw3vp-0005LC-0y
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw3vk-0007VL-4x
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cw3vj-0007V7-V2
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:42:16 -0400
References: <20170404202429.14643-1-ehabkost@redhat.com>
	<20170404202429.14643-8-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <85f387f3-2304-2f7d-df98-fafd3779094b@redhat.com>
Date: Thu, 6 Apr 2017 11:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170404202429.14643-8-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/21] kvmclock: Remove user_creatable
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04.04.2017 22:24, Eduardo Habkost wrote:
> kvmclock should be used by guests only when the appropriate CPUID
> feature flags are set on the VCPU, and it is automatically
> created by kvmclock_create() when those feature flags are set.
> This means creating a kvmclock device using -device is useless.
> Remove user_creatable from its device class.

Actually, I think this device should not be a sysbus device at all,
should it? It does not have any IO, GPIO or IRQ lines, so sysbus does
not make sense here, it should be of type TYPE_DEVICE instead.

Anyway, that's another topic. For your patch:

Reviewed-by: Thomas Huth <thuth@redhat.com>

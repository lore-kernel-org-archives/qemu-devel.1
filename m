Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqxf-0002A0-4i
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIqxc-0000Y1-1x
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:34:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIqxb-0000Xn-Sc
	for qemu-devel@nongnu.org; Wed, 16 May 2018 03:34:55 -0400
References: <1526384258-3581-1-git-send-email-lpetrut@cloudbasesolutions.com>
	<b1f9836f-96ee-d782-1882-51c97e21d252@redhat.com>
	<9ED401B4-3DF6-4BC8-9D38-14C78C9D1A66@cloudbasesolutions.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7f0b9ab-3c8b-87d1-9f63-e82b13f66029@redhat.com>
Date: Wed, 16 May 2018 09:34:52 +0200
MIME-Version: 1.0
In-Reply-To: <9ED401B4-3DF6-4BC8-9D38-14C78C9D1A66@cloudbasesolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] WHPX Add signature CPUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Cc: "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>, Lucian Petrut <lpetrut@cloudbasesolutions.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>

On 16/05/2018 01:55, Alessandro Pilotti wrote:
> Hi Paolo,
> 
> The main reason for different signatures is to allow guest workloads
> to be aware of the differences between the two platforms (eg VirtIO
> vs VMBus).

Why does it matter?  CPUID tells you about the enlightenments that the
hypervisor provides, not the availability of the VMBus.

VMBus requires some of the enlightenments, mostly related to the
synthetic interrupt controllers, but the opposite is not true---you can
have enlightenments without VMBus, and in fact you probably want WHPX to
enable the relaxed timing enlightenment.

Thanks,

Paolo

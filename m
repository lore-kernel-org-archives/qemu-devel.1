Received: from eggs.gnu.org ([2001:4830:134:3::10]:47724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eC1wc-00080y-P6
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eC1wY-0008Pw-Mv
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:26 -0500
Received: from mail-lf0-x235.google.com ([2a00:1450:4010:c07::235]:47268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eC1wY-0008P4-Ei
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:21:22 -0500
Received: by mail-lf0-x235.google.com with SMTP id k40so14029247lfi.4
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 03:21:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
	<765f7133-0ccc-2239-d49b-55d8b2a24cc7@redhat.com>
	<fddffbab-7aab-72b4-f42f-d18e94517350@redhat.com>
	<17ed046b-2c29-340b-9802-f43a709715e2@redhat.com>
	<20171010155003.GD3246@localhost.localdomain>
	<4b9e65ed-3636-bff4-3cca-52f6b80bca3b@redhat.com>
	<20171010194117.GK3246@localhost.localdomain>
	<cdd2b3da-b243-0d17-c3b7-305532b3bc43@redhat.com>
	<20171013190138.GB3246@localhost.localdomain>
	<c0614596-8157-0d91-77a7-e28946b8b13f@redhat.com>
	<20171013235644.GE3246@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eea713f7-2b5e-0233-ebd2-6610d344d2d0@redhat.com>
Date: Tue, 7 Nov 2017 12:21:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171013235644.GE3246@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/7] x86: Rework KVM-defaults
 compat code, enable kvm_pv_unhalt by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 14/10/2017 01:56, Eduardo Habkost wrote:
> Now, I don't know yet what's the best default for a guest that
> has CONFIG_PARAVIRT_SPINLOCK when it sees a host that supports
> kvm_pv_unhalt.  But I'm arguing that it's the guest
> responsibility to choose what to do when it detects such a host,
> instead of expecting the host to hide features from the guest.
> The guest and the guest administrator have more information to
> choose what's best.
> 
> In other words, if exposing kvm_pv_unhalt on CPUID really makes
> some guests behave poorly, can we fix the guests instead?

Waiman just did it. :)

https://marc.info/?l=linux-kernel&m=150972337909996

Paolo

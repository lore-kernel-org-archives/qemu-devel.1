Received: from eggs.gnu.org ([2001:4830:134:3::10]:35302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Fnr-0001Ru-8p
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2Fnm-0003FX-9H
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2Fnm-0003EO-2s
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:07:54 -0400
Date: Wed, 11 Oct 2017 14:07:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011140743.4a535984.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-1-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/30] s390x: SMP for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:36:38 +0200
David Hildenbrand <david@redhat.com> wrote:

> This series is based on a couple of other patches floating around on
> the mailing list (e.g. cleanups and LAP). The fist patches of v1 have
> been sent as a separate series.
> 
> As I am working on kvm-unit-tests for SIGP, I discovered some bugs that
> have been fixed in this series.
> 
> ======================================
> I'll be on vacation until 15. October.
> ======================================
> 
> This series contains:
> - properly implement local external interrupts for TCG. Take care of
>   interrupt masks. Cleanup service interrupt handling.
> - factor out KVM SIGP handling code into common code
> - implement missing SIGP orders for TCG handled by the kernel for KVM
>   (including STOP and RESTART interrupts)
> - make TCG use the new SIGP code - experimental SMP support for s390x TCG
> - refactor STFL(E) implementation for TCG
> - bunch of cleanups
> 
> Basically all SIGP instructions are fully supported.
> 
> Thanks to Aurelien Jarno for the initital prototype and showcasing that
> supporting experimental SMP code can be implemented quite easily.
> 

Thanks, applied (with some minor changes, see the individual patches).

> CPU hotplug does still not work correctly.

Do you have an idea what still needs to be done?

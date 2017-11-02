Received: from eggs.gnu.org ([2001:4830:134:3::10]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADe5-0003yi-6M
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADe0-0002n9-9k
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADe0-0002mj-2t
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:26:44 -0400
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112605.10516.73988.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <864e6683-6155-f38d-2c65-b0ae094c351d@redhat.com>
Date: Thu, 2 Nov 2017 12:26:33 +0100
MIME-Version: 1.0
In-Reply-To: <20171031112605.10516.73988.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 12/26] cpus: push BQL lock to
 qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
>          hax_vcpu_interrupt(env);
>  
> -        qemu_mutex_unlock_iothread();
>          cpu_exec_start(cpu);
>          hax_ret = hax_vcpu_run(vcpu);
> +        current_cpu = cpu;

This assignment makes little sense, this is a thread-local variable and
should always be equal to cpu.  Rebase conflict?

Paolo

>          cpu_exec_end(cpu);
> -        qemu_mutex_lock_iothread();

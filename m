Received: from eggs.gnu.org ([209.51.188.92]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBbF-0000fd-Bc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBbE-0006rb-Ga
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:05 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEBbD-0006oK-VG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:04 -0400
Date: Wed, 10 Apr 2019 14:40:51 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190410114027.53l4ph7an3pnclqr@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-2-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190407115839.25054-2-skrtbhtngr@gmail.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v2 1/2] hvf: declare hvf_handle_io
 if NEED_CPU_H is defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Apr 07, 2019 at 05:28:38PM +0530, Sukrit Bhatnagar wrote:
> hvf_handle_io needs the poisoned type CPUArchState as its argument.
> Declaring it if NEED_CPU_H is defined enables include/sysemu/hvf.h
> to be included for common object compilation as well.
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

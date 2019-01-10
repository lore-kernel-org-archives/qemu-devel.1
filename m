Received: from eggs.gnu.org ([209.51.188.92]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1ghUET-0005Dt-2w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1ghUEP-00010v-CB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:54:23 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:33216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1ghUEJ-0000qu-UY
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:54:17 -0500
Date: Thu, 10 Jan 2019 09:54:02 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190110065402.qb2te6ejc2gxapzp@SPB-NB-133.local>
References: <20181220121112.21667-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181220121112.21667-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: hvf: remove MPX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Dec 20, 2018 at 01:11:12PM +0100, Paolo Bonzini wrote:
> MPX support is being phased out by Intel and actually I am not sure that
> OS X has ever enabled it in XCR0.  Drop it from the Hypervisor.framework
> acceleration.
> 

I also doubt if OS X enabled it, but I can't confirm that as I have only
Ivy Bridge and Haswell-based laptops.

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

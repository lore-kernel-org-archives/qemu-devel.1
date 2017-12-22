Received: from eggs.gnu.org ([2001:4830:134:3::10]:41174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSQP1-0001Nt-Lu
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eSQOy-00049r-I3
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:42:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eSQOy-000494-D2
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:42:28 -0500
References: <mailman.13900.1513951820.27992.qemu-devel@nongnu.org>
	<79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cb05b76-0dcc-0baa-3ca1-9e5deb5baafe@redhat.com>
Date: Fri, 22 Dec 2017 17:42:25 +0100
MIME-Version: 1.0
In-Reply-To: <79998796-2975-46CC-9629-8ADCDC2032FF@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/19] Initial support for
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 22/12/2017 17:26, Programmingkid wrote:
> I was able to clone your git repository and successfully build the hvf branch. The latest commit is this:
> 
> commit aabe2a1a77b70efe96c9345f737068a0dcef0281 (HEAD -> hvf, origin/hvf)
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Thu Dec 21 00:10:03 2017 +0100
> 
>     i386: hvf: avoid useless exit to the main loop
> 
> How do I make QEMU use the hvf feature?

"-accel hvf".

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfmLN-0004tY-QE
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfmLJ-0000VS-Q3
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:13:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfmLJ-0000V6-Jc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:13:37 -0400
References: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9f3a782-d73c-a5b5-c6f2-7b6d832452b7@redhat.com>
Date: Thu, 10 Aug 2017 14:13:30 +0200
MIME-Version: 1.0
In-Reply-To: <1502359687-25370-1-git-send-email-tianyu.lan@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: Increase max vcpu number to 352
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 10/08/2017 12:08, Lan Tianyu wrote:
> Intel Xeon phi chip will support 352 logical threads. For HPC
> usage case, it will create a huge VM with vcpus number as same as host
> cpus. This patch is to increase max vcpu number to 352.

Even without Xeon Phi, a 24-core, 8-socket system (E7-8890 v4 for
example) will have 384 physical CPUs.  288 was the biggest we could test
at the time, but now that the 256 vCPU barrier has been broken I agree
with going straight to 512.

Paolo

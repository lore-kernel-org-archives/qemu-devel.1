Received: from eggs.gnu.org ([2001:4830:134:3::10]:54029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5Wan-0005C3-Fw
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5Wai-0003cB-Ia
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:12:17 -0400
References: <20180409130700.5692-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7688fe59-e20a-2de6-d805-6dc53893a326@redhat.com>
Date: Mon, 9 Apr 2018 15:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180409130700.5692-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] cpus: track calls to
 resume/pause_all_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/04/2018 15:07, David Hildenbrand wrote:
> If we have parallel calls to resume/pause_all_vcpus() we can get
> into trouble because the qemu mutex is temporarily dropped while
> waiting for all threads to stop. This can happen e.g. for s390x, where
> resume/pause_all_vcpus() can be triggered by a VCPU.

Why does s390 need to do pause_all_vcpus()/resume_all_vcpus() instead of
just asking the main thread to do it (similar to qemu_system_reset), is
it because diag 308 must be synchronous?

One disadvantage of the current approach is that diag 308 does not obey
-no-reboot.

Paolo

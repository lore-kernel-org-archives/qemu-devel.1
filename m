Received: from eggs.gnu.org ([2001:4830:134:3::10]:53176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2kT-0008MI-Op
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2kQ-0004hE-VO
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:10:25 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR2kQ-0004gt-Mb
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:10:22 -0500
Received: by mail-pf0-x243.google.com with SMTP id 127so30328177pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 12:10:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295047597.19871.17997092463779305691.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d751a736-9895-bd19-4e68-eb16eaee30fb@twiddle.net>
Date: Tue, 10 Jan 2017 12:10:18 -0800
MIME-Version: 1.0
In-Reply-To: <148295047597.19871.17997092463779305691.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 4/7] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/28/2016 10:41 AM, Lluís Vilanova wrote:
> Every vCPU now uses a separate set of TBs for each set of dynamic
> tracing event state values. Each set of TBs can be used by any number of
> vCPUs to maximize TB reuse when vCPUs have the same tracing state.
>
> This feature is later used by tracetool to optimize tracing of guest
> code events.
>
> The maximum number of TB sets is defined as 2^E, where E is the number
> of events that have the 'vcpu' property (their state is stored in
> CPUState->trace_dstate).
>
> For this to work, a change on the dynamic tracing state of a vCPU will
> force it to flush its virtual TB cache (which is only indexed by
> address), and fall back to the physical TB cache (which now contains the
> vCPU's dynamic tracing state as part of the hashing function).
>
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  cpu-exec.c                |   26 +++++++++++++++++++++-----
>  include/exec/exec-all.h   |    5 +++++
>  include/exec/tb-hash-xx.h |    8 +++++++-
>  include/exec/tb-hash.h    |    5 +++--
>  include/qemu-common.h     |    3 +++
>  tests/qht-bench.c         |    2 +-
>  trace/control-target.c    |    3 +++
>  trace/control.h           |    3 +++
>  translate-all.c           |   16 ++++++++++++++--
>  9 files changed, 60 insertions(+), 11 deletions(-)


Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

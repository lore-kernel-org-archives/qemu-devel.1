Received: from eggs.gnu.org ([2001:4830:134:3::10]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRixS-0007i0-Ai
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gRixO-0004Xk-Dk
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gRixO-0004XY-6I
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:23:38 -0500
References: <20181127190849.10558-1-ldewey@suse.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7de2327-5363-4a0f-0356-0010082752b4@redhat.com>
Date: Tue, 27 Nov 2018 14:23:28 -0500
MIME-Version: 1.0
In-Reply-To: <20181127190849.10558-1-ldewey@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trace: simple style changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Larry Dewey <ldewey@suse.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com



On 11/27/18 2:08 PM, Larry Dewey wrote:
> This changes two lines in simple.c that end with a comma, and replaces them
> with a semi-colon.
> 
> Signed-off-by: Larry Dewey <ldewey@suse.com>
> ---
>  trace/simple.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/trace/simple.c b/trace/simple.c
> index 701dec639c..ac904eca91 100644
> --- a/trace/simple.c
> +++ b/trace/simple.c
> @@ -169,9 +169,9 @@ static gpointer writeout_thread(gpointer opaque)
>          wait_for_trace_records_available();
>  
>          if (g_atomic_int_get(&dropped_events)) {
> -            dropped.rec.event = DROPPED_EVENT_ID,
> +            dropped.rec.event = DROPPED_EVENT_ID;
>              dropped.rec.timestamp_ns = get_clock();
> -            dropped.rec.length = sizeof(TraceRecord) + sizeof(uint64_t),
> +            dropped.rec.length = sizeof(TraceRecord) + sizeof(uint64_t);
>              dropped.rec.pid = trace_pid;
>              do {
>                  dropped_count = g_atomic_int_get(&dropped_events);
> 

I can't see any reason for why sequence points were used, other than in
62bab73213ba885426a781eb2741670b9f3cae36 getting mixed up between

if (cond) { ...; ... } and an earlier var = (type) { ..., ... }.

Reviewed-by: John Snow <jsnow@redhat.com>

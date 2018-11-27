Received: from eggs.gnu.org ([208.118.235.92]:48619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRZJ5-00007B-0M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRZIv-00010c-I5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRZIv-0000yT-3y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F63307D867
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 09:05:11 +0000 (UTC)
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<20181126173604-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6cd98ced-a043-18c0-3aa5-4cda15c76ec5@redhat.com>
Date: Tue, 27 Nov 2018 10:04:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181126173604-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 26/11/18 23:43, Michael S. Tsirkin wrote:
> On Mon, Nov 26, 2018 at 02:20:38PM +0100, Paolo Bonzini wrote:
>> vhost does not have to be supported only if KVM is present, in fact
>> vhost-user does not even need any kind of kernel support.  This series
>> changes this.  The rationale is that, when vhost-user-test.c will be
>> converted to qgraph, it will be able to test vhost-user support
>> for virtio-mmio backend even on x86.
> 
> The reason for limiting it to KVM was very simple:
> it has the same set of problems with ordering
> as mttcg.
> 
> So I guess it's fine but I think we must then limit it
> to when tcg emits fence instructions.
> 
> Otherwise we'll get subtle race conditions.

Got it, I'll take a look.  However, right now you _can_ use vhost with
tcg as long as e.g. qemu-system-x86_64 is compiled with KVM support, so
this patch is not changing anything in this respect; the bug is
independent of this series.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dMrC4-0003hc-Ix
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dMrBy-00086m-Vm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:33:52 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dMrBy-00085y-Rd
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:33:46 -0400
Received: by mail-ua0-f176.google.com with SMTP id j53so40046677uaa.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 00:33:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619064235.GB16787@pxdev.xzpeter.org>
References: <20170616114443.25838-1-lprosek@redhat.com>
	<20170619064235.GB16787@pxdev.xzpeter.org>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 19 Jun 2017 09:33:45 +0200
Message-ID: <CABdb737TWsz9chmEEDyi8ag1E2O6tLijOj970n4iq5=eRMp-sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: relax iq tail check on
 VTD_GCMD_QIE enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Jun 19, 2017 at 8:42 AM, Peter Xu <peterx@redhat.com> wrote:
> Since looks like we need another post, a tiny suggestion is that we
> can also add some comment to tell the reason why we didn't really
> check it, and a trace_vtd_warn_invalid_qi_tail() tracer to show that
> spec is violated (if you see, we have two other warnings already named
> vtd_warn_ir_* which also helps on tracing spec violations).

Sure thing, I've just sent v2 with trace_vtd_warn_invalid_qi_tail and a comment.

> I'll ack the next version after it's cooked. Thanks Ladi for the
> patch!

Thanks!
Ladi

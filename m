Received: from eggs.gnu.org ([2001:4830:134:3::10]:37342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQsh7-00031j-EB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQsh4-00076P-8b
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:26:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQsh4-00075x-2f
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:26:14 -0500
Date: Tue, 10 Jan 2017 09:26:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170110092602.GB2423@work-vm>
References: <20170109201340.16593-1-dgilbert@redhat.com>
	<20170109201340.16593-4-dgilbert@redhat.com>
	<CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_5+WJtRSdOjTw+43Y6R_khLcQu5=yG7Hgu1v+KKbr8Rw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 9 January 2017 at 20:13, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Check qdev's call to vmstate_register_with_alias_id; that gets
> > most of the common uses; there's hundreds of calls via vmstate_register
> > which could get fixed over time.
> 
> Not quite that bad, I think -- I make it just over 50 calls.

Well kind of; it seems to be a bit more complicated than that.
I'd grep'd for vmstate_register and that gives me ~180 (including
stuff in headers).
Only 56 of those are vmstate_register() calls though, 117 are
vmstate_register_ram calls which I'd not previously looked at,
those call qemu_ram_set_idstr which looks like it suffers from
the same problem though.

Dave


> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

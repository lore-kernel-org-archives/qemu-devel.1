Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fIJJs-00049N-9E
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cyrus296@gmail.com>) id 1fIJJr-0001rm-GT
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:39:40 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:38057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cyrus296@gmail.com>) id 1fIJJr-0001qo-CA
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:39:39 -0400
Received: by mail-qt0-x232.google.com with SMTP id m9-v6so17754813qtb.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 12:39:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514191306.GG2497@work-vm>
References: <20180512000545.966-1-cyrus296@gmail.com>
	<20180512000545.966-3-cyrus296@gmail.com>
	<20180514191306.GG2497@work-vm>
From: Calvin Lee <cyrus296@gmail.com>
Date: Mon, 14 May 2018 13:39:18 -0600
Message-ID: <CAG7gSg1yyPOLKK6oxif_nAmEN0_t_D-6QKcs3MTxTMV_9auTFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/2] PC Chipset: Send serial bytes
 at correct rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com

> So the question is, why move it?  If I understand what you've got, then
> it's the same flag with the same semantics - but moving it you break
> migration compatibility - so unless you need to, just leave it where it
> is.

Sorry if I did not make this clear.

This commit will delay flushing the THR until after the new timer has expired.
Before, it would be immediatly flushed into the TSR, and was saved by
`vmstate_serial_tsr`. However, now if the `xmit_timeout_timer` is pending it
needs to be saved, that's why I moved it into the new VMStateDescription.

>If you add a property/flag on the device, and check the property in that
>_needed function, then we can make it so that we don't save that section
>for older machine types.

I don't really understand. How do I make sure not to save this for
older machines?

Thanks,
Calvin

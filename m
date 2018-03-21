Received: from eggs.gnu.org ([2001:4830:134:3::10]:40396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyiCX-0001WP-0o
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eyiCR-0000Lz-Rj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:11:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:63797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eyiCR-0000Kv-Kf
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:10:59 -0400
Date: Wed, 21 Mar 2018 19:10:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
Message-ID: <alpine.BSF.2.21.1803211845340.78606@zero.eik.bme.hu>
References: <6228d029-e799-8aa4-e5f5-68d58fa3268a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PSA] changelog and pull requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel <qemu-devel@nongnu.org>

On Wed, 21 Mar 2018, Paolo Bonzini wrote:
> Even if you haven't updated the ChangeLog, don't worry, I have done it
> for you.  Please double check because QEMU is too big for one person to
> understand all the changes that were made.

Thanks for updating the ChangeLog. Best sources of info for the sam460ex 
machine type are probably the cover letters of the patches I've sent: 
http://lists.nongnu.org/archive/html/qemu-ppc/2018-02/msg00189.html
(and the one linked from it which is still mostly true).

This is a single machine so the "New Sam460ex machine types." should 
probably be singular. Maybe it also worth mentioning that a new SATA 
controller emulation, sii3112 was added (that is used by this machine but 
it's a generic PCI card so might be useful elsewhere although it's 
currently only compiled for PPC machines and not very well tested). I 
think also the SM501 emulation had some improvements in this version or 
was that already in 2.11? (Sam460ex uses this too apart from the SH 
machines). For this whole machine it's true that it's kind of preliminary 
and has a lot of missing parts yet so furhter testing and contributions 
are welcome to improve it. I think this should be stated whenever sam460ex 
is mentioned now so people who want to try it know what to expect and 
don't get the impression that it's a finished full emulation.

Regards,
BALATON Zoltan

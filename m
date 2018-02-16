Received: from eggs.gnu.org ([2001:4830:134:3::10]:39176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1emd7X-0004wJ-Fv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1emd7U-0007Jg-3D
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:19:59 -0500
Received: from mail.avalus.com ([89.16.176.221]:53629)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1emd7T-0007Gc-SK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:19:56 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20180215094220.GA3203@grep.be>
Date: Fri, 16 Feb 2018 05:19:46 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <C8A9E26B-835E-4F13-AD5B-F219F4023016@alex.org.uk>
References: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
	<1564471998.3427173.1518601541505.JavaMail.zimbra@oxygem.tv>
	<83c0fdee-126f-18f1-a691-053669325cb9@redhat.com>
	<20180215094220.GA3203@grep.be>
Subject: Re: [Qemu-devel] drive-mirroring to nbd is failing with multiple
 parallel jobs (qemu 2.9 -> 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexandre Derumier <aderumier@odiso.com>, nbd list <nbd@other.debian.org>


> On 15 Feb 2018, at 04:42, Wouter Verhelst <w@uter.be> wrote:
> 
> 
> We already set the SO_KEEPALIVE socket option (at least nbd-server does;
> don't know about qemu) to make the kernel send out TCP-level keepalive
> probes. This happens only after two hours (by default), but it's
> something you can configure on your system if you need it to be lower.

+1 for just using SO_KEEPALIVE. I think I even submitted some (untested
and thus unmerged) patches for this.

-- 
Alex Bligh

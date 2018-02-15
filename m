Received: from eggs.gnu.org ([2001:4830:134:3::10]:35394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1emG46-0002Ra-F8
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wouter@grep.be>) id 1emG41-0000Qn-JQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:54 -0500
Received: from latin.grep.be ([2a01:4f8:140:52e5::2]:55522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wouter@grep.be>) id 1emG41-0000F4-94
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 04:42:49 -0500
Date: Thu, 15 Feb 2018 10:42:20 +0100
From: Wouter Verhelst <w@uter.be>
Message-ID: <20180215094220.GA3203@grep.be>
References: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
	<1564471998.3427173.1518601541505.JavaMail.zimbra@oxygem.tv>
	<83c0fdee-126f-18f1-a691-053669325cb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c0fdee-126f-18f1-a691-053669325cb9@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, nbd list <nbd@other.debian.org>

Hi Eric,

On Wed, Feb 14, 2018 at 09:11:02AM -0600, Eric Blake wrote:
[NBD and keepalive]
> This is more food for thought on whether it even makes sense for NBD to
> worry about assisting in keepalive matters, or whether it would just be
> bloating the protocol.

I'm currently leaning towards the latter. I don't think it makes (much)
sense to run NBD over an unreliable transport. It uses TCP specifically
to not have to worry about that, under the expectation that it won't
break except in unusual circumstances; if you break that expectation, I
think it's not unfair to say "well, then you get to keep both pieces".

We already set the SO_KEEPALIVE socket option (at least nbd-server does;
don't know about qemu) to make the kernel send out TCP-level keepalive
probes. This happens only after two hours (by default), but it's
something you can configure on your system if you need it to be lower.

Having said that, I can always be convinced otherwise by good arguments
:-)

-- 
Could you people please use IRC like normal people?!?

  -- Amaya Rodrigo Sastre, trying to quiet down the buzz in the DebConf 2008
     Hacklab

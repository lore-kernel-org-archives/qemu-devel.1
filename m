Received: from eggs.gnu.org ([2001:4830:134:3::10]:55724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLcBO-000246-GW
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dLcBN-0006oY-KG
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:20:02 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:57542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dLcBN-0006o9-Fb
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 17:20:01 -0400
Date: Thu, 15 Jun 2017 23:19:59 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170615211959.kl3d2umj7s2o7prm@aurel32.net>
References: <20170615055356.20684-1-rth@twiddle.net>
	<20170615055356.20684-6-rth@twiddle.net>
	<20170615204908.3izswcs4q6l34wrg@aurel32.net>
	<a1abdb2d-68c0-74d1-cb32-9ceb5c879151@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1abdb2d-68c0-74d1-cb32-9ceb5c879151@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 5/5] target/s390x: mark CSST, CSST2,
 FPSEH facilities as available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, david@redhat.com

On 2017-06-15 14:10, Richard Henderson wrote:
> On 06/15/2017 01:49 PM, Aurelien Jarno wrote:
> > > +        S390_FEAT_FLOATING_POINT_SUPPPORT_ENH,
> > 
> > Theoretically the floating-point-support-enhancement facilities include
> > the DFP rounding facility. Given We don't implement the DFP facility I
> > guess this can be ignored.
> 
> We *do* implement the one instruction in DFP-rounding-facility: SRNMT.
> 

Ah ok, nevermind then. The DFP support is in better state than I
thought ;-).

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

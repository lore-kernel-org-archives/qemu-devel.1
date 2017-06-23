Received: from eggs.gnu.org ([2001:4830:134:3::10]:53745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOR5K-0008G6-I3
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOR5J-00007y-LG
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:05:26 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:38158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOR5J-00006X-Fv
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:05:25 -0400
Date: Fri, 23 Jun 2017 18:05:23 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623160523.vvxiayw4crjezii4@aurel32.net>
References: <20170620000405.3391-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 00/18] target/s390x improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On 2017-06-19 17:03, Richard Henderson wrote:
> Changes since v2:
>   * Dropped the enforcement of PGM_OPERATION for insns for
>     which the feature bit is set.  There's no agreement on
>     exactly how to do this yet.
>   * Add implementations of insns for 6 more facilities.
> 
> I think we can get to z990 fairly quickly after this.
> Ignoring HFP, the ones I see missing are DAT-ENH, MSA.

Thanks for this work. For the record I have started working on HFP
sometimes ago. I'll try to finish that and submit patches in the next
weeks.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

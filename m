Received: from eggs.gnu.org ([2001:4830:134:3::10]:46728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMHI-00064v-NQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVMHF-0006Fo-Kv
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:22:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVMHF-0006FW-G3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:22:21 -0400
Date: Wed, 12 Jul 2017 14:22:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712182220.GB7547@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-7-git-send-email-cota@braap.org>
	<87lgnt90uz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lgnt90uz.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 06/22] translate-all: make have_tb_lock
 static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 15:38:28 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > It is only used by this object, and it's not exported to any other.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> I was almost caught out by the name re-use in cpu-exec.c ;-)
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Yes that's very unfortunate. In v2 I'll add a patch to rename it.

Thanks,

		E.

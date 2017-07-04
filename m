Received: from eggs.gnu.org ([2001:4830:134:3::10]:38658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1dSHHB-0000Dr-AR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amit@kernel.org>) id 1dSHHA-00037R-Am
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:25:33 -0400
Received: from relay2-d.mail.gandi.net ([2001:4b98:c:538::194]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amit@kernel.org>) id 1dSHHA-00035d-4S
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:25:32 -0400
Date: Tue, 4 Jul 2017 08:25:27 +0200
From: Amit Shah <amit@kernel.org>
Message-ID: <20170704062527.GB2860@grmbl.mre>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1498495550-72357-12-git-send-email-anton.nefedov@virtuozzo.com>
	<416200823.44425042.1498730528050.JavaMail.zimbra@redhat.com>
	<2e0cd377-3320-3e93-55a7-ca7de66a36a6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e0cd377-3320-3e93-55a7-ca7de66a36a6@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/13] virtio-console: chardev hotswap
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, den@virtuozzo.com, pbonzini@redhat.com

On (Mon) 03 Jul 2017 [14:50:07], Anton Nefedov wrote:
> On 06/29/2017 01:02 PM, Marc-André Lureau wrote:
> > Hi
> > 
> > Looks good, but please write something in the commit message about what needs to be done for be-change (what this patch does).
> > 
> > thanks
> > 
> 
> Hi,
> 
> thank you! I guess the description should look like
> 
>   virtio-console: chardev hotswap support
> 
>   In case of a backend change, the handler functions and the watch have
>   to be reset.
>   Also, avoid unsafe qemu_chr_fe_get_driver() usage even though the pointer
>   is not really stored.
> 
> 
> 
> Amit, have you had a chance to kindly look at this?

If it gets a reviewed-by by someone who's looked at the series,
Michael could pull it all in.

I could look at it if you CC'ed me on the series (hint ;)

		Amit
-- 
http://log.amitshah.net/

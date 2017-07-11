Received: from eggs.gnu.org ([2001:4830:134:3::10]:39451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV1lX-00048G-Bn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV1lW-0001fP-Kw
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dV1lW-0001eO-Eh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:28:14 -0400
Date: Tue, 11 Jul 2017 17:28:07 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170711202807.GC6020@localhost.localdomain>
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711201059.GA6020@localhost.localdomain>
	<20170711231709-mutt-send-email-mst@kernel.org>
	<d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Tue, Jul 11, 2017 at 09:26:22PM +0100, Mark Cave-Ayland wrote:
> On 11/07/17 21:18, Michael S. Tsirkin wrote:
> 
> > Multi-line comments also should formatted
> > 
> > /*
> >  * like
> >  * this
> >  */
> > 
> > not
> > 
> > /* like
> >  * this */
> > 
> 
> Interesting, I never knew there was a preferred format for comments (I
> see both styles throughout the codebase).
> 
> FWIW it's probably worth pointing out that the style for multi-line
> comments isn't given in CODING_STYLE, and checkpatch didn't complain
> either...

I just noticed that, too.  I will submit a patch.

-- 
Eduardo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdM45-0006BA-Kx
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdM41-0003Zx-Ey
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:13:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cdM41-0003Zg-8k
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:13:29 -0500
Date: Mon, 13 Feb 2017 14:13:27 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170213191327.GO27752@localhost.localdomain>
References: <1486134413-19988-1-git-send-email-den@openvz.org>
	<5909b505-fecb-fa98-6ae7-190b846add4c@openvz.org>
	<169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
	<a1049fab-1880-3b03-63bb-6b898ee55b40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1049fab-1880-3b03-63bb-6b898ee55b40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: do not increase offset during
 initial zero_or_discard phase - pls consider this as V3 patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>

On Mon, Feb 13, 2017 at 06:16:36PM +0100, Max Reitz wrote:
> On 13.02.2017 08:10, Denis V. Lunev wrote:
> > On 02/03/2017 06:08 PM, Denis V. Lunev wrote:
> >> On 02/03/2017 06:06 PM, Denis V. Lunev wrote:
> >>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >>>
> >>> If explicit zeroing out before mirroring is required for the target image,
> >>> it moves the block job offset counter to EOF, then offset and len counters
> >>> count the image size twice. There is no harm but stats are confusing,
> >>> specifically the progress of the operation is always reported as 99% by
> >>> management tools.
> >>>
> >>> The patch skips offset increase for the first "technical" pass over the
> >>> image. This should not cause any further harm.
> >>>
> >>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> >>> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >>> Reviewed-by: Eric Blake <eblake@redhat.com>
> >>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> CC: Jeff Cody <jcody@redhat.com>
> >>> CC: Kevin Wolf <kwolf@redhat.com>
> >>> CC: Max Reitz <mreitz@redhat.com>
> >> actually this is V3 patch. Sorry for broken subject.
> >>
> >> Den
> > ping
> 
> Didn't Jeff merge v2?
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01319.html
> 
> Max
> 


Yes, I did.

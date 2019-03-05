Received: from eggs.gnu.org ([209.51.188.92]:44619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h14KQ-0006qi-UY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h14KO-0003tt-RB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:17:30 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:53136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h14KM-0003pu-O6
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:17:27 -0500
Date: Tue, 5 Mar 2019 08:17:12 +0100
From: Sven Schnelle <svens@stackframe.org>
Message-ID: <20190305071712.GA29106@t470p.stackframe.org>
References: <20190304180920.21534-1-svens@stackframe.org>
	<20190304180920.21534-2-svens@stackframe.org>
	<2951e9ec-41c9-14cb-423c-4292c27965aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2951e9ec-41c9-14cb-423c-4292c27965aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lsi: use enum type for s->waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Hi Philippe,

On Tue, Mar 05, 2019 at 12:18:01AM +0100, Philippe Mathieu-Daudé wrote:
> >  
> > +enum {
> > +    LSI_NOWAIT,
> 
> You forgot the comment for NOWAIT.

I thought LSI_NOWAIT is self-explaining, but will add that.

> >      int waiting;
> 
> When a field is not used by migration, you can declare it as enum:
> 
>        enum {
>            LSI_NOWAIT = 0, /* SCRIPTS are running or stopped */
>            LSI_WAIT_RESELECT = 1, /* Wait Reselect instruction has been
> issued */
>            LSI_DMA_SCRIPTS = 2, /* processing DMA from lsi_execute_script */
>            LSI_DMA_IN_PROGRESS = 3, /* DMA operation is in progress */
>        } waiting;
> 
> This gives hints to the compiler about values to check.

But it is used by migration, so this doesn't apply here? I had a typedef enum before,
but this doesn't compile.

Otherwise thanks for reviewing.

Regards
Sven

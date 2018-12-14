Received: from eggs.gnu.org ([2001:4830:134:3::10]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXl82-000371-Jd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gXl7x-0005Oa-KA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:55:34 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:42283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gXl7x-0005It-7q
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:55:29 -0500
Received: from player787.ha.ovh.net (unknown [10.109.159.20])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9A4251EB818
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 11:55:19 +0100 (CET)
Date: Fri, 14 Dec 2018 11:54:35 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181214115435.10e0b5a4@bahia.lan>
In-Reply-To: <20181213223737.11793-3-pbonzini@redhat.com>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SPAM] [Qemu-ppc] [PATCH 2/2] avoid TABs in files
 that only contain a few
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open
	list:bochs" <qemu-block@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrzej Zaborowski <balrogg@gmail.com>, Thomas Huth <thuth@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>, Stefan Weil <sw@weilnetz.de>, Riku Voipio <riku.voipio@iki.fi>, "open list:Stellaris" <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, "Daniel P.
	=?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Max Reitz <mreitz@redhat.com>, "open
	list:ppc4xx" <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Igor Mammedov <imammedo@redhat.com>

On Thu, 13 Dec 2018 23:37:37 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.
> 
> disas, standard-headers, linux-headers and libdecnumber are imported
> from other projects and probably should be exempted from the check.
> Outside those, after this patch the following files still contain both
> 8-space and TAB sequences at the beginning of the line.  Many of them
> have a majority of TABs, or were initially committed with all tabs.
> 
> [...]
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

This a lot of places to review... FWIW stgit spotted a trailing
whitespace for free :)

>  
> diff --git a/target/cris/helper.c b/target/cris/helper.c
> index d2ec349191..754fa00d06 100644
> --- a/target/cris/helper.c
> +++ b/target/cris/helper.c
> @@ -240,7 +240,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
>          /* Exception starts with dslot cleared.  */
>          env->dslot = 0;
>      }
> -	
> +        

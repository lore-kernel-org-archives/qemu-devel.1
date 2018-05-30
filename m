Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fO0pV-0002u3-2Z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fO0pT-0002vd-WC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 09:07:53 -0400
Date: Wed, 30 May 2018 16:07:25 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180530130725.GA2448@rkaganb.sw.ru>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<f924aadb-35b1-ee72-1040-fdeee5baefaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f924aadb-35b1-ee72-1040-fdeee5baefaf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Wed, May 30, 2018 at 02:17:55PM +0200, Max Reitz wrote:
> On 2018-04-26 18:19, Roman Kagan wrote:
> > @@ -550,13 +561,26 @@ def verify_cache_mode(supported_cache_modes=[]):
> >      if supported_cache_modes and (cachemode not in supported_cache_modes):
> >          notrun('not suitable for this cache mode: %s' % cachemode)
> >  
> > +rw_formats = None
> > +
> > +def supports_format(format_name):
> > +    format_message = qemu_pipe('-drive', 'format=?')
> > +    global rw_formats
> > +    if rw_formats is None:
> > +        rw_formats = format_message.splitlines()[0].split(':')[1].split()
> 
> Isn't it sufficient to call qemu_pipe() only if rw_formats is None?

Sure it is, and this was exactly my intention with this global, but I
managed to forget moving the most relevant part under 'if' :$

Thanks for catching,
Roman.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSnA7-0001at-Dq
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSnA3-0006wE-9d
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:28:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSnA3-0006vc-3U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 12:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C38B4A544
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 16:28:18 +0000 (UTC)
Date: Wed, 5 Jul 2017 17:28:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170705162811.GI22008@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170705144302.32017-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170705144302.32017-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: Update info vnc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lcapitulino@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com

On Wed, Jul 05, 2017 at 03:43:02PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The QMP query-vnc interfaces have gained a lot more information that
> the HMP interfaces hasn't got yet. Update it.
> 
> Note the output format has changed, but this is HMP so that's OK.
> 
> In particular, this now includes client information for reverse
> connections:
> 
> -vnc :0
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>   Auth: none (Sub: none)

If you're reporting Auth: against the individual Server entry,
there's no reason to report it at the top level too. We only
keep that duplication in QMP for sake of backcompat, which
is not important for HMP

> 
>   (Now connect a client)
> 
> (qemu) info vnc
> default:
>   Server: 0.0.0.0:5900 (ipv4)
>     Auth: none (Sub: none)
>   Client: 127.0.0.1:51828 (ipv4)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
> 
> -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
> 
> -vnc :1,password,id=rev -vnc localhost:7000,reverse
> (qemu) info vnc
> default:
>   Client: ::1:7000 (ipv6)
>     x509_dname: none
>     username: none
>   Auth: none (Sub: none)
> rev:
>   Server: 0.0.0.0:5901 (ipv4)
>     Auth: vnc (Sub: none)
>   Client: 127.0.0.1:53616 (ipv4)
>     x509_dname: none
>     username: none
>   Auth: vnc (Sub: none)
> 
> This was originally RH bz 1461682
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

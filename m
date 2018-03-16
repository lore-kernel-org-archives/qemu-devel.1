Received: from eggs.gnu.org ([2001:4830:134:3::10]:50554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewu03-0003VM-5D
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtzz-0001dQ-Vg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:22:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtzz-0001ck-R4
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:22:39 -0400
Date: Fri, 16 Mar 2018 18:22:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316182236.GM3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
	<a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
	<c4054b32-b2e1-acd3-52f4-8f7d5c12c2a0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4054b32-b2e1-acd3-52f4-8f7d5c12c2a0@de.ibm.com>
Subject: Re: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 16, 2018 at 07:12:26PM +0100, Christian Borntraeger wrote:
> Does it make sense to have something like
> 
> diff --git a/configure b/configure
> index 831ebf2..67d7ae3 100755
> --- a/configure
> +++ b/configure
> @@ -552,6 +552,10 @@ else
>      pwd_is_source_path="n"
>  fi
>  
> +if test -f $source_path\/qemu-version.h -a $pwd_is_source_path = "n" ; then
> +error_exit "source path contains a stale configuration, cannot build outside" 
> +fi
> +

Yeah that is a check that autoconf does commonly to detect this
kind of mistake, so I think its good.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIZ9z-0004mB-9x
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gIZ9r-0005cI-7N
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:06:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gIZ9o-0005bl-IO
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:06:37 -0400
References: <20181102124220.26558-1-stefanha@redhat.com>
	<20181102124220.26558-6-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6b7ec5e-5879-c17a-af49-83ba05493f5b@redhat.com>
Date: Fri, 2 Nov 2018 08:06:09 -0500
MIME-Version: 1.0
In-Reply-To: <20181102124220.26558-6-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] git: use HTTPS git URLs for
 repo.or.cz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Daniel Berrange <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 11/2/18 7:42 AM, Stefan Hajnoczi wrote:
> repo.or.cz supports git smart HTTPS.  Use it in preference to git:// or
> http:// since it's more secure.

Not sure why you didn't copy-paste the commit messages from the other 
patches, but it doesn't really matter.

> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS    | 14 +++++++-------
>   pc-bios/README |  2 +-
>   2 files changed, 8 insertions(+), 8 deletions(-)

> +++ b/pc-bios/README
> @@ -5,7 +5,7 @@
>     project (http://www.nongnu.org/vgabios/).
>   
>   - The PowerPC Open Hack'Ware Open Firmware Compatible BIOS is
> -  available at http://repo.or.cz/w/openhackware.git.
> +  available at https://repo.or.cz/w/openhackware.git.

This one fails. Remove 'w/' and you can have:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

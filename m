Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNJsj-0000Bw-M0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNJsf-0003UQ-VI
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:48:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNJsf-0003Tv-PP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:48:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29381307D856
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:48:33 +0000 (UTC)
References: <cover.1542294676.git.eskultet@redhat.com>
	<85078eacaa4ba2c83f0ff25387a664dcccb65308.1542294676.git.eskultet@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12a0dadf-8f39-5c38-abcf-30102fb670b7@redhat.com>
Date: Thu, 15 Nov 2018 09:48:27 -0600
MIME-Version: 1.0
In-Reply-To: <85078eacaa4ba2c83f0ff25387a664dcccb65308.1542294676.git.eskultet@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: Add "rendernode" display option
 for egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 11/15/18 9:15 AM, Erik Skultety wrote:
> Unlike SPICE, egl-headless doesn't offer a way of specifying the DRM
> node used for OpenGL, hence QEMU always selecting the first one that is
> available. Thus, add rendernode option to QAPI.
> 
> Signed-off-by: Erik Skultety <eskultet@redhat.com>
> ---
>   qapi/ui.json | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/ui.json b/qapi/ui.json
> index bf9e157d5a..7ecc6eb67e 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1037,6 +1037,19 @@
>     'data'    : { '*grab-on-hover' : 'bool',
>                   '*zoom-to-fit'   : 'bool'  } }
>   
> +##
> +# @DisplayEGLHeadless:
> +#
> +# EGL headless display options.
> +#
> +# @rendernode: Which DRM render node should be used.
> +#
> +# Since: 3.2

Either 3.1 or 4.0, depending on whether this is okay this late after 
soft freeze.  Worth mentioning that rendernode defaults to the first 
available node?

> +#
> +##
> +{ 'struct'  : 'DisplayEGLHeadless',
> +  'data'    : { '*rendernode' : 'str' } }
> +
>    ##
>    # @DisplayGLMode:
>    #
> @@ -1086,4 +1099,5 @@
>                   '*window-close'  : 'bool',
>                   '*gl'            : 'DisplayGLMode' },
>     'discriminator' : 'type',
> -  'data'    : { 'gtk'            : 'DisplayGTK' } }
> +  'data'    : { 'gtk'            : 'DisplayGTK',
> +                'egl-headless'   : 'DisplayEGLHeadless'} }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

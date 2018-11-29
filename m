Received: from eggs.gnu.org ([2001:4830:134:3::10]:48587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSNC3-0004hd-WE
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSN14-0000Hn-SM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSN14-0000HM-Kt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:10:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3437811D5
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 14:10:05 +0000 (UTC)
References: <20181129123502.30129-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b647b71a-ac53-f256-3e16-efa4806b4f7d@redhat.com>
Date: Thu, 29 Nov 2018 08:09:56 -0600
MIME-Version: 1.0
In-Reply-To: <20181129123502.30129-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-devel for-3.1?] [PATCH] egl-headless: add
 egl_create_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 11/29/18 6:35 AM, Gerd Hoffmann wrote:
> We must set the correct context (via eglMakeCurrent) before
> calling qemu_egl_create_context, so we need a thin wrapper and can't
> hook qemu_egl_create_context directly as ->dpy_gl_ctx_create callback.
> 
> Reported-by: Frederik Carlier <frederik.carlier@quamotion.mobi>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   ui/egl-headless.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

How severe is this? Is it something that would warrant 3.1-rc4, or are 
we safe deferring it to 4.0?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

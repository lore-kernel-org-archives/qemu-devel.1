Received: from eggs.gnu.org ([2001:4830:134:3::10]:40866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopJm-0008MY-H7
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eopJj-0005DG-Ev
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:45:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eopJj-0005D2-9b
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:45:39 -0500
Date: Thu, 22 Feb 2018 11:45:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180222114536.GF9323@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <52841519299484@web28j.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52841519299484@web28j.yandex.ru>
Subject: Re: [Qemu-devel] Patch 9894dc0cdcc broke something
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksey Kuleshov <rndfax@yandex.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 22, 2018 at 02:38:04PM +0300, Aleksey Kuleshov wrote:
> Hello!
> 
> I hit unexpected disconnections because of this patch:
> 
> commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Tue Jan 19 11:14:29 2016 +0000
> 
>     char: convert from GIOChannel to QIOChannel
>     
>     In preparation for introducing TLS support to the TCP chardev
>     backend, convert existing chardev code from using GIOChannel
>     to QIOChannel. This simplifies the chardev code by removing
>     most of the OS platform conditional code for dealing with
>     file descriptor passing.
>     
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Message-Id: <1453202071-10289-3-git-send-email-berrange@redhat.com>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> breaks tcp_chr_read:

What version of QEMU are you using ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

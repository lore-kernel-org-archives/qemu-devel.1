Received: from eggs.gnu.org ([2001:4830:134:3::10]:39601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKgt-0006K7-Oh
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKgo-0003Ka-Us
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:39:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1emKgo-0003H3-R2
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:39:10 -0500
References: <1518692807-25859-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ccf0ec6-4eb4-7039-ca51-1fbcd192fa2a@redhat.com>
Date: Thu, 15 Feb 2018 08:38:53 -0600
MIME-Version: 1.0
In-Reply-To: <1518692807-25859-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Polish the version strings containing the
 package version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 02/15/2018 05:06 AM, Thomas Huth wrote:
> Since commit 67a1de0d195a there is no space anymore between the
> version number and the parentheses when running configure with
> --with-pkgversion=foo :
> 
>   $ qemu-system-s390x --version
>   QEMU emulator version 2.11.50(foo)
> 
> But the space is included when building without that option
> when building from a git checkout:
> 
>   $ qemu-system-s390x --version
>   QEMU emulator version 2.11.50 (v2.11.0-1494-gbec9c64-dirty)
> 
> The same confusion exists with the "query-version" QMP command.
> Let's fix this by introducing a proper QEMU_FULL_VERSION definition
> that includes the space and parentheses, while the QEMU_PKGVERSION
> should just cleanly contain the package version string itself.
> Note that this also changes the behavior of the "query-version" QMP
> command (the space and parentheses are not included there anymore),
> but that's supposed to be OK since the strings there are not meant
> to be parsed by other tools.
> 
> Fixes: 67a1de0d195a6185c39b436159c9ffc7720bf979
> Buglink: https://bugs.launchpad.net/qemu/+bug/1673373
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

I like it!

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

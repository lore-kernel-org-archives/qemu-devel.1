Received: from eggs.gnu.org ([2001:4830:134:3::10]:53832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLRUa-0000dC-Ji
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLRUZ-0005D5-FO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:55:08 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLRUZ-0005CW-85
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:55:07 -0400
Received: by mail-wr0-x231.google.com with SMTP id q97so14220034wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 02:55:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497520197-56796-1-git-send-email-pbonzini@redhat.com>
References: <1497520197-56796-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 10:54:45 +0100
Message-ID: <CAFEAcA8PkOJr0u1zF9N-Ye_zcraqc99d9109GdFcxc2FANwmfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH build fix] migration: do not doubly-define
 LoadStateHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 15 June 2017 at 10:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> As the simplest fix to un-confuse patchew, inline the type
> in struct VMStateDescription.  As there are no users of
> LoadStateHandler anymore in e.g. function declarations,
> there isn't much advantage in defining it as a type.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I'm currently processing Juan's pullrequest which includes
a fix for this (it moves the typedefs into typedefs.h.)

thanks
-- PMM

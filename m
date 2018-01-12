Received: from eggs.gnu.org ([2001:4830:134:3::10]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1ea2FQ-0002hf-Vh
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:32:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1ea2FN-0003nm-Sn
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:32:04 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:40801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slopezpa@redhat.com>) id 1ea2FN-0003lo-OR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:32:01 -0500
Received: by mail-io0-f180.google.com with SMTP id v30so6439497iov.7
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:31:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171229094206.14512-1-slp@redhat.com>
References: <20171229094206.14512-1-slp@redhat.com>
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 12 Jan 2018 17:31:58 +0100
Message-ID: <CAAiTLFXrMF1pw-rk9UNCcgLYGB48YkMS+2Ft29dzpifw3K-msw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] pvpanic: implement abort_on_panic
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, mjt@tls.msk.ru, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>

On Fri, Dec 29, 2017 at 10:42 AM, Sergio Lopez <slp@redhat.com> wrote:
> Extend pvpanic and qemu_system_guest_panicked so it's possible to
> configure the first to induce an abort() when the Guest panics.
>
> This is specially useful (and mainly intended to be enabled only) when
> debugging soft/hard lockups on the Guest OS.
>
> Sergio Lopez (2):
>   vl: extend qemu_system_guest_panicked with abort_on_panic
>   pvpanic: add PVPANIC_ABORT_PROP

If someone has a minute, please consider taking a look at this (small)
patch series.

Thanks,
Sergio.

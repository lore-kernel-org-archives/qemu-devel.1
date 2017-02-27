Received: from eggs.gnu.org ([2001:4830:134:3::10]:50967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciPbt-0008GU-4F
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciPbs-0000tT-DB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:01:21 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciPbs-0000tA-56
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:01:20 -0500
Received: by mail-wr0-x22f.google.com with SMTP id g10so57704749wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:01:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6e297b78-dab8-93c5-2a86-1ec267d65eb3@redhat.com>
References: <1485333658-23035-1-git-send-email-thuth@redhat.com>
	<0eca8185-8e94-46f8-6b7a-36c4a21bc28d@redhat.com>
	<20170227140001.GV2778@thinpad.lan.raisama.net>
	<6e297b78-dab8-93c5-2a86-1ec267d65eb3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:00:58 +0000
Message-ID: <CAFEAcA9N6RUs0LjSLxf9isOKZqSwB=t670Ax33osY+V3Ajj8xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] null-machine: Add support for the
 "-kernel" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair.francis@xilinx.com>

On 27 February 2017 at 17:57, Thomas Huth <thuth@redhat.com> wrote:
> And I still think it does not really make sense to introduce a
> per-architecture hook here - let me cite my reply to Peter's mail a
> couple of mails later in that e-mail thread:
>
> 'The -kernel parameter is not just only dependent on the target
> architecture, it is even dependent on the machine type, e.g. on ppc it
> is quite different between embedded (e500.c) and server (spapr.c)
> variants. So an arch-specific hook might not make too much sense and
> using the generic loader is likely the best we can do - if that does not
> work, you likely can't use the "none" machine anyway.'
>
> So as far as I can see, we should either go with the generic loader
> here, or print out an error message if the user tries to run QEMU with
> the "-kernel" parameter.

I would go for "don't support -kernel". The fundamental problem
with -kernel is that it tries to be a magic "do what I mean"
command line argument. Adding extra magic is going to make things
worse, not better.

thanks
-- PMM

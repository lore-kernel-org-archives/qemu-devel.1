Received: from eggs.gnu.org ([2001:4830:134:3::10]:49266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wedsonaf@google.com>) id 1gWTA7-0005Bu-3O
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wedsonaf@google.com>) id 1gWTA6-0006sH-3Z
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:32:22 -0500
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wedsonaf@google.com>) id 1gWTA5-0006ra-Qb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 16:32:21 -0500
Received: by mail-io1-xd42.google.com with SMTP id s22so10037883ioc.8
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 13:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20181210183836.20074-1-qwandor@google.com>
	<CAFEAcA9kXXeRkFamN73XREDp4QaokMs3E9TRLThKf4zYufapSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9kXXeRkFamN73XREDp4QaokMs3E9TRLThKf4zYufapSQ@mail.gmail.com>
From: Wedson Almeida Filho <wedsonaf@google.com>
Date: Mon, 10 Dec 2018 21:32:09 +0000
Message-ID: <CAMKQLNK2J=JsgEch3G-pQ0mjW5B-n8Xc_4PDGHjFs6CfcA2ngg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement VI/VF bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Andrew Walbran <qwandor@google.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

Hi Peter,

We put this together months ago and hadn't kept up to date with the changes
here.

We're happy to see that support has been added for the VI bit. Is it going
to be available in the v3.1.0 release?

Thanks,
-Wedson

On Mon, Dec 10, 2018 at 8:41 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 10 Dec 2018 at 18:38, Andrew Walbran <qwandor@google.com> wrote:
> >
> > From: Wedson Almeida Filho <wedsonaf@google.com>
> >
> > This lets hypervisors running at EL2 inject virtual interrupts into
> guest VMs.
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Andrew Walbran <qwandor@google.com>
>
> Hi; thanks for this patch. I'm a bit confused -- can you
> explain what the patch provides that isn't already
> implemented by commit 89430fc6f80a5aef1d4cb ?
>
> thanks
> -- PMM
>

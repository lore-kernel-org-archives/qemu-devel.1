Received: from eggs.gnu.org ([2001:4830:134:3::10]:32839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLCwu-0005bk-5Z
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLCwt-00073p-Gi
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:27:56 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLCwt-00073P-C8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 15:27:55 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so17282011oie.10
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 12:27:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522192034.13318-1-pbonzini@redhat.com>
References: <20180522192034.13318-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 20:27:34 +0100
Message-ID: <CAFEAcA_mU6wvzGCvhv_OvX37QqyNkMdwfM8Kc6swNQK=tCZMYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: remove softfloat from --disable-tcg
 builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On 22 May 2018 at 20:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Even though the presence of softfloat does not cause --disable-tcg builds to fail,
> it is the single largest .o file in them.  Remove it, since TCG is the only client.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile.target          |   2 +-
>  hw/i386/x86-iommu-stub.c | 132 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/x86-iommu-stub.c

Is this new x86-iommu-stub.c file intended to be in this patch?

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRnrX-0000nF-PT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRnrW-0003ZJ-VF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:37:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRnrW-0003YW-Mu
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:37:54 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so21999733otj.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 16:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20181127184929.20065-1-jsnow@redhat.com>
In-Reply-To: <20181127184929.20065-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Nov 2018 00:37:42 +0000
Message-ID: <CAFEAcA8Rn7MyFCPYCthLG_3YXGBLV_duQ961i4Ew_8dRL+E8tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scsi: Address spurious clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Tue, 27 Nov 2018 at 18:49, John Snow <jsnow@redhat.com> wrote:
>
> Some versions of Clang prior to 6.0 (and some builds of clang after,
> such as 6.0.1-2.fc28) fail to recognize { 0 } as a valid initializer
> for a struct with subobjects when -Wmissing-braces is enabled.
>
> https://bugs.llvm.org/show_bug.cgi?id=21689 and
> https://reviews.llvm.org/rL314499 suggests this should be fixed in 6.0,
> but it might not be the case for older versions or downstream versions.
>
> For now, follow the precedent of ebf2a499 and replace the standard { 0 }
> with the accepted { } to silence this warning and allow the build to
> work under clang 6.0.1-2.fc28, and builds prior to 6.0.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Applied to master as a build fix for rc3, thanks.

-- PMM

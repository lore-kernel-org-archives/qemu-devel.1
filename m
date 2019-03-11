Received: from eggs.gnu.org ([209.51.188.92]:36054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3KPB-00069B-JO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3KPA-0001ml-MC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:51:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3KPA-0001m2-Er
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:51:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id i12so3773726otp.12
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190308135744.6480-1-peter.maydell@linaro.org>
In-Reply-To: <20190308135744.6480-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 12:51:31 +0000
Message-ID: <CAFEAcA9XR_=v+K6BxBHsMZ6vYbSrYaWnbtM=amr3pNNbgP72JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix various issues with Sphinx build
 machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 8 Mar 2019 at 13:57, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes some bugs with the Sphinx build machinery.
> Most importantly, it fixes in-tree builds, which were broken
> if you had sphinx-build available. The other two patches fix
> some more minor problems that I noticed in the course of
> fixing the first one.
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   Makefile: Fix Sphinx documentation builds for in-tree builds
>   Makefile: Fix 'make distclean'
>   Makefile: Don't install non-sphinx files in sphinx docs install

Applied to master as a buildfix, thanks. (Hopefully this will
fix the Travis builds.)

-- PMM

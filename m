Received: from eggs.gnu.org ([2001:4830:134:3::10]:37124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXbI-0001K4-G9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csXbH-00016A-PI
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:34:36 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csXbH-00014i-Jn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:34:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id w43so52080588wrb.0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 09:34:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327155234.10980-1-mreitz@redhat.com>
References: <20170327155234.10980-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 17:34:13 +0100
Message-ID: <CAFEAcA_fD6iu-dTEwa_f7zwk9NGrN-skVpYp1Fr_-sGvqvWjsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Block patches for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2017 at 16:52, Max Reitz <mreitz@redhat.com> wrote:
> The following changes since commit ea2afcf5b6727a577cf561fd8fe0d8c397ecc927:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-03-24 14:14:18 +0000)
>
> are available in the git repository at:
>
>   git://github.com/XanClic/qemu.git tags/pull-block-2017-03-27
>
> for you to fetch changes up to 700f9ce0f9f49675818ac95c8953cbc65aa1d112:
>
>   block/file-posix.c: Fix unused variable warning on OpenBSD (2017-03-27 17:28:34 +0200)
>
> ----------------------------------------------------------------
> Block patches for 2.9-rc2.
>
> ----------------------------------------------------------------
> Hi Peter,
>
> This pull request contains your build fix for OpenBSD on top so you can
> just drop it if you have merged it yourself already.

I can't take partial pullrequests like that, because the thing you
have signed is the tag at the top of the branch, not the commit
before it. However, git merge will happily handle the branch
containing a commit that's been merged already via some other
route, so that's no problem.

(In this case I hadn't actually merged the buildfix.)

Applied to master.

thanks
-- PMM

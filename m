Received: from eggs.gnu.org ([2001:4830:134:3::10]:52584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9ca-0006iu-PZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:47:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS9cZ-0007T5-VO
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:47:24 -0500
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:35358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS9cZ-0007Sc-Pu
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 17:47:23 -0500
Received: by mail-ot0-x22d.google.com with SMTP id q5so1429298oth.2
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 14:47:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221152628.12942-1-kwolf@redhat.com>
References: <20171221152628.12942-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 22:47:02 +0000
Message-ID: <CAFEAcA8=SBwRDbfNyuHk3gYCYJCF89---EAeV-Peov458afWJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/13] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 December 2017 at 15:26, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 4da5c51cac8363f86ec92dc99c38f9382d617647:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-12-20' into staging (2017-12-20 20:38:36 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to af65cdae56861d5e163559a53f7ec34142a249f1:
>
>   nvme: Add tracing (2017-12-21 16:02:14 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------

Now I get these warnings on NetBSD/OpenBSD/OSX:

  GEN     qemu-doc.txt
/root/qemu/qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
/root/qemu//qemu-img.texi:61: warning: unlikely character ( in @var.
/root/qemu//qemu-img.texi:61: warning: unlikely character ) in @var.

The UTF-8 one is longstanding and ignorable, but the other two are new.

thanks
-- PMM

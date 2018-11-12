Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMCZn-0000oe-Ew
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMCZm-0002S9-KF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:48:27 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMCZm-0002Ry-Du
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:48:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id e19-v6so7151574oii.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 05:48:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108111531.30671-1-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 13:48:04 +0000
Message-ID: <CAFEAcA8HysvgHh4RUOHQLJ0f+Y+1eSsSDjyJ1HzRS7KtLRPctA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Use 'https://' instead of 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On 8 November 2018 at 11:15, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> v4:
>  * Once more, with feeling!  Fix 'https//' in get_maintainer.pl [Philippe]
> v3:
>  * Fix broken openhackware URL [Eric]
>  * Convert a few remaining URLs [Eric]
> v2:
>  * Use HTTPS for repo.or.cz [Eric]
>
> Jeff Cody has enabled git smart HTTP support on qemu.org.  From now on HTTPS is
> the preferred protocol because it adds some protection against
> man-in-the-middle when cloning a repo.
>
> This patch series updates git:// URLs and changes them to https://.  The https:// URL format is:
>
>   https://git.qemu.org/git/<project>.git
>
> The old git:// URL format was:
>
>   git://git.qemu.org/<project>.git
>
> I have also updated git://github.com/ and repo.or.cz URLs because they offer HTTPS.
>
> I have tested that submodules continue to work after the change to .gitmodules.

Applied to master, thanks.

-- PMM

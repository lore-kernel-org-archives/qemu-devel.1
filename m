Received: from eggs.gnu.org ([2001:4830:134:3::10]:41697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJgq1-0006fN-Vr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJgpw-0008RW-7I
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:26:17 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:39282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJgpw-0008RM-2m
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:26:12 -0500
Received: by mail-ot0-x234.google.com with SMTP id v15so429290ote.6
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:26:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171128130248.901-1-eblake@redhat.com>
References: <20171128130248.901-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 14:25:51 +0000
Message-ID: <CAFEAcA8YSKsQtuRsKhcgD8Qe3-H9WBxZ7tyR1y7tGbSLZERNOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] nbd patches for -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, secalert <secalert@redhat.com>, P J P <ppandit@redhat.com>

On 28 November 2017 at 13:02, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit c7e1f823aed63f49e559e7463da76d5b320be35b:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2017-11-28 10:03:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2017-11-28
>
> for you to fetch changes up to 51ae4f8455c9e32c54770c4ebc25bf86a8128183:
>
>   nbd/server: CVE-2017-15118 Stack smash on large export name (2017-11-28 06:58:01 -0600)
>
> Patches were reviewed off-list during the CVE embargo.
>
> ----------------------------------------------------------------
> nbd patches for 2017-11-28
>
> Eric Blake - 0/2 fix two NBD server CVEs
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       nbd/server: CVE-2017-15119 Reject options larger than 32M
>       nbd/server: CVE-2017-15118 Stack smash on large export name
>
>  nbd/server.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

-- PMM

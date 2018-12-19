Received: from eggs.gnu.org ([2001:4830:134:3::10]:60157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZdoK-0007xR-VU
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZdoF-0007V7-U1
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:31:00 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:38096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZdoF-0007SU-Ns
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:30:55 -0500
Received: by mail-ot1-x32b.google.com with SMTP id e12so19475781otl.5
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20181218100941.25267-1-armbru@redhat.com>
In-Reply-To: <20181218100941.25267-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 15:30:43 +0000
Message-ID: <CAFEAcA86si-tq9xWkLa3m_vdbj4syVse1QNaumHMzhwHH92m3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] QAPI patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 18 Dec 2018 at 10:18, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f6c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into staging (2018-12-17 13:04:25 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-12-18
>
> for you to fetch changes up to ce1a1aec47877a281d69dbc2e65f86bfe8fea231:
>
>   qapi: fix flat union on uncovered branches conditionals (2018-12-18 07:57:36 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2018-12-18
>
> * QMP events SHUTDOWN and RESET now carry a reason
> * New QMP command query-current-machine
> * QMP/HMP command system_wakeup now fails when the guest isn't
>   suspended, or doesn't even support suspend.
> * Fix build for --disable-replication
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

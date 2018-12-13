Received: from eggs.gnu.org ([2001:4830:134:3::10]:38487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXV8E-0005DH-MX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXV8D-0002Oy-GJ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:50:42 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:46772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXV8D-0002L7-8i
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:50:41 -0500
Received: by mail-oi1-x236.google.com with SMTP id x202so2309295oif.13
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 09:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20181212101145.3496-1-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 17:50:28 +0000
Message-ID: <CAFEAcA9iE_3p6_JKj1tcFqNfQXr_aEk2PqEnhmLTEc0Ei0jiWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Monitor patches for 2018-12-12
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

On Wed, 12 Dec 2018 at 10:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-12-12
>
> for you to fetch changes up to c55f070b7195cee4e06998c10f57f13c7df98dbd:
>
>   tests: add oob functional test for test-qmp-cmds (2018-12-12 10:28:27 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2018-12-12
>
> * Fixes related to running the monitor in an I/O thread
> * Change how OOB-enabled QMP monitors handle flow control: suspend
>   monitor instead dropping commands
> * Offer QMP capability "oob" unconditionally, remove "x-oob"
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

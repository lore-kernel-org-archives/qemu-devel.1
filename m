Received: from eggs.gnu.org ([209.51.188.92]:35159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvleL-0006zi-OO
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvleL-0002ow-0I
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:20:09 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gvleK-0002oY-Oq
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:20:08 -0500
Received: by mail-ot1-x32b.google.com with SMTP id c18so7589538otl.13
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 08:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20190218140607.31998-1-armbru@redhat.com>
In-Reply-To: <20190218140607.31998-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Feb 2019 16:19:56 +0000
Message-ID: <CAFEAcA8DD1cZLwNU+erXjKM5KOg4gYBzqrCtTZ1vaiMyRj6F2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] QAPI patches for 2019-02-18
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

On Mon, 18 Feb 2019 at 14:14, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469af:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190215' into staging (2019-02-15 11:12:14 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2019-02-18
>
> for you to fetch changes up to 183e4281a30962729b760dfe8bed5aab27238b0c:
>
>   qapi: move RTC_CHANGE to the target schema (2019-02-18 14:44:05 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2019-02-18
>
> * Support for QAPI conditionals is finally complete.  query-qmp-schema
>   now reflects compile-time configuration accurately.  In particular,
>   it shows only commands that actually exist in in this build.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

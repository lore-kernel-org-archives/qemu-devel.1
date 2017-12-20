Received: from eggs.gnu.org ([2001:4830:134:3::10]:39553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgGw-0004dq-3N
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRgGu-0005JY-Un
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:27:06 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:43299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRgGu-0005Ii-Q2
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:27:04 -0500
Received: by mail-ot0-x243.google.com with SMTP id b56so5630317otd.10
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 07:27:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220081927.8761-1-armbru@redhat.com>
References: <20171220081927.8761-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 15:26:43 +0000
Message-ID: <CAFEAcA8n1V14r3JqRi=sHiBNfyuE+sNg1104e7w8rWVGtg6Q_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] Command line patches for 2017-12-18
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

On 20 December 2017 at 08:19, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit af352675efb7e92a1f5f6461a042a12015ab3d12:
>
>   Merge remote-tracking branch 'remotes/aurel/tags/pull-target-sh4-20171218' into staging (2017-12-19 19:11:11 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-cmdline-2017-12-18-v2
>
> for you to fetch changes up to 3e05349de8bd6744d23a26beac9ed6fb2e286f80:
>
>   option: Drop unused get_param_value(), get_next_param_value() (2017-12-20 09:11:50 +0100)
>
> ----------------------------------------------------------------
> Command line patches for 2017-12-18
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       option: Remove shadowing opt decl from qemu_opt_print()
>
> Markus Armbruster (9):
>       qemu-options: Remove stray colons from output of --help
>       qemu-options: Fix markup of -netdev l2tpv3
>       qemu-options qemu-doc: Move "Device URL Syntax" to qemu-doc
>       qemu-options: Move -iscsi under "Block device options"
>       qemu-options: Add missing -iscsi Texinfo documentation
>       qemu-options: Polish section "TPM device options"
>       qemu-options: Polish section "Character device options"
>       qemu-options: Belatedly document --watchdog-action inject-nmi
>       option: Drop unused get_param_value(), get_next_param_value()
>
>  include/qemu/option.h  |   5 -
>  qemu-doc.texi          | 216 ++++++++++++++++++++++++++++++++++
>  qemu-options-wrapper.h |   2 +-
>  qemu-options.hx        | 306 ++++++++-----------------------------------------
>  scripts/hxtool         |   3 +-
>  util/qemu-option.c     |  36 +-----
>  6 files changed, 267 insertions(+), 301 deletions(-)

Applied, thanks.

-- PMM

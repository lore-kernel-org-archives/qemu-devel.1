Received: from eggs.gnu.org ([2001:4830:134:3::10]:37627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1et9XQ-0003Fy-Dm
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1et9XP-0004Do-I9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:09:40 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1et9XP-0004DJ-CO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:09:39 -0500
Received: by mail-ot0-x244.google.com with SMTP id 108so17805238otv.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 02:09:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305175107.20210-1-kwolf@redhat.com>
References: <20180305175107.20210-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 10:09:18 +0000
Message-ID: <CAFEAcA_gi4Pt41arfrmseZzxs0YZtkvBShcszRftW0y0ar4Z1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/38] Block layer patches
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

On 5 March 2018 at 17:51, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 86f4c7e05b1c44dbe1b329a51f311f10aef6ff34:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180302' into staging (2018-03-02 14:37:10 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to bfe1a14c180ec44c033be12b9151252ffda69292:
>
>   block: Fix NULL dereference on empty drive error (2018-03-05 18:45:32 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> ----------------------------------------------------------------

This pull turns out to add a bunch of tests that end in the name "error",
which triggers my buildlog scanning scripts that look for "error:".
Could we rename those?

thanks
-- PMM

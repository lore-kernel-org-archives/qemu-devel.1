Received: from eggs.gnu.org ([2001:4830:134:3::10]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7z3-0000CQ-P4
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gQ7z1-0001je-PY
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:42:45 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gQ7z1-0001bB-KO
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:42:43 -0500
Received: by mail-oi1-x231.google.com with SMTP id j21so9473617oii.8
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 01:42:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181122184545.31487-1-kwolf@redhat.com>
References: <20181122184545.31487-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Nov 2018 09:42:20 +0000
Message-ID: <CAFEAcA9BPXEA0zZp1B1KzNBHfQSgTnUvvexTmjwOCwBU6xJ5DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/16] Block layer patches
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

On 22 November 2018 at 18:45, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d16:
>
>   Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 6bd858b3117a5aab066f3cf02ca72000eaa10ddb:
>
>   block: Update BlockDriverState.inherits_from on bdrv_drop_intermediate() (2018-11-22 19:37:31 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Fix update of BDRV_O_AUTO_RDONLY in update_flags_from_options()
> - block: Fix option inheritance after stream/commit job graph changes
> - qemu-img: Fix memory leak and typo in error message
> - nvme: Fixes for lockups and crashes
> - scsi-disk: Fix crash if underlying host file or disk returns error
> - Several qemu-iotests fixes and improvements
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM

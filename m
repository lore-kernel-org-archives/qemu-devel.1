Received: from eggs.gnu.org ([2001:4830:134:3::10]:58707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXn4i-0001pO-Vr
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXn4f-0002cv-9v
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:00:16 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXn4f-0002Uq-03
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:00:13 -0500
Received: by mail-ot1-x32c.google.com with SMTP id i20so5318281otl.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:00:10 -0800 (PST)
MIME-Version: 1.0
References: <1544606032-16924-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1544606032-16924-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 12:59:59 +0000
Message-ID: <CAFEAcA_S91c1bD2qNTrVpyNrHRgwMJOF1o2FYs5FwouW3QpVLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Set minimum compiler versions to GCC
 4.8 and Clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 12 Dec 2018 at 09:13, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2018-12-12
>
> for you to fetch changes up to 2b4c1125ac3db2734222ff43c25388a16aca4a99:
>
>   i2c: Move typedef of bitbang_i2c_interface to i2c.h (2018-12-12 10:01:13 +0100)
>
> ----------------------------------------------------------------
> Explicitly check for minimum compiler versions.
> Remove obsolete code for old compilers that is now not required anymore.
> Fix a duplicated typedef for Clang 3.4.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes (we have a section for build environment
requirements at the bottom).

-- PMM

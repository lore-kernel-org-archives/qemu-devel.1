Received: from eggs.gnu.org ([2001:4830:134:3::10]:41034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJsp-0007es-DB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJso-00087W-It
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:11:55 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJso-000873-DG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:11:54 -0400
Received: by mail-wr0-x235.google.com with SMTP id c11so37327038wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-14-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-14-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:11:32 +0100
Message-ID: <CAFEAcA9TWKc9Py=MMMsMpGU7+n-8FJf-Xrd_7951xMMQ4YBY+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 13/13] new: run_risu.sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> A simple script to work through running all of a bunch of files with
> record/playback traces. Dumps a summary and the number of failed tests
> at the end.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v5
>   - author, license, usage header
> v3
>   - tweak to allow specifying RISU binary
> ---
>  run_risu.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 66 insertions(+)
>  create mode 100755 run_risu.sh
>
> diff --git a/run_risu.sh b/run_risu.sh

I think this should go into contrib/.

thanks
-- PMM

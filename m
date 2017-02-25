Received: from eggs.gnu.org ([2001:4830:134:3::10]:39989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chfLX-0007ps-Ng
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chfLW-0001Cv-RT
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:37:23 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chfLW-0001Ca-KD
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:37:22 -0500
Received: by mail-wm0-x231.google.com with SMTP id v186so34571298wmd.0
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 08:37:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487879642-16139-1-git-send-email-armbru@redhat.com>
References: <1487879642-16139-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 16:37:00 +0000
Message-ID: <CAFEAcA_YQS_EDJ5dZkiQ5KcMjZhN-U0opTeJh8r8O_SSMG8Cvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] option cutils: Fix and clean up
 number conversions
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

On 23 February 2017 at 19:53, Markus Armbruster <armbru@redhat.com> wrote:
> QemuOpts has its own code to convert strings to numbers, and being
> QemuOpts, it gets it wrong.  util/cutils is less wrong.  Fix it up
> some, and reuse it for QemuOpts.
>
> The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-util-2017-02-23
>
> for you to fetch changes up to 75cdcd1553e74b5edc58aed23e3b2da8dabb1876:
>
>   option: Fix checking of sizes for overflow and trailing crap (2017-02-23 20:35:36 +0100)
>
> ----------------------------------------------------------------
> option cutils: Fix and clean up number conversions
>

Applied, thanks.

-- PMM

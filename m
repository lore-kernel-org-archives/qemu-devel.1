Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epI0P-0001c2-5q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epI0O-0000Xc-Ez
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:23:37 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epI0O-0000XE-7h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:23:36 -0500
Received: by mail-pl0-x241.google.com with SMTP id ay8so5334188plb.4
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:23:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:23:14 +0000
Message-ID: <CAFEAcA8-D=f-kAKMB+cj91ffUW2MD0wDQt0XA_3gVec=YDBfkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH REPOST v1 0/8] Group support and random
 clean-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 23 February 2018 at 15:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Hi,
>
> This is essentially a re-post but with a wider distribution. There is
> one extra patch which adds the FP16 1 source data processing. This is for
> discussion on how best to represent all the different architectural
> versions by using the second field in the aarch64.risu file.
>
> Alex Benn=C3=A9e (8):
>   risugen: support @GroupName in risu files
>   aarch64.risu: clean-up and annotate with groups
>   aarch64.risu: add cryptographic extensions for v8.2
>   new contrib/generate_all.sh: batch risugen script
>   contrib/run_risu.sh: allow appending of QEMU_FLAGS
>   contrib/run_risu.sh: don't set -e
>   contrib/run_risu.sh: add a visual cue for a clean-run
>   aarch64.risu: update Floating-point data-processing (1 source)

I've pushed all but 3 and 5 to risu master. I don't actually
object to patch 5 and will probably push that too, but I figure we
could have the conversation first :-)

-- PMM

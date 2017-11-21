Received: from eggs.gnu.org ([2001:4830:134:3::10]:32922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7Lx-0003qm-Kp
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH7Lp-0001Pa-UT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:37 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:44591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH7Lp-0001PJ-OK
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:08:29 -0500
Received: by mail-wm0-x233.google.com with SMTP id r68so2903112wmr.3
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 04:08:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171031145444.13766-1-alex.bennee@linaro.org>
References: <20171031145444.13766-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 12:08:08 +0000
Message-ID: <CAFEAcA9SrXVLAwoi=ZDxkCN9WOMVtQyR_jEkn9b3qn-yb9=dKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 0/7] Add @Group support and some
 aarch64.risu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 31 October 2017 at 14:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi Peter,
>
> My RISU patch queue was running a little long so I thought I should
> push up stuff that was ready. The first few patches are simply
> clean-ups to the aarch64.risu file, mostly removing duplicate blocks
> that have crept in.
>
> There is a prerequisite clean-up patch which moves the filtering into
> the common risugen code and passes an array of keys to the backend.
>
> Then I add support for @GroupName annotations which allow for a nicer
> selection of groups of instructions. This works across all
> architectures now.
>
> Finally a big (but mechanical) update of the aarch64.risu file. I've
> aligned the names of the major groups to what the ASL/ARM ARM uses and
> added some example @Groups for the gross sections. I expect to add
> more fine-grained groups later as we add the new half-precision and
> SVE instructions.
>
> Alex Benn=C3=A9e (7):
>   aarch64.risu: document naming conventions
>   aarch64.risu: remove duplicate AdvSIMD Scalar 3 same block
>   aarch64.risu: remove duplicate AdvSIMD scalar 2 reg misc block
>   aarch64.risu: update AdvancedSIMD across lanes
>   risugen/risugen_$arch: factor out instruction selection
>   risugen: support @GroupName in risu files
>   aarch64.risu: clean-up and annotate with groups

I've pushed patches 1-5 to risu master, and provided comments
on patch 6. I'm going to just assume 7 is ok.

thanks
-- PMM

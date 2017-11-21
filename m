Received: from eggs.gnu.org ([2001:4830:134:3::10]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHBlq-0006PR-UI
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHBlp-0007b2-V8
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:51:38 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHBlp-0007ap-Oq
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:51:37 -0500
Received: by mail-oi0-x230.google.com with SMTP id a75so8985528oib.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 08:51:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 16:51:16 +0000
Message-ID: <CAFEAcA8-kyLTiaJxfwmWx-85qZ2W31V8whqLot9hPX5AizCZng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 00/10] Initial support for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Dave P Martin <Dave.Martin@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 7 November 2017 at 15:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi,
>
> These patches apply on-top of the last clean-up series:
>
>   Subject: [RISU PATCH 0/7] Add @Group support and some aarch64.risu clea=
nups
>   Date: Tue, 31 Oct 2017 14:54:37 +0000
>   Message-Id: <20171031145444.13766-1-alex.bennee@linaro.org>
>
> This series adds support for SVE to RISU. Most of the initial patches
> are plumbing changes to better support arch specific option flags
> (cleaning up a TODO in the process). I also needed to ensure configure
> actually honoured CPPFLAGS so it could be passed yet to be released
> headers.
>
> The actual guts of the SVE support is in 3 patches. One to risugen so
> it can generate random values for the vector registers. If this isn't
> done you get inconsistent runs because of left over junk in the
> registers. The remaining two patches add support for copying the SVE
> vectors from the signal context and dumping any differences found.
>
> To test this I ran on the Foundation model with:
>
>   ${RTSM_MODEL} --no-secure-memory --gicv3 --data=3D${BL1_FIRMWARE}@0x0 -=
-data=3D${FIP_FIRMWARE}@0x8000000 \
>                 --semihost --network nat --network-nat-ports=3D8022=3D22 =
--block-device ${DISK_IMAGE}
>
> With my hacked up copy of secure firmware to ensure SVE is enabled.
> You also need a kernel with SVE support:
>
>   Subject: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
>   Date: Tue, 31 Oct 2017 15:50:52 +0000
>   Message-Id: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
>
> My testing so far has been to ensure that each run on the foundation
> model is deterministic (same m5sum on each trace) and that differences
> are printed out when the user-space vector length is tweaked
> (/proc/sys/abi/sve_default_vector_length).
>
>
> Alex Benn=C3=A9e (10):
>   build-all-arches: drop -t (for tty) from docker invocation
>   risu.c: split out setting up options
>   risu.c: add missing --trace longopt
>   risu: move optional args to each architecture
>   configure: allow repeated invocation of configure in build dir
>   configure: support CPPFLAGS
>   risugen: add --sve support
>   aarch64.risu: initial SVE instruction
>   risu_reginfo_aarch64: add reginfo_copy_sve
>   risu_reginfo_aarch64: add SVE support to reginfo_dump_mismatch

I've applied patches 1, 2, 3, 5, 6 to risu master.

thanks
-- PMM

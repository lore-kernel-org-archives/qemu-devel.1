Received: from eggs.gnu.org ([2001:4830:134:3::10]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbZ1-00075o-7w
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbYz-0008BC-W5
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:28:07 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:41748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elbYz-0008Ab-SE
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:28:05 -0500
Received: by mail-oi0-x22f.google.com with SMTP id t135so1321921oif.8
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 06:28:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 14:27:44 +0000
Message-ID: <CAFEAcA_vCRm++BENWKPVVfwd25cc7AU8-g=7oe-HoPfMhNHGLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 00/32] Add ARMv8.2
 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 February 2018 at 17:31, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi,
>
> Some of this was posted before as part of the various partial patch
> series when we first started messing around with FP16 in softfloat.
> This series is now just the ARM bits and expects to have the V4
> softfloat patches as a prerequisite:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2018-02/msg01330.html
>
> Alternatively you can grab the full tree from:
>
>   https://github.com/stsquad/qemu/tree/arm-fp16-v2
>
> I've tested with the following RISU test binaries:
>
>   http://people.linaro.org/~alex.bennee/testcases/arm64.risu/testcases.ar=
mv8.2_hp.tar.xz
>
> And of course I ran the original RISU tests with:
>
>   -cpu any,fp16=3Doff
>
> But I guess we really just need to carefully regenerate the testcases
> to not include UNDEF's which get added with future revisions of the
> specification.
>
> Anyway please review.

I see Richard's reviewed this one, so I just had the one comment
about feature flag naming. Could you also fix the checkpatch long-lines
warnings and look at whatever the problem that caused patchew build
failures is, please?

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQXQ8-0001EN-C2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQXQ7-0004r6-Ik
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:15:36 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQXQ7-0004ou-A7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 07:15:35 -0400
Received: by mail-wm0-x235.google.com with SMTP id i127so10801254wma.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 04:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170621154244.28309-1-alex.bennee@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 12:15:13 +0100
Message-ID: <CAFEAcA9GoPhxQJpH+Q=Y=uWx36OmB24aJS+=94Sye+V6o1jVJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v6 00/10] Record/replay patches
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

On 21 June 2017 at 16:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Hi Peter,
>
> Re-based with review comments addressed and tags added where
> appropriate.
>
> Alex Benn=C3=A9e (10):
>   README: document the coding style used for risu
>   build-all-archs: support cross building via docker
>   risu: a bit more verbosity when starting
>   risu: paramterise send/receive functions
>   risu: add header to trace stream
>   risu: add simple trace and replay support
>   risu: handle trace through stdin/stdout
>   risu: add support compressed tracefiles
>   new: record_traces.sh helper script
>   new: run_risu.sh script

Hi -- these look OK to me so I have applied them to risu master
(I fixed up a few checkpatch style issues but nothing major).

I notice there's no documentation of the record/replay
feature, though -- could you send a patch which adds
discussion of how to use it to the README file, please?

The 'Building' section in the README should also mention that
we recommend having zlib available.

thanks
-- PMM

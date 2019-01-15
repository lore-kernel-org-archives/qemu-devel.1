Received: from eggs.gnu.org ([209.51.188.92]:43847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjTkX-0002fJ-Jy
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gjTkW-0001bP-BF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:47:45 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gjTkV-0001a9-S8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:47:44 -0500
Received: by mail-oi1-x235.google.com with SMTP id i6so2958222oia.6
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:47:42 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<20181207095417.GF13784@redhat.com>
	<CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
	<CAPyFy2Dq_7K+4tZjvBcWxdyFJZzEV4Kz_C2dqQ0-Hu+BwOsDyA@mail.gmail.com>
In-Reply-To: <CAPyFy2Dq_7K+4tZjvBcWxdyFJZzEV4Kz_C2dqQ0-Hu+BwOsDyA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Jan 2019 18:47:29 +0000
Message-ID: <CAFEAcA-VWHgcfmKTfjTGGQXKTp8V5thsFO0tJ6R-p+MQHkcm1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hosted CI for FreeBSD - Cirrus CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, 15 Jan 2019 at 18:34, Ed Maste <emaste@freebsd.org> wrote:
> My most recent test build with cirrus-ci
> (https://cirrus-ci.com/github/emaste/qemu) failed with:
> /usr/bin/ld: error: undefined symbol: fdt_check_full
> >>> referenced by spapr_hcall.c:1797 (/tmp/cirrus-ci-build/hw/ppc/spapr_hcall.c:1797)
> >>>               hw/ppc/spapr_hcall.o:(h_update_dt)
> c++: error: linker command failed with exit code 1 (use -v to see invocation)
> gmake[1]: *** [Makefile:196: qemu-system-ppc64] Error 1
> gmake: *** [Makefile:428: subdir-ppc64-softmmu] Error 2
> gmake: *** Waiting for unfinished jobs....
>
> It looks like this was introduced between
> 9b2e891ec5ccdb4a7d583b77988848282606fdea (works) and
> 44ba6010635641a538c9b9b1f377dfa288751906 (fails). The .cirrus.yml file
> in my branch is at least good enough to catch this sort of thing, so
> I'll send the patch over (while trying to look into this).

Commit fea35ca4b8e68b4fa updates our configure test to require
a libfdt version that has fdt_check_full() in it, so in theory
what is supposed to happen is that we will use the local
version in dtc/ if the system libfdt is not new enough.
Has that process gone wrong? Is the build using the system
libfdt or the one we provide in the submodule ?

thanks
-- PMM

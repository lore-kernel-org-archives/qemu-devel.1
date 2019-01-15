Received: from eggs.gnu.org ([209.51.188.92]:35102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjTWT-0005EU-2R
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjTWP-0001Co-CK
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:33:11 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:39467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjTWM-00018q-UQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:33:07 -0500
Received: by mail-it1-f174.google.com with SMTP id a6so5769319itl.4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:33:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<20181207095417.GF13784@redhat.com>
	<CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
In-Reply-To: <CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 15 Jan 2019 13:32:51 -0500
Message-ID: <CAPyFy2Dq_7K+4tZjvBcWxdyFJZzEV4Kz_C2dqQ0-Hu+BwOsDyA@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 09:57, Ed Maste <emaste@freebsd.org> wrote:
>
> Indeed - having a hosted CI service to build on FreeBSD is something
> I've wanted for a long time; so much better if one service can support
> most or all platforms of interest.

My most recent test build with cirrus-ci
(https://cirrus-ci.com/github/emaste/qemu) failed with:
/usr/bin/ld: error: undefined symbol: fdt_check_full
>>> referenced by spapr_hcall.c:1797 (/tmp/cirrus-ci-build/hw/ppc/spapr_hcall.c:1797)
>>>               hw/ppc/spapr_hcall.o:(h_update_dt)
c++: error: linker command failed with exit code 1 (use -v to see invocation)
gmake[1]: *** [Makefile:196: qemu-system-ppc64] Error 1
gmake: *** [Makefile:428: subdir-ppc64-softmmu] Error 2
gmake: *** Waiting for unfinished jobs....

It looks like this was introduced between
9b2e891ec5ccdb4a7d583b77988848282606fdea (works) and
44ba6010635641a538c9b9b1f377dfa288751906 (fails). The .cirrus.yml file
in my branch is at least good enough to catch this sort of thing, so
I'll send the patch over (while trying to look into this).

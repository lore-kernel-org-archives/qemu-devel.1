Received: from eggs.gnu.org ([209.51.188.92]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjTvB-0006eN-9Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjTv9-0007SX-Ip
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:45 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:44480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjTv9-0007Jl-8Y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:58:43 -0500
Received: by mail-io1-f50.google.com with SMTP id r200so2892534iod.11
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:58:18 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<20181207095417.GF13784@redhat.com>
	<CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
	<CAPyFy2Dq_7K+4tZjvBcWxdyFJZzEV4Kz_C2dqQ0-Hu+BwOsDyA@mail.gmail.com>
	<CAFEAcA-VWHgcfmKTfjTGGQXKTp8V5thsFO0tJ6R-p+MQHkcm1g@mail.gmail.com>
In-Reply-To: <CAFEAcA-VWHgcfmKTfjTGGQXKTp8V5thsFO0tJ6R-p+MQHkcm1g@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 15 Jan 2019 13:58:05 -0500
Message-ID: <CAPyFy2AJR93Sk65UnB52u1Wz_T-mzzdMcs9b1HDFdb4cRsz+_A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, 15 Jan 2019 at 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > It looks like this was introduced between
> > 9b2e891ec5ccdb4a7d583b77988848282606fdea (works) and
> > 44ba6010635641a538c9b9b1f377dfa288751906 (fails). The .cirrus.yml file
> > in my branch is at least good enough to catch this sort of thing, so
> > I'll send the patch over (while trying to look into this).
>
> Commit fea35ca4b8e68b4fa updates our configure test to require
> a libfdt version that has fdt_check_full() in it, so in theory
> what is supposed to happen is that we will use the local
> version in dtc/ if the system libfdt is not new enough.
> Has that process gone wrong? Is the build using the system
> libfdt or the one we provide in the submodule ?

>From the log[1] it looks like it's building the libfdt from dtc/.
Unfortunately I'm unable to dig in deeper into the hosted build (I
have only the logs), and my local build attempts are currently failing
due to unrelated issues. I'll investigate further as soon as I can.

[1] https://cirrus-ci.com/task/6254685977575424

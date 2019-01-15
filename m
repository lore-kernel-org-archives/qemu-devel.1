Received: from eggs.gnu.org ([209.51.188.92]:54403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjWBS-0003wq-H8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gjWBQ-0007F5-As
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:42 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:38928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gjWBQ-0007D1-0u
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:40 -0500
Received: by mail-it1-f176.google.com with SMTP id a6so6480962itl.4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:23:35 -0800 (PST)
MIME-Version: 1.0
References: <CAPyFy2CWKEmYoYrDY=pHQVxXjMZnPts5qKVHL94yx0smTjx9bA@mail.gmail.com>
	<20181207095417.GF13784@redhat.com>
	<CAPyFy2AxmXSu8NsVpTWtKQYbjrL+72GvCUpQ=T=ffooyQPov4g@mail.gmail.com>
	<CAPyFy2Dq_7K+4tZjvBcWxdyFJZzEV4Kz_C2dqQ0-Hu+BwOsDyA@mail.gmail.com>
	<CAFEAcA-VWHgcfmKTfjTGGQXKTp8V5thsFO0tJ6R-p+MQHkcm1g@mail.gmail.com>
	<CAPyFy2AJR93Sk65UnB52u1Wz_T-mzzdMcs9b1HDFdb4cRsz+_A@mail.gmail.com>
In-Reply-To: <CAPyFy2AJR93Sk65UnB52u1Wz_T-mzzdMcs9b1HDFdb4cRsz+_A@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Tue, 15 Jan 2019 16:23:21 -0500
Message-ID: <CAPyFy2A6j-3WZ-A4X0pOAcwsqw_py9pXhg-m-njCj_gDLQEKrA@mail.gmail.com>
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

On Tue, 15 Jan 2019 at 13:58, Ed Maste <emaste@freebsd.org> wrote:
>
> From the log[1] it looks like it's building the libfdt from dtc/.
> Unfortunately I'm unable to dig in deeper into the hosted build (I
> have only the logs), and my local build attempts are currently failing
> due to unrelated issues. I'll investigate further as soon as I can.
>
> [1] https://cirrus-ci.com/task/6254685977575424

Somehow I had an unintended change in my branch where I added
.cirrus.yml that reverted the dtc submodule to the previous version.
With that fixed the build and test is successful on FreeBSD 12:
https://cirrus-ci.com/task/5528406336733184

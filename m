Received: from eggs.gnu.org ([2001:4830:134:3::10]:32792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFlg-0006Ln-Rr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFlb-0004xd-4L
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:03:36 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:41483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFla-0004xO-Vh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:03:31 -0400
Received: by mail-ot0-x22d.google.com with SMTP id t1-v6so20982682oth.8
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 08:03:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525182297-205763-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
	<1525182297-205763-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 16:03:09 +0100
Message-ID: <CAFEAcA8TOLjW7aEniG4EhBPF-_mCWWzdJL58SjC915Ket2PfZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/5] arm: boot: set boot_info starting
 from first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 May 2018 at 14:44, Igor Mammedov <imammedo@redhat.com> wrote:
> Even though nothing is currently broken (since all boards
> use first_cpu as boot cpu), make sure that boot_info is set
> on all CPUs.
> If some board would like support heterogenuos setup (i.e.
> init boot_info on subset of CPUs) in future, it should add
> a reasonable API to do it, instead of starting assigning
> boot_info from some CPU and till the end of present CPUs
> list.

It's a bit confusing to only send one patch rather than the
whole set -- our automated patch application and testing
tooling gets confused. I noticed this one by chance because
I was skimming the commit log for v3 and noticed that it was
missing this text. If the change had been in code rather than
in the commit message I would probably not have picked it up...

thanks
-- PMM

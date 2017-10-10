Received: from eggs.gnu.org ([2001:4830:134:3::10]:35066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xSH-0004Oo-32
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1xSD-0002XO-WB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:32:29 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:50251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1xSD-0002X7-MX
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:32:25 -0400
Received: by mail-pf0-x22c.google.com with SMTP id m63so17776280pfk.7
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:32:25 -0700 (PDT)
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96a6584b-ee29-13a2-622a-b07788ffcf79@linaro.org>
Date: Tue, 10 Oct 2017 09:32:22 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10/10/2017 07:22 AM, Peter Maydell wrote:
> I can see a couple of options:
>  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
>      and move to that
>      [downsides: would be in the middle of QEMU's own release cycle,
>       pretty late to fix any problems with the new version;
>       rather a big change to put into stable]
>  (2) move to u-boot current head-of-unstable
>      [downsides: would mean running some random git commit version,
>       also not really very suitable for stable]

It's always difficult to sync the release cycles of disjoint projects.

You had nothing particularly good to say about using a non-released u-boot, so
really you have two options:

  (a) Update u-boot for 2.12 and not 2.11,
  (b) Track u-boot during its release process, noticing and reporting problems,
      and updating to the final release when it appears.  If you go this route,
      you may well have to slip our release if theirs slips.

The second option is not particularly appealing.

Is there another possibility in which we split the packaging to cope with the
current u-boot?  Normally no one builds u-boot; we simply package it for
licensing.  If the packaging were in two parts, one could unpack the first part
only and not encounter the problem.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhTd-0002Q0-Ju
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGhTX-0002Pj-9h
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGhTX-0002Ng-19
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:58:27 -0400
Date: Fri, 2 Jun 2017 15:58:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170602075821.GC2120@lemon.lan>
References: <20170526075246.20265-1-famz@redhat.com>
	<CAFEAcA_LGcKShOrLDi-qU65GaJ8tBcoW43Ev2u-C1x9y0hrN4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_LGcKShOrLDi-qU65GaJ8tBcoW43Ev2u-C1x9y0hrN4g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, 06/01 18:18, Peter Maydell wrote:
> On 26 May 2017 at 08:52, Fam Zheng <famz@redhat.com> wrote:
> > The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
> >
> >   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
> >
> > for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:
> >
> >   block: make accounting thread-safe (2017-05-26 09:25:30 +0800)
> >
> > ----------------------------------------------------------------
> >
> > For Paolo's block layer thread safety part I and my docker testing
> > enhancements.
> >
> > ----------------------------------------------------------------
> 
> Hi. I'm afraid this doesn't build on BSD or OSX:
> 
> libqemuutil.a(stats64.o): In function `stat64_rdlock':
> /root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In funclibqemuutil.a(stats64.o): In function
> `stat64_rdlock':
> /root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_add32_carry':
> /root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_min_slow':
> /root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_max_slow':
> /root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'
> tilibqemuutil.a(stats64.o): In function `stat64_rdlock':
> /root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_add32_carry':
> /root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_min_slow':
> /root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_max_slow':
> /root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'
> on `stat64_add32_carry':
> /root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_min_slow':
> /root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
> libqemuutil.a(stats64.o): In function `stat64_max_slow':
> /root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'
> 
> 
> and
> /Users/pm215/src/qemu-for-merges/util/stats64.c:24:9: error: implicit
> declaration of function 'cpu_relax' is invalid in C99
> [-Werror,-Wimplicit-function-declaration]
>         cpu_relax();
>         ^
> 
> 
> Looks like an omitted include of qemu/processor.h ?

Yes, including this one works for me, I'll add it and send v2. Thanks,

Fam

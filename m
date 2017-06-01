Received: from eggs.gnu.org ([2001:4830:134:3::10]:37618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGTkd-0000Vc-2U
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGTkc-0002RB-5S
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:19:11 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGTkb-0002Qy-TV
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:19:10 -0400
Received: by mail-wm0-x22b.google.com with SMTP id n195so41185197wmg.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 10:19:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170526075246.20265-1-famz@redhat.com>
References: <20170526075246.20265-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 18:18:48 +0100
Message-ID: <CAFEAcA_LGcKShOrLDi-qU65GaJ8tBcoW43Ev2u-C1x9y0hrN4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 26 May 2017 at 08:52, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
>
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/docker-and-block-pull-request
>
> for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:
>
>   block: make accounting thread-safe (2017-05-26 09:25:30 +0800)
>
> ----------------------------------------------------------------
>
> For Paolo's block layer thread safety part I and my docker testing
> enhancements.
>
> ----------------------------------------------------------------

Hi. I'm afraid this doesn't build on BSD or OSX:

libqemuutil.a(stats64.o): In function `stat64_rdlock':
/root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In funclibqemuutil.a(stats64.o): In function
`stat64_rdlock':
/root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_add32_carry':
/root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_min_slow':
/root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_max_slow':
/root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'
tilibqemuutil.a(stats64.o): In function `stat64_rdlock':
/root/qemu/util/stats64.c:24: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_add32_carry':
/root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_min_slow':
/root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_max_slow':
/root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'
on `stat64_add32_carry':
/root/qemu/util/stats64.c:64: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_min_slow':
/root/qemu/util/stats64.c:85: undefined reference to `cpu_relax'
libqemuutil.a(stats64.o): In function `stat64_max_slow':
/root/qemu/util/stats64.c:114: undefined reference to `cpu_relax'


and
/Users/pm215/src/qemu-for-merges/util/stats64.c:24:9: error: implicit
declaration of function 'cpu_relax' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        cpu_relax();
        ^


Looks like an omitted include of qemu/processor.h ?

I'm not sure why this compiles on Linux...

thanks
-- PMM

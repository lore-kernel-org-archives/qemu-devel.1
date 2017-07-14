Received: from eggs.gnu.org ([2001:4830:134:3::10]:46105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW32E-0003xL-LG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW32D-00072j-Sj
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:01:42 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW32D-00072L-LI
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 12:01:41 -0400
Received: by mail-wm0-x233.google.com with SMTP id 62so24400668wmw.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 09:01:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714151121.18447-1-berrange@redhat.com>
References: <20170714151121.18447-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 17:01:19 +0100
Message-ID: <CAFEAcA__Zkxf7cdtH7fi-wxBP-JP59iOquoR0oVgv793AYRhPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 0/4] Merge sockets 2017/07/11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 July 2017 at 16:11, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 6c6076662d98c068059983d411cb2a8987ba5670:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-07-14 12:16:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-3
>
> for you to fetch changes up to 563a3987b980a36e6941720a99d5cf36960f78ea:
>
>   io: preserve ipv4/ipv6 flags when resolving InetSocketAddress (2017-07-14 14:28:29 +0100)
>
> ----------------------------------------------------------------
> Merge sockets 2017/07/11 v3
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (4):
>   sockets: ensure we can bind to both ipv4 & ipv6 separately
>   sockets: don't block IPv4 clients when listening on "::"
>   sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
>   io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
>
>  io/dns-resolver.c   |  6 +++--
>  util/qemu-sockets.c | 71 +++++++++++++++++++++++++++++++++++++++--------------
>  2 files changed, 56 insertions(+), 21 deletions(-)
>

Applied, thanks.

-- PMM

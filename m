Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4291CA9EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8437421D7A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8437421D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLEhY-0008Ap-MU
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iLEgh-0007JR-73
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iLEge-00019M-DD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iLEge-00018P-44
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:56:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C97313082B02;
 Thu, 17 Oct 2019 22:56:01 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B78F060C5D;
 Thu, 17 Oct 2019 22:55:49 +0000 (UTC)
Date: Thu, 17 Oct 2019 19:55:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Python 2 and test/vm/netbsd
Message-ID: <20191017225548.GL4084@habkost.net>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net>
 <20191017220541.GJ4084@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017220541.GJ4084@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 17 Oct 2019 22:56:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 07:05:41PM -0300, Eduardo Habkost wrote:
> On Wed, Oct 16, 2019 at 07:41:24PM -0300, Eduardo Habkost wrote:
> > On Wed, Oct 16, 2019 at 08:11:57AM +0200, Thomas Huth wrote:
> > > On 16/10/2019 05.00, Eduardo Habkost wrote:
> > > > On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
> > > >> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
> > > >>> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
> > > > [...]
> > > >>>> The configure check also spits out deprecation warnings for
> > > >>>> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
> > > >>>> to get those updated.
> > > >>>
> > > >>> CCing the test/vm maintainers.
> > > >>>
> > > >>> Fam, Alex, are you able to fix this and create new BSD VM images
> > > >>> with Python 3 available?  I thought the VM image configurations
> > > >>> were stored in the source tree, but they are downloaded from
> > > >>> download.patchew.org.
> > > >>
> > > >> Fam, Alex, can you help us on this?  Python 2 won't be supported
> > > >> anymore, so we need the VM images to be updated.
> > > > 
> > > > Anyone?
> > > > 
> > > > I'm about to submit patches to remove Python 2 support, and this
> > > > will break tests/vm/netbsd.
> > > > 
> > > > I'm powerless to fix this issue, because the netbsd image is
> > > > hosted at download.patchew.org.
> > > 
> > > Gerd had a patch to convert the netbsd VM script to ad hoc image
> > > creation, too:
> > > 
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04459.html
> > > 
> > > But there was a regression with the serial port between QEMU v3.0 and
> > > v4.x, so it was not included:
> > > 
> > > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
> > 
> > The URL above has this error:
> > 
> >   con recv:  x: Exitqqqqqqqqqqqqqqqqqqqqqqqqqj
> >   con recv: To be able to use the network, we need answers to the
> >   following:Network media type
> >   con send: <enter>
> >   con recv: : qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk Perform autoconfiguration?
> >      >a: Yes b: Noqqqqqqqqqqqqqqqqq
> >   console: *** read timeout ***
> >   console: waiting for: 'a: Yes'
> >   console: line buffer:
> >   
> >   con recv: qqqqqqqqqqqqqqj
> > 
> > I believe that problem was solved in v4, because v4 was reading
> > the serial output 1 byte at a time.
> > 
> > The issue that caused the netbsd patch to be dropped was:
> > https://lore.kernel.org/qemu-devel/CAFEAcA8k9QJA9iE-kwiaPhr0fY_2zG7JRX5uV4AaSSjXCSs4+A@mail.gmail.com/
> > 
> > Possibly this is the same issue we saw at:
> > https://lore.kernel.org/qemu-devel/20190607034214.GB22416@habkost.net/
> > 
> > The test script must either close the console socket, or keep
> > reading from it.  Otherwise, the QEMU VCPU threads might get
> > stuck waiting for the chardev to be writeable.
> 
> It doesn't seem to be the same issue.  Even if the console socket is closed,
> I'm seeing results similar to the ones reported by Peter (the "pkgin -y
> install" step is unreasonably slow).
> 
> Running with V=1, I see packages being downloaded at reasonable speeds, but
> there's a huge interval (of various minutes) between each package download.

I've found the cause for the slowness I'm seeing: for each file
being downloaded, the guest spents at least 75 seconds trying to
connect to the IPv6 address of ftp.NetBSD.org, before trying
IPv4.  I don't know if this is a NetBSD bug, or a slirp bug.

Output of `strace -e trace=network` below:

1571352260.348566 recvfrom(30, "~[\201\200\0\1\0\1\0\0\0\0\3ftp\6NetBSD\3org\0\0\1\0\1"..., 1500, 0, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("10.5.30.160")}, [128->16]) = 48 <0.000016>
1571352260.349030 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 31 <0.000041>
1571352260.349142 setsockopt(31, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000009>
1571352260.349179 setsockopt(31, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000007>
1571352260.349207 setsockopt(31, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000008>
1571352260.349239 connect(31, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000
021>
1571352266.350112 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 31 <0.000131>
1571352266.350603 setsockopt(31, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000183>
1571352266.350946 setsockopt(31, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000047>
1571352266.351109 setsockopt(31, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000043>
1571352266.351260 connect(31, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000070>
1571352278.357962 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000166>
1571352278.358524 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000046>
1571352278.358757 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000046>
1571352278.358950 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000039>
1571352278.359103 connect(29, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000065>
1571352302.373056 socket(AF_INET6, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000323>
1571352302.373909 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000162>
1571352302.374331 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000159>
1571352302.374626 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000050>
1571352302.374857 connect(29, {sa_family=AF_INET6, sin6_port=htons(80), sin6_flowinfo=htonl(67108864), inet_pton(AF_INET6, "2001:470:a085:999::21", &sin6_addr), sin6_scope_id=377348480}, 28) = -1 ENETUNREACH (Network is unreachable) <0.000070>
1571352335.394568 socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) = 29 <0.000091>
1571352335.394796 setsockopt(29, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0 <0.000011>
1571352335.394848 setsockopt(29, SOL_SOCKET, SO_OOBINLINE, [1], 4) = 0 <0.000009>
1571352335.394883 setsockopt(29, SOL_TCP, TCP_NODELAY, [1], 4) = 0 <0.000008>
1571352335.394913 connect(29, {sa_family=AF_INET, sin_port=htons(80), sin_addr=inet_addr("199.233.217.201")}, 16) = -1 EINPROGRESS (Operation now in progress) <0.000055>
1571352335.587395 sendto(29, "", 0, 0, NULL, 0) = 0 <0.000220>
1571352335.589650 sendto(29, "GET /pub/pkgsrc/packages/NetBSD/"..., 81, 0, NULL, 0) = 81 <0.000088>

-- 
Eduardo


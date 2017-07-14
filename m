Received: from eggs.gnu.org ([2001:4830:134:3::10]:46159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVw5W-0004sj-Az
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVw5V-0000Wz-CG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:36:38 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVw5V-0000WZ-5Y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:36:37 -0400
Received: by mail-wm0-x22d.google.com with SMTP id 62so14018614wmw.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 01:36:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170712161830.3621-1-berrange@redhat.com>
References: <20170712161830.3621-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 09:36:15 +0100
Message-ID: <CAFEAcA979j6Tw8=JAU0U1xTbxXmqj7pvo7sLvHfAv4k7OkCJYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] Merge sockets 2017/07/11
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

On 12 July 2017 at 17:18, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1ee:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170710a' into staging (2017-07-10 18:13:03 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-2
>
> for you to fetch changes up to 4b1ac1b3abf0d07cd4d9f9011f12d62bff27154c:
>
>   tests: add functional test validating ipv4/ipv6 address flag handling (2017-07-12 16:49:00 +0100)
>
> ----------------------------------------------------------------
> Merge sockets 2017/07/11 v2
>
> ----------------------------------------------------------------
> Daniel P. Berrange (5):
>   sockets: ensure we can bind to both ipv4 & ipv6 separately
>   sockets: don't block IPv4 clients when listening on "::"
>   sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
>   io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
>   tests: add functional test validating ipv4/ipv6 address flag handling

This failed 'make check' on s390x host:

TEST: tests/test-sockets-proto... (pid=28872)
  /sockets/migrate/wildcard/all:                                       OK
[...]
  /sockets/chardev/::/ipv4onipv6on:                                    OK
  /sockets/chardev/::/ipv4offipv6off:                                  OK
  /sockets/net/wildcard/all:                                           **
ERROR:/home/linux1/qemu/tests/test-sockets-proto.c:849:test_listen:
assertion failed: (data->ipv4 == 0)
FAIL
GTester: last random seed: R02S575d305465be93e6120318b4f8434263
(pid=29314)
FAIL: tests/test-sockets-proto

thanks
-- PMM

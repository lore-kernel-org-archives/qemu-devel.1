Received: from eggs.gnu.org ([2001:4830:134:3::10]:57326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPBp-00028a-6g
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPBm-0007is-2q
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:28:57 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVPBl-0007iW-UE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:28:53 -0400
Received: by mail-qt0-x22f.google.com with SMTP id b40so23641770qtb.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:28:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170712161830.3621-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c3e1d400-40bd-1691-39db-be1dbd36b2ad@amsat.org>
Date: Wed, 12 Jul 2017 18:28:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170712161830.3621-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 0/5] Merge sockets 2017/07/11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Hi Daniel,

On 07/12/2017 01:18 PM, Daniel P. Berrange wrote:
> The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1ee:
> 
>    Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170710a' into staging (2017-07-10 18:13:03 +0100)
> 
> are available in the git repository at:
> 
>    git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-2
> 
> for you to fetch changes up to 4b1ac1b3abf0d07cd4d9f9011f12d62bff27154c:
> 
>    tests: add functional test validating ipv4/ipv6 address flag handling (2017-07-12 16:49:00 +0100)
> 
> ----------------------------------------------------------------
> Merge sockets 2017/07/11 v2

$ git diff pull-sockets-2017-07-11-1..pull-sockets-2017-07-11-2

As I understand, diff since v1 is:

- restricted sockets-proto tests to x86_64
- run tests using INADDR_LOOPBACK instead of INADDR_ANY

signed PR, else:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ----------------------------------------------------------------
> Daniel P. Berrange (5):
>    sockets: ensure we can bind to both ipv4 & ipv6 separately
>    sockets: don't block IPv4 clients when listening on "::"
>    sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
>    io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
>    tests: add functional test validating ipv4/ipv6 address flag handling
> 
>   io/dns-resolver.c          |   6 +-
>   tests/.gitignore           |   1 +
>   tests/Makefile.include     |   3 +
>   tests/test-sockets-proto.c | 924 +++++++++++++++++++++++++++++++++++++++++++++
>   util/qemu-sockets.c        |  71 +++-
>   5 files changed, 984 insertions(+), 21 deletions(-)
>   create mode 100644 tests/test-sockets-proto.c
> 

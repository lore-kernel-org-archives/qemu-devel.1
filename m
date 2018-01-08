Received: from eggs.gnu.org ([2001:4830:134:3::10]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEZ-00080N-81
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEW-0008HE-5X
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:15 -0500
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:34887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbEW-0008Gg-1h
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:12 -0500
Received: by mail-qk0-x22b.google.com with SMTP id w184so6916842qka.2
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:11 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:28:52 -0300
Message-Id: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/12] add HOST_SUPPORTS_UNALIGNED_ACCESS,
 reduce slirp warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

A recent mail from Michael remembered me this pre-2.10 series eh :)

I tagged the last patch 'RFC' because I find it ugly and hope there is a nicer
way to write it.

Regards,

Phil.

Philippe Mathieu-Daudé (12):
  slirp: remove QEMU_PACKED from structures with don't require it
  slirp: struct icmp/ethhdr ARE packed
  slirp: avoid IN6_IS_ADDR_UNSPECIFIED(), rather use in6_zero()
  slirp: add in6_multicast() and use it instead of IN6_IS_ADDR_MULTICAST()
  slirp: poison IN6_*_ADDR_*() macros to avoid them
  slirp: remove unused header
  slirp: remove unnecessary
  slirp: removed unused code
  slirp: add in6_dhcp_multicast()
  configure: disable unaligned access warning on x86 arch
  configure: add HOST_SUPPORTS_UNALIGNED_ACCESS
  slirp: use HOST_SUPPORTS_UNALIGNED_ACCESS

 configure         | 18 ++++++++++++
 slirp/dhcpv6.h    |  3 ++
 slirp/ip.h        | 23 ++++------------
 slirp/ip6.h       | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 slirp/ip6_icmp.h  |  6 ++--
 slirp/ip_icmp.h   |  2 +-
 slirp/libslirp.h  |  1 -
 slirp/slirp.h     |  5 ++--
 slirp/ip6_icmp.c  | 16 +++++------
 slirp/ndp_table.c |  6 ++--
 slirp/udp6.c      |  2 +-
 11 files changed, 126 insertions(+), 38 deletions(-)

-- 
2.15.1

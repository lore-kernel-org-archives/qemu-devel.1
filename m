Received: from eggs.gnu.org ([2001:4830:134:3::10]:55634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuJe-0005Qo-FN
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuJa-000072-2y
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:44:26 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dfuJZ-00006o-TE
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:44:22 -0400
Received: by mail-io0-x242.google.com with SMTP id c74so2284391iod.4
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 13:44:21 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
Date: Thu, 10 Aug 2017 16:44:19 -0400
Subject: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Host: Mac OS 10.12.5
Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
Command used: ./configure --target-list=3Dppc-softmmu,i386-softmmu && =
make -j 4

While compiling I saw these error messages:

slirp/ip6_icmp.c:79:32: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
                               ^~~~~~~~~~
/usr/include/netinet6/in6.h:299:36: note: expanded from macro =
'IN6_IS_ADDR_MULTICAST'
#define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
                                          ^
slirp/ip6_icmp.c:80:38: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                     ^~~~~~~~~~
/usr/include/netinet6/in6.h:238:42: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) =3D=3D =
0) && \
                                                ^
slirp/ip6_icmp.c:80:38: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                     ^~~~~~~~~~
/usr/include/netinet6/in6.h:239:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[4]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:80:38: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                     ^~~~~~~~~~
/usr/include/netinet6/in6.h:240:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[8]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:80:38: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                     ^~~~~~~~~~
/usr/include/netinet6/in6.h:241:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[12]) =3D=3D =
0))
                                               ^
slirp/ip6_icmp.c:275:34: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                 ^~~~~~~~~~
/usr/include/netinet6/in6.h:238:42: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) =3D=3D =
0) && \
                                                ^
slirp/ip6_icmp.c:275:34: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                 ^~~~~~~~~~
/usr/include/netinet6/in6.h:239:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[4]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:275:34: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                 ^~~~~~~~~~
/usr/include/netinet6/in6.h:240:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[8]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:275:34: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    if (IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)) {
                                 ^~~~~~~~~~
/usr/include/netinet6/in6.h:241:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[12]) =3D=3D =
0))
                                               ^
slirp/ip6_icmp.c:294:50: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    ricmp->icmp6_nna.S =3D !IN6_IS_ADDR_MULTICAST(&rip->ip_dst);
                                                 ^~~~~~~~~~~
/usr/include/netinet6/in6.h:299:36: note: expanded from macro =
'IN6_IS_ADDR_MULTICAST'
#define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
                                          ^
slirp/ip6_icmp.c:351:44: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nns.target)
                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/netinet6/in6.h:299:36: note: expanded from macro =
'IN6_IS_ADDR_MULTICAST'
#define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
                                          ^
slirp/ip6_icmp.c:353:47: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
                                              ^~~~~~~~~~
/usr/include/netinet6/in6.h:238:42: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        ((*(const __uint32_t *)(const void *)(&(a)->s6_addr[0]) =3D=3D =
0) && \
                                                ^
slirp/ip6_icmp.c:353:47: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
                                              ^~~~~~~~~~
/usr/include/netinet6/in6.h:239:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[4]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:353:47: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
                                              ^~~~~~~~~~
/usr/include/netinet6/in6.h:240:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[8]) =3D=3D 0) =
&& \
                                               ^
slirp/ip6_icmp.c:353:47: warning: taking address of packed member =
'ip_src' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && (!IN6_IS_ADDR_UNSPECIFIED(&ip->ip_src)
                                              ^~~~~~~~~~
/usr/include/netinet6/in6.h:241:41: note: expanded from macro =
'IN6_IS_ADDR_UNSPECIFIED'
        (*(const __uint32_t *)(const void *)(&(a)->s6_addr[12]) =3D=3D =
0))
                                               ^
slirp/ip6_icmp.c:354:53: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                    || in6_solicitednode_multicast(&ip->ip_dst))) {
                                                    ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:91:20=
: note:=20
      expanded from macro 'in6_solicitednode_multicast'
    (in6_equal_net(a, &(struct in6_addr)SOLICITED_NODE_PREFIX, 104))
                   ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
     ~~~~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:76:21=
: note:=20
      expanded from macro 'in6_equal_router'
    ((in6_equal_net(a, &slirp->vprefix_addr6, slirp->vprefix_len)\
                    ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
     ~~~~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:77:25=
: note:=20
      expanded from macro 'in6_equal_router'
      && in6_equal_mach(a, &slirp->vhost_addr6, slirp->vprefix_len))\
                        ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
     ~~~~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:78:21=
: note:=20
      expanded from macro 'in6_equal_router'
  || (in6_equal_net(a, &(struct in6_addr)LINKLOCAL_ADDR, 64)\
                    ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
     ~~~~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:79:25=
: note:=20
      expanded from macro 'in6_equal_router'
      && in6_equal_mach(a, &slirp->vhost_addr6, 64)))
                        ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                            ~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:82:21=
: note:=20
      expanded from macro 'in6_equal_dns'
    ((in6_equal_net(a, &slirp->vprefix_addr6, slirp->vprefix_len)\
                    ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                            ~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:83:25=
: note:=20
      expanded from macro 'in6_equal_dns'
      && in6_equal_mach(a, &slirp->vnameserver_addr6, =
slirp->vprefix_len))\
                        ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                            ~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:84:21=
: note:=20
      expanded from macro 'in6_equal_dns'
  || (in6_equal_net(a, &(struct in6_addr)LINKLOCAL_ADDR, 64)\
                    ^
slirp/ip6_icmp.c:355:33: warning: taking address of packed member =
'target' of class or
      structure 'ndp_ns' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
            if (in6_equal_host(&icmp->icmp6_nns.target)) {
                ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                            ~~~~~~~~~~~~~~^~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:85:25=
: note:=20
      expanded from macro 'in6_equal_dns'
      && in6_equal_mach(a, &slirp->vnameserver_addr6, 64)))
                        ^
slirp/ip6_icmp.c:368:44: warning: taking address of packed member =
'target' of class or
      structure 'ndp_na' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && !IN6_IS_ADDR_MULTICAST(&icmp->icmp6_nna.target)
                    ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/netinet6/in6.h:299:36: note: expanded from macro =
'IN6_IS_ADDR_MULTICAST'
#define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
                                          ^
slirp/ip6_icmp.c:369:45: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                && (!IN6_IS_ADDR_MULTICAST(&ip->ip_dst)
                                            ^~~~~~~~~~
/usr/include/netinet6/in6.h:299:36: note: expanded from macro =
'IN6_IS_ADDR_MULTICAST'
#define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] =3D=3D 0xff)
                                          ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                      ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:76:21=
: note:=20
      expanded from macro 'in6_equal_router'
    ((in6_equal_net(a, &slirp->vprefix_addr6, slirp->vprefix_len)\
                    ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                      ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:77:25=
: note:=20
      expanded from macro 'in6_equal_router'
      && in6_equal_mach(a, &slirp->vhost_addr6, slirp->vprefix_len))\
                        ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                      ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:78:21=
: note:=20
      expanded from macro 'in6_equal_router'
  || (in6_equal_net(a, &(struct in6_addr)LINKLOCAL_ADDR, 64)\
                    ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:23=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                      ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:79:25=
: note:=20
      expanded from macro 'in6_equal_router'
      && in6_equal_mach(a, &slirp->vhost_addr6, 64)))
                        ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                                          ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:82:21=
: note:=20
      expanded from macro 'in6_equal_dns'
    ((in6_equal_net(a, &slirp->vprefix_addr6, slirp->vprefix_len)\
                    ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                                          ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:83:25=
: note:=20
      expanded from macro 'in6_equal_dns'
      && in6_equal_mach(a, &slirp->vnameserver_addr6, =
slirp->vprefix_len))\
                        ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                                          ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:84:21=
: note:=20
      expanded from macro 'in6_equal_dns'
  || (in6_equal_net(a, &(struct in6_addr)LINKLOCAL_ADDR, 64)\
                    ^
slirp/ip6_icmp.c:414:29: warning: taking address of packed member =
'ip_dst' of class or
      structure 'ip6' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
        if (in6_equal_host(&ip->ip_dst)) {
                            ^~~~~~~~~~
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:88:43=
: note:=20
      expanded from macro 'in6_equal_host'
    (in6_equal_router(a) || in6_equal_dns(a))
                                          ^
=
/Users/john/Documents/Development/Projects/Qemu/qemu-git/slirp/ip6.h:85:25=
: note:=20
      expanded from macro 'in6_equal_dns'
      && in6_equal_mach(a, &slirp->vnameserver_addr6, 64)))
                        ^

slirp/ip_input.c:159:43: warning: taking address of packed member =
'ip_link' of class or
      structure 'ipq' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                for (l =3D slirp->ipq.ip_link.next; l !=3D =
&slirp->ipq.ip_link;
                                                        =
^~~~~~~~~~~~~~~~~~
slirp/ip_input.c:441:18: warning: taking address of packed member =
'ip_link' of class or
      structure 'ipq' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    while (l !=3D &slirp->ipq.ip_link) {
                 ^~~~~~~~~~~~~~~~~~
2 warnings generated.
34 warnings generated.

slirp/slirp.c:403:19: warning: taking address of packed member 'ip_link' =
of class or
      structure 'ipq' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
                (&slirp->ipq.ip_link !=3D slirp->ipq.ip_link.next));=

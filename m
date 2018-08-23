Received: from eggs.gnu.org ([2001:4830:134:3::10]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsnor-0001ik-RM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsnkm-0004m6-SR
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:26:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsnkm-0004ls-EQ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:26:16 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so8659437ois.1
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 04:26:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 12:25:55 +0100
Message-ID: <CAFEAcA8a6c1DK9D=fr7sRiMyBhr9OWvsAOUvJetG+p1eXBrWgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/74] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 August 2018 at 18:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d88:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-21 11:36:15 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6fd9b3b03635935a3a21cecde777c238745b88da:
>
>   test-char: add socket reconnect test (2018-08-21 17:13:12 +0200)
>

Hi. This fails to build for 32-bit Arm:

In file included from /home/peter.maydell/qemu/include/qemu/osdep.h:51:0,
                 from /home/peter.maydell/qemu/tests/test-rcu-list.c:23:
/home/peter.maydell/qemu/tests/test-rcu-list.c: In function 'reclaim_list_el':
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting:
 sizeof(*&n_reclaims) > ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MS
G'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:133:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:107:5: note: in
expansion of macro 'atomic_set'
     atomic_set(&n_reclaims, n_reclaims + 1);
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c: In function 'rcu_q_updater':
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting:
 sizeof(*&n_nodes_removed) > ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MS
G'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:133:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:235:5: note: in
expansion of macro 'atomic_set'
     atomic_set(&n_nodes_removed, n_nodes_removed + n_removed_local);
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c: In function 'rcu_qtest':
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_nodes_removed) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:292:12: note: in
expansion of macro 'atomic_read'
     while (atomic_read(&n_nodes_removed) > atomic_read(&n_reclaims)) {
            ^
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_reclaims) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:292:44: note: in
expansion of macro 'atomic_read'
     while (atomic_read(&n_nodes_removed) > atomic_read(&n_reclaims)) {
                                            ^
In file included from /usr/include/glib-2.0/glib.h:82:0,
                 from /home/peter.maydell/qemu/include/glib-compat.h:32,
                 from /home/peter.maydell/qemu/include/qemu/osdep.h:122,
                 from /home/peter.maydell/qemu/tests/test-rcu-list.c:23:
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_nodes_removed) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/usr/include/glib-2.0/glib/gtestutils.h:48:61: note: in definition of
macro 'g_assert_cmpint'
                                              gint64 __n1 = (n1), __n2 = (n2); \
                                                             ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:297:25: note: in
expansion of macro 'atomic_read'
         g_assert_cmpint(atomic_read(&n_nodes_removed), ==,
                         ^
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_reclaims) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/usr/include/glib-2.0/glib/gtestutils.h:48:74: note: in definition of
macro 'g_assert_cmpint'
                                              gint64 __n1 = (n1), __n2 = (n2); \
                                                                          ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:298:25: note: in
expansion of macro 'atomic_read'
                         atomic_read(&n_reclaims));
                         ^
In file included from /home/peter.maydell/qemu/include/qemu/osdep.h:51:0,
                 from /home/peter.maydell/qemu/tests/test-rcu-list.c:23:
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_nodes_removed) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:303:16: note: in
expansion of macro 'atomic_read'
                atomic_read(&n_nodes_removed), atomic_read(&n_reclaims));
                ^
/home/peter.maydell/qemu/include/qemu/compiler.h:92:36: error: static
assertion failed: "not expecting: sizeof(*&n_reclaims) >
ATOMIC_REG_SIZE"
 #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                    ^
/home/peter.maydell/qemu/include/qemu/compiler.h:100:30: note: in
expansion of macro 'QEMU_BUILD_BUG_MSG'
 #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                              ^
/home/peter.maydell/qemu/include/qemu/atomic.h:125:5: note: in
expansion of macro 'QEMU_BUILD_BUG_ON'
     QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
     ^
/home/peter.maydell/qemu/tests/test-rcu-list.c:303:47: note: in
expansion of macro 'atomic_read'
                atomic_read(&n_nodes_removed), atomic_read(&n_reclaims));
                                               ^
/home/peter.maydell/qemu/rules.mak:69: recipe for target
'tests/test-rcu-list.o' failed

thanks
-- PMM

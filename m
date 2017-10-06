Received: from eggs.gnu.org ([2001:4830:134:3::10]:43168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRr-0001ku-DG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRp-0007V4-33
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:50:02 -0300
Message-Id: <20171006235023.11952-68-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 67/88] util/coroutine: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 util/coroutine-sigaltstack.c | 2 +-
 util/coroutine-ucontext.c    | 2 +-
 util/coroutine-win32.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/coroutine-sigaltstack.c b/util/coroutine-sigaltstack.c
index f6fc49a0e5..4fe4bbf1b5 100644
--- a/util/coroutine-sigaltstack.c
+++ b/util/coroutine-sigaltstack.c
@@ -163,7 +163,7 @@ Coroutine *qemu_coroutine_new(void)
      * sigaltstack way of manipulating stacks.
      */
 
-    co = g_malloc0(sizeof(*co));
+    co = g_new0(CoroutineSigAltStack, 1);
     co->stack_size = COROUTINE_STACK_SIZE;
     co->stack = qemu_alloc_stack(&co->stack_size);
     co->base.entry_arg = &old_env; /* stash away our jmp_buf */
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 6621f3f692..c14dca19b4 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -100,7 +100,7 @@ Coroutine *qemu_coroutine_new(void)
         abort();
     }
 
-    co = g_malloc0(sizeof(*co));
+    co = g_new0(CoroutineUContext, 1);
     co->stack_size = COROUTINE_STACK_SIZE;
     co->stack = qemu_alloc_stack(&co->stack_size);
     co->base.entry_arg = &old_env; /* stash away our jmp_buf */
diff --git a/util/coroutine-win32.c b/util/coroutine-win32.c
index de6bd4fd3e..6762ff83c2 100644
--- a/util/coroutine-win32.c
+++ b/util/coroutine-win32.c
@@ -74,7 +74,7 @@ Coroutine *qemu_coroutine_new(void)
     const size_t stack_size = COROUTINE_STACK_SIZE;
     CoroutineWin32 *co;
 
-    co = g_malloc0(sizeof(*co));
+    co = g_new0(CoroutineWin32, 1);
     co->fiber = CreateFiber(stack_size, coroutine_trampoline, &co->base);
     return &co->base;
 }
-- 
2.14.2

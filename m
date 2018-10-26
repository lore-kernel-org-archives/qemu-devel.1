Received: from eggs.gnu.org ([2001:4830:134:3::10]:50666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4Jm-0004ut-QI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG45z-0004cO-Iq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:32:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:06 +0200
Message-Id: <20181026153125.24738-2-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/20] configs/alpha: Remove unused
 CONFIG_PARALLEL_ISA switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We don't use CONFIG_PARALLEL_ISA in any of our Makefiles, so this
is just a dead config option which can be removed.

Fixes: a4cb773928e047b137c6998209cf2eec857fac6b
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1540376314-5727-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 default-configs/alpha-softmmu.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/default-configs/alpha-softmmu.mak b/default-configs/alpha-softmmu.mak
index eb58b40254..4d654eaa0b 100644
--- a/default-configs/alpha-softmmu.mak
+++ b/default-configs/alpha-softmmu.mak
@@ -8,7 +8,6 @@ CONFIG_I82374=y
 CONFIG_I8254=y
 CONFIG_I8257=y
 CONFIG_PARALLEL=y
-CONFIG_PARALLEL_ISA=y
 CONFIG_FDC=y
 CONFIG_PCKBD=y
 CONFIG_VGA_CIRRUS=y
-- 
2.17.2

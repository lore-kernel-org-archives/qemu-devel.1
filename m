Received: from eggs.gnu.org ([209.51.188.92]:50491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYv-0002NT-EF
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYs-0002wC-UJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:13 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:10 +0100
Message-Id: <20190214104717.3543-8-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/14] configure: Make
 -Waddress-of-packed-member warnings be errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

We have now managed to eradicate all the places in the codebase
that triggered clang's -Waddress-of-packed-member warning. Remove
the compiler flag that exempted it from our usual -Werror policy.
This will prevent any new problematic code being added in future.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190208132112.31493-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index 649ef1b158d1..c0f278141823 100755
--- a/configure
+++ b/configure
@@ -1882,7 +1882,6 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
 gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
 gcc_flags="-Wno-string-plus-int $gcc_flags"
-gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
-- 
2.20.1

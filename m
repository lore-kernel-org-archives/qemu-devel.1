Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEI-0007OI-Ig
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEF-0000sX-DL
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:34 -0400
Received: from mail-yb0-f177.google.com ([209.85.213.177]:36767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEF-0000rs-7f
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:31 -0400
Received: by mail-yb0-f177.google.com with SMTP id d13-v6so1032333ybc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 13:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180320151355.25854-1-pbonzini@redhat.com>
In-Reply-To: <20180320151355.25854-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 20 Mar 2018 20:51:18 +0000
Message-ID: <CAAdtpL6qmOj8nBkVTT0ptoUGXvK-K5O6qNttKGWHLFWjXSC2JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sdhci: fix incorrect use of Error *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, peter.maydell@linaro.org

Le 20 mars 2018 4:14 PM, "Paolo Bonzini" <pbonzini@redhat.com> a =C3=A9crit=
 :

Detected by Coverity (CID 1386072, 1386073, 1386076, 1386077).  local_err
was unused, and this made the static analyzer unhappy


Oops, thanks Paolo!


Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1b828b104d..63c44a4ee8 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1474,7 +1474,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error
**errp)
     Error *local_err =3D NULL;

     sdhci_initfn(s);
-    sdhci_common_realize(s, errp);
+    sdhci_common_realize(s, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1556,7 +1556,7 @@ static void sdhci_sysbus_realize(DeviceState *dev,
Error ** errp)
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     Error *local_err =3D NULL;

-    sdhci_common_realize(s, errp);
+    sdhci_common_realize(s, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
--
2.16.2

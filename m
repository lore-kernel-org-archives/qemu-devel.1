Received: from eggs.gnu.org ([2001:4830:134:3::10]:38327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofe-0008S0-8n
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofc-0004Lk-UC
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofc-0004LS-Ns
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q18so5665379wrx.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.26
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:01 +0000
Message-Id: <20181214144214.1260-10-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/22] hw/smbios/smbios.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-4-peter.maydell@linaro.org
---
 hw/smbios/smbios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 920939454e7..04811279a08 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -982,7 +982,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         header = (struct smbios_structure_header *)(smbios_tables +
                                                     smbios_tables_len);
 
-        if (load_image(val, (uint8_t *)header) != size) {
+        if (load_image_size(val, (uint8_t *)header, size) != size) {
             error_setg(errp, "Failed to load SMBIOS file %s", val);
             return;
         }
-- 
2.19.2

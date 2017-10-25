Received: from eggs.gnu.org ([2001:4830:134:3::10]:50596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7Mye-0004gW-Fi
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7Mya-00030c-GF
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7Mya-0002zX-6t
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 10:48:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PEkkPU064714
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:08 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtvgm8qa1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 10:48:07 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 08:48:07 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 10:47:55 -0400
In-Reply-To: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508942875-21557-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508942875-21557-6-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 5/5] tpm: print buffers received from TPM
 when debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 8c5cac5..7402528 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -422,6 +422,8 @@ static void tpm_tis_receive_bh(void *opaque)
     s->loc[locty].r_offset =3D 0;
     s->loc[locty].w_offset =3D 0;
=20
+    tpm_tis_show_buffer(&s->loc[locty].r_buffer, "tpm_tis: From TPM");
+
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s, locty);
     }
--=20
2.5.5

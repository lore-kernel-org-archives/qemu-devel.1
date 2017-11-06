Received: from eggs.gnu.org ([2001:4830:134:3::10]:53546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbQp-0002RY-2f
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbQZ-0002B1-DH
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:02:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eBbQY-000273-NC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:02:35 -0500
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 6 Nov 2017 14:58:48 +0800
Message-ID: <1509951528-30976-3-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [v21 RESEND 2/2] virtio-crypto: Add conformance clauses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

From: Gonglei <arei.gonglei@huawei.com>

Add the conformance targets and clauses for
virtio-crypto device.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 conformance.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 7b7df32..266a22f 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -145,6 +145,21 @@ An SCSI host driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
+\subsection{Crypto Driver Conformance}\label{sec:Conformance / Driver Conformance / Crypto Driver Conformance}
+
+A Crypto driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Crypto Device / Device configuration layout}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Initialization}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / HASH Service operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / MAC Service operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+\item \ref{drivernormative:Device Types / Crypto Device / Device Operation / AEAD Service operation}
+\end{itemize}
+
 \section{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -265,6 +280,20 @@ An SCSI host device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
+\subsection{Crypto Device Conformance}\label{sec:Conformance / Device Conformance / Crypto Device Conformance}
+
+A Crypto device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Crypto Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: destroy session}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / HASH Service operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / MAC Service operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
+\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / AEAD Service operation}
+\end{itemize}
+
 \section{Legacy Interface: Transitional Device and
 Transitional Driver Conformance}\label{sec:Conformance / Legacy
 Interface: Transitional Device and 
-- 
1.8.3.1

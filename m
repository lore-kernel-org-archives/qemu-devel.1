Received: from eggs.gnu.org ([2001:4830:134:3::10]:57123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emPZg-0008ON-IV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emPZb-00037D-Dt
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:52:08 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Feb 2018 14:51:47 -0500
Message-Id: <1518724309-5025-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv2 0/2] target/ppc: convert to generic
 translation loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Changes from v1:
- Removed use of translator_loop_temp_check; call tcg_check_temp_count
  directly.
- Add R-b's.

Thanks,

		Emilio

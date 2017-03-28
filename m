Received: from eggs.gnu.org ([2001:4830:134:3::10]:51209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csx5J-0001VW-S6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csx5J-0007eE-3q
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:47:17 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1490608126-22187-4-git-send-email-eric.auger@redhat.com> (Eric
	Auger's message of "Mon, 27 Mar 2017 11:48:46 +0200")
References: <1490608126-22187-1-git-send-email-eric.auger@redhat.com>
	<1490608126-22187-4-git-send-email-eric.auger@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 21:47:03 +0200
Message-ID: <8737dxp4js.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v3 3/3] hw/intc/arm_gicv3_its: Allow
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org

Eric Auger <eric.auger@redhat.com> wrote:
> We change the restoration priority of both the GICv3 and ITS. The
> GICv3 must be restored before the ITS and the ITS needs to be restored
> before PCIe devices since it translates their MSI transactions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

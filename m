Received: from eggs.gnu.org ([209.51.188.92]:54142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFxoH-0005qL-RY
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFxoH-0004mJ-4A
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:21:53 -0400
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-2-git-send-email-atar4qemu@gmail.com>
	<e9e9724c-4a8f-e374-8ddf-4e9d4586fa40@reactos.org>
	<CACXAS8BFciYO3MsAgfX+OLy0wGf=hZYdbph4U_LQ6PiMOwtRAQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be91f478-3874-1bfb-2e31-01b0af8740a3@redhat.com>
Date: Mon, 15 Apr 2019 11:21:33 +0200
MIME-Version: 1.0
In-Reply-To: <CACXAS8BFciYO3MsAgfX+OLy0wGf=hZYdbph4U_LQ6PiMOwtRAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] lsi53c895a: hide 53c895a registers in
 53c810
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, "open list:PReP" <qemu-ppc@nongnu.org>, Fam Zheng <fam@euphon.net>

On 14/04/19 20:36, Artyom Tarasenko wrote:
>> You can probably remove this change, and replace it by
>> uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;
> Brilliant! Will do in V2, thainks.

Either that, or you could keep the current structure and make mmio_size
the last parameter of lsi_scsi_realize.

Paolo

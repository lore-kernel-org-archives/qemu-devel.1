Received: from eggs.gnu.org ([2001:4830:134:3::10]:35712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWSZw-0005PR-BV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWSZv-0001jT-BK
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:45:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cWSZv-0001iv-5R
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:45:55 -0500
References: <1485297322-10595-1-git-send-email-mst@redhat.com>
	<CAFEAcA_TW1JK8DOHt-=kisvemGXjtuadJ+eH7L8NJwsQcQz8sw@mail.gmail.com>
	<3958a41a-9b0e-4616-19dc-173824a87b31@gmail.com>
	<CAFEAcA_T-bkoHCVS0ZkaReC8HE66R3XQg6ZOMPks=8mWYSx_cQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <af7af918-62d2-2499-0dd0-3c7d18272ef2@redhat.com>
Date: Wed, 25 Jan 2017 20:45:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_T-bkoHCVS0ZkaReC8HE66R3XQg6ZOMPks=8mWYSx_cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/16] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 01/25/2017 08:08 PM, Peter Maydell wrote:
> On 25 January 2017 at 18:02, Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
>> Strange, I re-based in the same day I posted and compiled just fine...
>> However, I get the same error using today's master.
>>
>> I'll fix and re-post the series.
>
> mst has done a rebase of the pull request which I'll retry later.
>

Understood, anyway the problem is that commit
20daa90 (PCI/migration merge vmstate_pci_device and vmstate_pcie_device)
removed the VMSTATE_PCIE_DEVICE macro.

I'll re-post anyway and Michael can decide if he tweaks the macro name
or use the updated series.

Thanks,
Marcel


> thanks
> -- PMM
>

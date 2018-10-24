Received: from eggs.gnu.org ([2001:4830:134:3::10]:35572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFQMp-00011A-NR
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFQMo-0007df-WA
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:07:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFQMo-0007dP-R4
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:07:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id u74-v6so5288127oia.11
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 14:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024165328-mutt-send-email-mst@kernel.org>
References: <20181023234112.188140-1-mst@redhat.com>
	<CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
	<20181024165328-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 22:06:41 +0100
Message-ID: <CAFEAcA-xg5izn=YK86cXZJ2J-7sWfV0bqp1UspiQ1EFZsHPU5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2018 at 21:54, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Oct 24, 2018 at 07:21:17AM +0100, Peter Maydell wrote:
>> Hi. This pull request seems to include an accidental update
>> to the dtc submodule. It's in the "intel_iommu: move ce fetching out
>> when sync shadow" commit, and it's not mentioned in the commit
>> message, so I am assuming it is unintentional.

> Oh not again. At least now you have scripts that catch it,
> I should write a script for that too. Thanks and sorry.

The relevant part of my scripts is this bit:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/apply-pullreq?id=eeb001fcc1aabd8f077cd2846724120a3aa8f962#n107

Specifically,

if git diff master..staging | grep -q 'Subproject commit'; then
    # there's a submodule update in this set of commits
fi

thanks
-- PMM

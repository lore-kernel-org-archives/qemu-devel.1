Received: from eggs.gnu.org ([2001:4830:134:3::10]:47781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePqLx-0007W0-6a
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePqLw-00066K-Dw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:48:41 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:34093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePqLw-00065q-8T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:48:40 -0500
Received: by mail-ot0-x231.google.com with SMTP id o23so7828028otd.1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 05:48:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215110323.16400-1-cohuck@redhat.com>
References: <20171215110323.16400-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 13:48:18 +0000
Message-ID: <CAFEAcA_2yP1swG0pWLYt+tsObAdTk2G7zitGoMLPAdcy3_kBQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/46] First batch of s390x patches for
 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 15 December 2017 at 11:03, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171215-v2
>
> for you to fetch changes up to bb223055b9b327ec66e1f6d2fbaebaee0b8f3dbe:
>
>   s390-ccw-virtio: allow for systems larger that 7.999TB (2017-12-15 11:54:52 +0100)
>
> ----------------------------------------------------------------
> s390x changes for 2.12:
> - Lots of tcg improvements: ccw hotplug is now working and we can run
>   a Linux kernel built for z12 under tcg
> - zPCI improvements to get virtio-pci working
> - get rid of the cssid restrictions for virtual and non-virtual channel
>   devices
> - we now support 8TB+ systems
> - 2.12 compat machine
> - fixes and cleanups

Applied, thanks.

-- PMM

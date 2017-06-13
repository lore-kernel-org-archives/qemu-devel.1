Received: from eggs.gnu.org ([2001:4830:134:3::10]:57188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKmJ4-0007xv-9p
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKmJ3-0002Ju-BF
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:56:30 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKmJ3-0002JH-5N
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:56:29 -0400
Received: by mail-wr0-x231.google.com with SMTP id q97so144815167wrb.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 06:56:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 14:56:07 +0100
Message-ID: <CAFEAcA_W8KMDTLdrwk4eaLXf=_r4b7ZG-9VrFVK86WFe8QOY6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, Andrew Jones <drjones@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Wei Huang <wei@redhat.com>

On 9 June 2017 at 16:52, Eric Auger <eric.auger@redhat.com> wrote:
> This series allows ITS save/restore and migration use cases.
>
> ITS tables are flushed into guest RAM on VM stop while registers
> are save on pre_save() callback. Tables and registers are restored
> on ITS post_load().
>
> Redistributor pending tables also are flushed on VM stop, independently
> on ITS tables.
>
> That work was tested on Cavium ThunderX using virsh save/restore and
> virt-manager live migration.



Applied to target-arm.next, thanks.

-- PMM

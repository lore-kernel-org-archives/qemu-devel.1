Received: from eggs.gnu.org ([2001:4830:134:3::10]:47331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6t5-0003ma-EU
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6t4-0000Ur-Hl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:36:55 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb6t4-0000UO-9o
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:36:54 -0500
Received: by mail-wm0-x229.google.com with SMTP id v77so157452678wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 06:36:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 14:36:32 +0000
Message-ID: <CAFEAcA8FWjeV+Gyd5J5zwiM4yajwPjt7obTNiLJa7S7DXDemLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, "Kumar,
	Vijaya" <Vijaya.Kumar@cavium.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 26 January 2017 at 09:19, Eric Auger <eric.auger@redhat.com> wrote:
> This series allows ITS save/restore and migration use cases.
> It relies on not upstreamed kernel series ([1] & [2]) and
> QEMU not upstreamed series [3].
>
> ITS tables are flushed into guest RAM on VM stop while registers
> are save on pre_save() callback. Tables and registers are restored
> on ITS post_load().
>
> The code is based on Vijaya's "GICv3 live migration support"
> series [3], based on v2.8.0-rc4.
>
> The series also uses one patch from Peter Xu that aims at allowing
> the explicit ordering of save/restore handlers [4], now upstreamed.
>
> That work was tested on Cavium ThunderX using virsh save/restore and
> virt-manager live migration.
>
> Best Regards
>
> Eric

Looks overall OK to me (you've had some review comments from
others but I don't have anything else particularly to add).

thanks
-- PMM

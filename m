Received: from eggs.gnu.org ([2001:4830:134:3::10]:45528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fvIUh-0004qQ-C8
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fvIUe-0005fz-LC
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:39:57 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fvIUd-0005fN-6D
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:39:55 -0400
Received: by mail-oi0-x242.google.com with SMTP id r69-v6so14053688oie.3
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 01:39:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Aug 2018 09:39:33 +0100
Message-ID: <CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 30 August 2018 at 09:31, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
>> @Ard, @Leif, is there any possibility to remove all the DT nodes?
>> On real hardware, how does UEFI find the memory size and CPU number?
>
> Usually by asking some form of SCP/PMU.
> So until we have rock-solid multi-cpu-instance (making terms up here,
> there may be a proper name already?) support upstream, we need to take
> shortcuts.

I would expect that you'd want a "faked-on-the-QEMU end" SCP
communications endpoint to start with anyway. We have one of
those for vexpress, for instance.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fvhwS-0007UU-W2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fvhwS-0001Nc-6Z
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:50:20 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:33011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fvhwR-0001N8-P8
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:50:20 -0400
Received: by mail-yw1-xc44.google.com with SMTP id x67-v6so4941179ywg.0
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 04:50:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180831084238.4cn3s27vwauq5fjl@kamzik.brq.redhat.com>
References: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
	<20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
	<CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
	<CAHmQWvAx8+_0vAOd_Pq0NVr5n0spYj8o5vsj1xjn+a1M81w=Lg@mail.gmail.com>
	<20180831084238.4cn3s27vwauq5fjl@kamzik.brq.redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 31 Aug 2018 19:50:18 +0800
Message-ID: <CAHmQWvDAYH+L0Hh+F=O-8SnU_9iYytu4VnoYKot5cwwhiDWBAA@mail.gmail.com>
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
To: Andrew Jones <drjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 31 August 2018 at 16:42, Andrew Jones <drjones@redhat.com> wrote:
> On Fri, Aug 31, 2018 at 03:20:45PM +0800, Hongbo Zhang wrote:
>> If no DT in SBSA machine, then the code had much more difference with
>> virt, so there is possibility to make it a simple separate file;
>> If keep same DT as virt, then there are more overlap with virt codes,
>> so I am not sure how the patch should like finally, I still prefer
>> separate file to keep virt untouched, but not sure if others would
>> suggest to extract common codes to a third file, it is up to the
>> maintainer and reviewers.
>>
>
> It sounds like you don't need many DT nodes, so a new file for
> sbsa-ref, where you build whatever you want it to look like and
> add the few DT nodes to inform firmware of a few parameters,
> should be completely independent of mach-virt. I.e. I don't think
> it even makes sense to refactor those few nodes in order to
> share a tiny bit of DT node generation code.
>
Yes, this is what I intended to do as I mentioned.

> Thanks,
> drew

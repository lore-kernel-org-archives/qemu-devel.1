Received: from eggs.gnu.org ([209.51.188.92]:39816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCdj-0000QB-Cx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkCdg-0007C9-Kd
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:43:43 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:46043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkCde-000744-Nm
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:43:40 -0500
Received: by mail-ot1-x334.google.com with SMTP id 32so12014846ota.12
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 10:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20190109152430.32359-1-agraf@suse.de>
	<CAFEAcA9zugZiWirk9QjqmAO9QKhLdCAWuG1PX5z7Nxm4O69aTg@mail.gmail.com>
	<CAFEAcA8Xzi8GjzUtzxbFzxdCS4kn0Cps+_bF70ZS0KnH0W8SvQ@mail.gmail.com>
	<92dba7da-f3fc-b7dc-6896-cf8d58cc7f17@suse.de>
	<CAFEAcA_sxvfHG6ryA4xHMfbwhDaRrF_+6xaef_0RqqH-7JESzQ@mail.gmail.com>
	<0673d8c0-16f0-49e7-f002-06491353cc6c@suse.de>
	<CAFEAcA-duBwj2-DG=dQLo-448ca--+C6Fu54avwEFQ5D-bwy8A@mail.gmail.com>
In-Reply-To: <CAFEAcA-duBwj2-DG=dQLo-448ca--+C6Fu54avwEFQ5D-bwy8A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 18:43:20 +0000
Message-ID: <CAFEAcA8UxBW1JCp4ky-OxsAV1ip_rkRp1ZCb=bK5nwG5ickStQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow to switch from MON->HYP
 on AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-arm <qemu-arm@nongnu.org>, Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Stephen Warren <swarren@wwwdotorg.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 10 Jan 2019 at 10:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 10 Jan 2019 at 06:43, Alexander Graf <agraf@suse.de> wrote:
> >
> >
> >
> > On 10.01.19 00:08, Peter Maydell wrote:
> > > On Wed, 9 Jan 2019 at 17:14, Alexander Graf <agraf@suse.de> wrote:
> > >>
> > >> On 01/09/2019 05:59 PM, Peter Maydell wrote:
> > >>> On Wed, 9 Jan 2019 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >>>> On Wed, 9 Jan 2019 at 15:26, Alexander Graf <agraf@suse.de> wrote:
> > >>>>> In U-boot, we switch from S-SVC -> MON -> HYP when we want to enter
> > >>>>> HYP mode. This dance seems to work ok (hence it's there in the code
> > >>>>> base), but breaks with current QEMU.
> > >>> PS: it would be helpful if the commit message said how u-boot
> > >>> is trying to go from Mon to Hyp -- some ways to try to do
> > >>> this are OK, and some are not, so whether it's supposed to
> > >>> work or not depends on what u-boot is actually doing...
> > >>
> > >> I don't fully understand all of it to be honest :). But the code is here:
> > >>
> > >> http://git.denx.de/?p=u-boot.git;a=blob;f=arch/arm/cpu/armv7/nonsec_virt.S
> > >>
> > >> What I managed to understand so far is that it goes to MON using the smc
> > >> #0 call and then changes SPSR so that on return (movs pc) the mode will
> > >> be different.
> > >
> > > Thanks -- yes, that's an exception return so it's the
> > > expected way to go from Mon to Hyp.
> >
> > That was my understanding, yes. Do you still want me to change the
> > commit message to mention that or will you just do it when applying?
>
> I'll add a note when I apply it; thanks.

Now applied to target-arm.next with a rewritten commit message; thanks.

-- PMM

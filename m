Received: from eggs.gnu.org ([2001:4830:134:3::10]:59167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3ep-0004Sl-II
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn3el-0005F8-Bq
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:12:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn3el-0005Ex-7k
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:12:19 -0400
Date: Tue, 7 Aug 2018 16:12:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807151215.GM2556@work-vm>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
	<CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
	<87wot21bbt.fsf@trasno.org>
	<CAFEAcA_y1qKsC8kSDee+FEpqZstz9UHTeyP6ABuGfXf_aDMRHw@mail.gmail.com>
	<87o9ee1aka.fsf@trasno.org>
	<CAFEAcA_XJGWPioUDUR0+9v16Xj_osDwk7OYEK3vkqdg_SacMXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XJGWPioUDUR0+9v16Xj_osDwk7OYEK3vkqdg_SacMXA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 7 August 2018 at 16:05, Juan Quintela <quintela@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >> So it's better to use a needed-always subsection, which will give
> >> the desired behaviour:
> >>  * new QEMU -> new QEMU: state is always migrated
> >>  * old QEMU -> new QEMU: migration doesn't fail, and guest
> >>    will work assuming it didn't care about this corner of the
> >>    device's functionality (the device will end up with state
> >>    as it was at reset, or possibly special-cased via
> >>    pre_load/post_load hooks for the "section not present" case)
> >
> > we break by definiton new QEMU -M <old machine type> into old QEMU.
> 
> Is that supposed to work? I always thought that we never
> supported migration back to an older QEMU version like that.

Downstream we do a lot of hard work to keep that working for versioned 
machine types;  using subsections makes this a lot easier and if it's
done right in the first place then it works upstream as well.

> In any case, for all the devices here the machine types are
> not versioned.

Right.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

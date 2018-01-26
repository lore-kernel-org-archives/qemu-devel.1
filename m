Received: from eggs.gnu.org ([2001:4830:134:3::10]:44142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8NJ-0000MV-Nr
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef8NI-0006id-FH
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:05:17 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:42283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef8NH-0006iD-UI
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:05:16 -0500
Received: by mail-oi0-x236.google.com with SMTP id c8so864041oiy.9
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 10:05:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126175418.GH25150@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
	<20180122183301.GA31237@localhost.localdomain>
	<CAFEAcA8pGXMs3hMxSs-t7qGfeR__H-CQ1roRVe5NFMCP8R2vjw@mail.gmail.com>
	<20180126104247.GF25150@localhost.localdomain>
	<CAFEAcA_zU+tAMvcqNHQAaVOEaJrrGOEWPS8RpUi+eZQ3tf1yiQ@mail.gmail.com>
	<20180126175418.GH25150@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 18:04:54 +0000
Message-ID: <CAFEAcA9BLhWAEjL8eVNtwc+oo+_F_ga4AFXrS77h=CkuWSo_4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 26 January 2018 at 17:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Jan 26, 2018 at 11:02:24AM +0000, Peter Maydell wrote:
>> None of those are things we'd want to expose to the user, really
>> (except maybe 'cfgend'): they're all intended for the QEMU board
>> or SoC code that needs to configure and wire the CPU up. Ideally
>> there'd be a mechanism for screening them out of the -cpu option
>> list.
>>
>
> Yeah, it's becoming clearer to me that we need to address this
> better than with a simple "x-" prefix convention.
>
> If we remove the link and child properties, we have:
>
> midr (uint32)
> mp-affinity (uint64)
> psci-conduit (uint32)
> reset-hivecs (bool)
> node-id (int32)
> start-powered-off (bool)
> cfgend (bool)
>
> I wonder how many of them aren't useful with -cpu but might be
> useful with -device in the future.

It would require a lot of work to be able to create an Arm CPU
with -device -- there's no way at the moment to wire it up
to the interrupt controller...

thanks
-- PMM

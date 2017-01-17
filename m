Received: from eggs.gnu.org ([2001:4830:134:3::10]:48482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTReZ-0007zi-SE
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTReZ-00086D-0H
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:10:15 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:36425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTReY-000867-SA
	for Qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:10:14 -0500
Received: by mail-vk0-x229.google.com with SMTP id t8so89929034vke.3
	for <Qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:10:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170117104258.GD2053@work-vm>
References: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
	<CAFEAcA_CDpXqAAJNdSQpk4MKOorDXqUi_AwsevrHk=pnbrS0NQ@mail.gmail.com>
	<277E72EB-288A-498F-9208-99EBF09218A6@livius.net>
	<CAFEAcA_54fL9YHVJLqAZS8p3OftGd-yq7C7k4jSfVGeCzwMPmA@mail.gmail.com>
	<D1505166-849A-439D-8E78-579F708D53BB@livius.net>
	<CAFEAcA-AB98qtJcrLQ=T4PDvg=VM2tTqxALVpZYoYQcd9fySFg@mail.gmail.com>
	<20170117104258.GD2053@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 11:09:53 +0000
Message-ID: <CAFEAcA-S6BQnjKQzuKM2SX14qNzt=CV=otOXt_p2usgGS_EHNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Liviu Ionescu <ilg@livius.net>, QEMU Developer <Qemu-devel@nongnu.org>

On 17 January 2017 at 10:42, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> Being able to read a machine description from a file at run time
> sounds reasonable, as do tools to manipulate those descriptions.
> I don't see why such a description file would be any different
> from a firmware file or config file, especially if you were to think
> of QEMU in this case more like a simulation environment
> which I think is what Liviu is trying to use it as.

Yes, I agree that's fine and I'd be happy with that. That
means reading the XML file at runtime that the user provides...

> I agree actually including/distributing those description files is a completely
> different issue if they're derived from someone elses files;

...not preprocessing the XML into JSON, losing the license
info and attribution and shipping the JSON with QEMU. It's
those aspects that I think drop into the 'grey area'.

thanks
-- PMM

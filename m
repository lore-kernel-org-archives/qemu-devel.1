Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnSwG-0003uu-3H
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnSwE-0008B3-W4
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:07:32 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnSwE-00089T-Oz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 13:07:30 -0400
Received: by mail-wm0-x232.google.com with SMTP id r202so585727wmd.0
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 10:07:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150419776518.14429.1701568791442232463@loki>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<0413bb07-bd76-20fc-f29c-9b0bd60efd1d@redhat.com>
	<150419776518.14429.1701568791442232463@loki>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 18:07:08 +0100
Message-ID: <CAFEAcA8XQ+=N9k2QNEXHz9dJMwzw5emg1ff0Cijtv9mii74FGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 31 August 2017 at 17:42, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> Quoting Thomas Huth (2017-08-28 21:18:20)
>> Not sure, but maybe the following patch should be included, too, since
>> there were some bogus files in the old version of the U-Boot sources:
>>
>> 73663d71ef2bab201475d58e - PPC: E500: Update u-boot to v2017.07
>
> Do you have more background on any issues caused by these bogus files?
> As it stands I think I would opt not to update unless there are specific
> user-visible bugs we're trying to address which warrant the risk of any
> regressions which might get pulled in in the process.

These are the relevant threads:
https://lists.gnu.org/archive/html/qemu-discuss/2017-07/msg00005.html
and
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02956.html

The summary is
(1) one of the u-boot source files which is distributed as part
of the QEMU tarball has a comment which makes it a bit unclear
whether it's something that's redistributable (the source file
isn't actually used in the u-boot target we care about)
(2) the u-boot binary blob we were shipping doesn't correspond
to the sources we were shipping

and we fixed those in master by updating the blob and the
submodule to the most recent u-boot.

I guess the low-risk fix for the stable branch would be to
update the u-boot submodule to 79c884d7e4 as suggested in
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03174.html
which would bring the distributed sources into line with
the binary blob in stable, so no need to change the
blob we're distributing. I think it makes sense to do that
for stable.

thanks
-- PMM

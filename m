Received: from eggs.gnu.org ([2001:4830:134:3::10]:38388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duGMF-0000cp-Sn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duGMA-00022O-1P
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:06:27 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:48992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duGM9-00022F-QU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:06:21 -0400
Received: by mail-wm0-x231.google.com with SMTP id r68so4126455wmg.3
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 04:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505818700.12708.3.camel@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
	<CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
	<20170914124059.GD15518@redhat.com>
	<1505747575.4959.1.camel@redhat.com>
	<20170919100839.GH9536@redhat.com>
	<1505818700.12708.3.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 12:05:59 +0100
Message-ID: <CAFEAcA_ao-Zz=4bNZB3RG2DH04hcMzTRruDc6dO1KEj3obTB4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19 September 2017 at 11:58, Gerd Hoffmann <kraxel@redhat.com> wrote:

>> It feels like this is a similar scenario to 'config-host.mak' being
>> outdated. I don't entirely understand the logic yet, but we manage to
>> automatically re-run configure and rebuild config-host.make, when
>> configure changes, and that in turn affects which dependancies need
>> rebuild.
>
> Can't spot anything special in the Makefile.  Maybe make is clever
> enough to figure that a rule updates a include file and starts over
> then.

Yes, Make will notice if it has a dependency rule for a file
included via 'include foo' (or for the makefile itself). In
this case we 'include config-host.mak', and config-host.mak
has a rule which says it depends on configure (and on pc-bios ???)
which triggers a rerun of configure.

I also notice that we have a "TODO: this code can be removed
after QEMU 1.7" in the run-configure rune :-)

thanks
-- PMM

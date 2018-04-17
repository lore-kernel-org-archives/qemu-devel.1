Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8RF5-0007WM-Fv
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f8RF0-00026D-GX
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:05:55 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:37570
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1f8RF0-00025d-8S
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:05:50 -0400
References: <CAFEAcA-FaS+HeihGmbhrLAR8e=jmz-Og+OKGakGX7MGb_KgwCw@mail.gmail.com>
	<d002e4ff-e0c9-f66e-a25a-51605a79b55f@weilnetz.de>
	<CAFEAcA_rswg=c-QWcL1VraqiOEN1+zPmGG=-AP2f2CnYUA0K+g@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <37db1c18-cb62-0d93-3b4c-38d2ab20c804@weilnetz.de>
Date: Tue, 17 Apr 2018 16:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_rswg=c-QWcL1VraqiOEN1+zPmGG=-AP2f2CnYUA0K+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] Last call for release-critical fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 17.04.2018 um 15:50 schrieb Peter Maydell:
> On 17 April 2018 at 14:19, Stefan Weil <sw@weilnetz.de> wrote:
>> Update po files? That's not a "must fix", but it would be nice to have
>> those files synchronized with ui/gtk.c again.
> Judging by the "POT-Creation-Date" timestamps, we haven't done
> that for a year or so, so there doesn't seem to be a great
> urgency to do it now.
>
> Overall:
>  * I don't really understand why we need to keep doing this;
>    I tried "make -C po update" but all it did was update the
>    date stamp and a bunch of comments in the .po files
>  * If we do need to do this, we need to come up with a
>    process (preferably automatic) that ensures that we do
>    it in a more timely manner than "somebody mentions it
>    on the day we're thinking of tagging the final rc"
>
> Asking me to manually run a magic command I don't understand
> doesn't really work, as you can see from how infrequently
> it's happened.
>
> thanks
> -- PMM

The only visible consequence if it is not done is that developers who
run "make install" (which updates the po files) then have a local code
modification which is in the way if they are working with git. Not many
run "make install", and obviously those who do can handle the situation.
I think that there would be a real problem if people tried to build with
the source on a read only medium.

I wonder whether generating the po files without the line comments would
improve the situation. Currently each added or removed line in ui/gtk.c
changes the line numbers which are part of the comments. If the comments
would not include line numbers, then only relevant changes of message
texts would need an update of the po files. Maybe we should try that for
the next release.

Stefan

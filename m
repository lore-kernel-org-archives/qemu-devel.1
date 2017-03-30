Received: from eggs.gnu.org ([2001:4830:134:3::10]:37372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctaKv-000508-Fo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ctaKs-00074t-9G
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ctaKs-00073k-3T
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:41:58 -0400
Message-ID: <1490881315.28523.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 30 Mar 2017 15:41:55 +0200
In-Reply-To: <e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

  Hi,

> Excellent! I can help out with converting and/or testing the SPARC
> devices (cg3/tcx) if required.

Sure, test results and patches are very welcome.

I've touched dirty bitmap code for the first time, so I've sent out this
rfc for early feedback at the approach taken before going out converting
more display drivers.  Seems nobody found patch #2 horrible so far, I
take that as good sign that we can go on with this draft API.

> Out of interest, from your work do you have a rough estimate as to how
> this affects guest performance? For example benchmarks with Jan's
> original commit to reduce the locking vs. Alex's current workaround vs.
> with this patchset applied?

I expect this improves performance with mttcg because the locking goes
away, which allows more concurrency, probably more visible with more
guest cores.  Didn't benchmark it though.

cheers,
  Gerd

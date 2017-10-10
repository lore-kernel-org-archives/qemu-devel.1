Received: from eggs.gnu.org ([2001:4830:134:3::10]:57110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1x6q-0004TA-8P
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1x6k-0008An-Dz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1x6k-0008A1-07
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:10:14 -0400
Date: Tue, 10 Oct 2017 17:10:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171010161008.GM30015@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA-zUTfLOBkOeLc4e1Ok0dnKD=hWsdeR47125MhMnwV7UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-zUTfLOBkOeLc4e1Ok0dnKD=hWsdeR47125MhMnwV7UA@mail.gmail.com>
Subject: Re: [Qemu-devel] proposed schedule for 2.11 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Oct 10, 2017 at 03:07:26PM +0100, Peter Maydell wrote:
> OK, here's a strawman proposal for the 2.11 release cycle,
> based on aiming for a 5 Dec release date and working backwards
> with the same cadence as 2.10.
> 
> 2017-10-31 Soft freeze -- all feature changes must already be in a
>            pull request that's been sent to the mailing list
> 2017-11-07 Hard freeze, tag rc0
> 2017-11-14 Tag rc1
> 2017-11-21 Tag rc2
> 2017-11-28 Tag rc3
> 2017-12-05 Release (or rc4 if we need it)
> 2017-12-12 Release if we needed an rc4
> 
> 
> That makes softfreeze in 3 weeks time. I'd rather not push
> the times back any further because we end up in serious
> risk of running into the christmas holiday period.

Soft freeze date is not great from a KVM Forum timing POV - the 31st is
likely to be a travel day for most of the Red Hat devs.

That said I don't see a much nicer alternative, since giving two weeks
grace before xmas is good, to allow time for slippage in worst case
scenarios.

I guess, it in effect just means that most soft freeze work will want to
be front loaded in the next 2 weeks before KVM Forum travel starts impacting
working time.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

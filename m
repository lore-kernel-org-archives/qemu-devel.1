Received: from eggs.gnu.org ([2001:4830:134:3::10]:46614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvZ3t-0007aT-Uh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cvZ3q-0005VW-1q
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:44:38 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cvZ3p-0005VJ-Ta
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 20:44:33 -0400
Received: by mail-qt0-x22c.google.com with SMTP id n21so153466967qta.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 17:44:33 -0700 (PDT)
Date: Tue, 4 Apr 2017 20:44:27 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20170405004416.GA4911@foober.ini.cmu.edu>
References: <1491325264-14502-1-git-send-email-gsomlo@gmail.com>
	<c092a170-7c72-2999-5bc4-1b7504f66177@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c092a170-7c72-2999-5bc4-1b7504f66177@suse.de>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Update AppleSMC for OS X Sierra
 10.12.4 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

On Tue, Apr 04, 2017 at 09:35:00PM +0200, Alexander Graf wrote:
> On 04/04/2017 07:01 PM, Gabriel L. Somlo wrote:
> > As of 10.12.4 (currently the latest Sierra update), OS X refuses to boot
> > unless the AppleSMC supports a third I/O port, which provides the current
> > error status when read.
> 
> Looks much nicer after this series :). Thanks a lot!
> 
> Reviewed-by: Alexander Graf <agraf@suse.de>

Thanks! Thinking about it, we should probably drop the last (3/3)
patch, once again to minimize useless churn -- Doing that part (or
not, as the case may turn out to be) should be part of a future
series implementing more accurate emulation, including key write
support...

Thanks,
--Gabriel

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgGKF-0000S4-2r
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgGKB-00079g-UD
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:42:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgGKB-00079S-Nx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:42:11 -0500
Date: Tue, 21 Feb 2017 19:42:06 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170221194206.GK2377@work-vm>
References: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
	<5a03f6f2-f867-8dfe-28bb-6f481782f6af@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a03f6f2-f867-8dfe-28bb-6f481782f6af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] fix segfaults caused by accessing CPU
 in empty machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Ziyue Yang <skiver.cloud.yzy@gmail.com>, qemu-devel@nongnu.org, Ziyue Yang <yzylivezh@hotmail.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 17.02.2017 09:27, Ziyue Yang wrote:
> > From: Ziyue Yang <yzylivezh@hotmail.com>
> > 
> > Many QEMU monitor commands, like "info lapic", "info tlb" and so on
> > use mon_get_cpu or related wrappers to access CPU info without checking
> > whether the CPU exists.
> > This patch series fix the "info lapic" case, and is the base of the incoming
> > patch series aiming to eliminate segfaults caused by other QEMU commands
> > trying to access CPU that doesn't exist.
> 
>  Hi,
> 
> FYI, I've posted a patch for all of these monitor commands that crash
> without CPU already last month:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg02602.html

I've just sent that in my HMP pull:
https://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg04939.html

Ziyue Yang: Perhaps it's best to compare with the things in that
pull and check to see if you have any items that were not in that pull.

Dave

>  Thomas
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

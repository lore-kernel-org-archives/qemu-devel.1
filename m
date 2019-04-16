Received: from eggs.gnu.org ([209.51.188.92]:44302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSPh-0006N2-PC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSPg-00027u-Ol
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGSPg-00027G-Gs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:32 -0400
Date: Tue, 16 Apr 2019 15:02:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190416180220.GH32317@habkost.net>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416141700.GR18986@antique-laptop>
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Hrdina <phrdina@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Tue, Apr 16, 2019 at 04:17:00PM +0200, Pavel Hrdina wrote:
> On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > Add a new base CPU model called 'Dhyana' to model processors from Hygon
> > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > 
> > The following features bits have been removed compare to AMD EPYC:
> > aes, pclmulqdq, sha_ni
> > 
> > The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > CPU model.
> 
> I have once question that we will have to solve for EPYC CPUs as well.
> The name should not be based on the Product name or Model name as that
> usually doesn't change with introduction of new microarchitecture.
> 
> With EPYC we made a mistake to name the CPU like that, luckily with
> Intel we already use the microarchitecture name, so the EPYC CPU should
> have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> if there is any difference or otherwise we can simply use ZEN.
> 
> The issue here is what happens once the ZEN2 microarchitecture is out
> wihch introduces new features and we will have to come up with a CPU
> name.
> 
> Obviously we cannot change/remove the EPYC models so the question is
> what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> if they are both based on the ZEN microarchitecture?
> 
> In addition is there any way how we can introduce ZEN-Server &
> ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> new model next to the EPYC?

Currently there's no CPU model alias or inheritance system in x86
(yet), but feel free to submit a CPU model that's a copy of EPYC,
including the justification above.

When we implement CPU model versioning, we can make "EPYC" be
translated to "ZEN" by the CPU model version resolution API.

-- 
Eduardo

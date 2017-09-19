Received: from eggs.gnu.org ([2001:4830:134:3::10]:42875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duHvH-0001Oz-KJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1duHvE-0008Ow-Ge
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1duHvE-0008Nn-BK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:46:40 -0400
Date: Tue, 19 Sep 2017 14:46:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170919144635.6c6f21b9@nial.brq.redhat.com>
In-Reply-To: <20170919121125.GE21016@localhost.localdomain>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
	<20170915170326.5278d578@nial.brq.redhat.com>
	<20170918184213.2fd0ead5@Igors-MacBook-Pro.local>
	<20170919121125.GE21016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] generalize parsing of cpu_model
 (x86/arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>

On Tue, 19 Sep 2017 09:11:25 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Sep 18, 2017 at 06:42:13PM +0200, Igor Mammedov wrote:
> > On Fri, 15 Sep 2017 17:03:26 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > [...]  
> > > >   
> > > Hi Eduardo,
> > > 
> > > Could you merge it via machine tree?  
> > Forgot to actually CC Eduardo,
> > 
> > Just noticed a patch (1) on list adding a new soc that would break,
> > due to armv7 dropping cpu-model property in 5/5.
> > It would be better to merge this series asap so that people
> > could rebase their work on cpu-type based approach, instead of
> > continuing copy-past old cpu-model based code.
> > 
> > 1)
> > [Qemu devel v9 PATCH 4/5] msf2: Add Smartfusion2 SoC
> > 
> > CCing Subbaraya so he could amend patch to use cpu-type instead of cpu-model.  
> 
> Queued on machine-next:
> 
>  https://github.com/ehabkost/qemu.git machine-next
> 

Thanks!

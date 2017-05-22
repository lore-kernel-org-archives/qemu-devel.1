Received: from eggs.gnu.org ([2001:4830:134:3::10]:60287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCr3A-0003rt-VG
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dCr3A-0001yC-5m
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:23:20 -0400
Date: Mon, 22 May 2017 14:23:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170522172312.GD22043@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-4-git-send-email-imammedo@redhat.com>
	<20170518182039.GO4748@thinpad.lan.raisama.net>
	<20170522095836.59149abc@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522095836.59149abc@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] numa: silence incomplete mapping
 warning under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, May 22, 2017 at 09:58:36AM +0200, Igor Mammedov wrote:
> On Thu, 18 May 2017 15:20:39 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Thu, May 18, 2017 at 10:09:31AM +0200, Igor Mammedov wrote:
> > > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > Where exactly is the test code that triggers those messages and
> > requires this patch? I would like to document that in the commit
> > message.
> 
> ok, I'll  mention test case in commit message on respin

I will apply this version, and add "Silence warnings triggered by
the /numa/mon/cpus/partial test case" to the commit
message.

I want to merge it as soon as possible, as the warnings are
confusing people.

-- 
Eduardo

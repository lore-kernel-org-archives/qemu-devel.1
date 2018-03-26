Received: from eggs.gnu.org ([2001:4830:134:3::10]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f0Szk-00052t-As
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1f0Szh-00025w-4K
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:08 -0400
Received: from mail-ve1eur01hn0240.outbound.protection.outlook.com
	([104.47.1.240]:24219
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1f0Szg-00023w-GW
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 10:21:05 -0400
Date: Mon, 26 Mar 2018 17:20:46 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180326142046.GB2401@rkaganb.sw.ru>
References: <20180321121001.GD14983@rkaganb.sw.ru>
	<87bmfh7eip.fsf@vitty.brq.redhat.com>
	<20180321165729.GH14983@rkaganb.sw.ru>
	<20180321201924.GE3417@localhost.localdomain>
	<20180322130013.GB4500@rkaganb.sw.ru>
	<20180322132218.GH3417@localhost.localdomain>
	<20180322135803.GC4500@rkaganb.sw.ru>
	<20180322183813.GA28161@localhost.localdomain>
	<20180323094529.GA28085@rkaganb.sw.ru>
	<20180323194827.GM3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323194827.GM3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Fri, Mar 23, 2018 at 04:48:27PM -0300, Eduardo Habkost wrote:
> On Fri, Mar 23, 2018 at 12:45:30PM +0300, Roman Kagan wrote:
> > On Thu, Mar 22, 2018 at 03:38:13PM -0300, Eduardo Habkost wrote:
> > > It looks like the guest can still crash if we migrate
> > > "QEMU-2.12 -machine pc-2.11 -cpu ...,+hv-time" to a host running
> > > QEMU 2.11 and Linux < 4.14.
> > 
> > Indeed :(
> 
> Well, your patch fixes it by not enabling hv-frequencies by
> default on any machine-type.  Do you see any gotchas?

Only the need to add a new property in -stable.  I used to think that
was frowned upon.

> > So, taking the effort/complexity vs safety tradeoff into account, we can
> > consider an alternative approach: just add hv_frequencies (default=off)
> > cpu property to 2.12 and 2.11-stable, and ignore the cases where it's
> > run on QEMU versions without explicit control over this feature.  Would
> > it be too much against the current policy?
> > 
> 
> With this, we can just declare that QEMU v2.11.0 + Linux 4.14+
> was broken, and advise people to upgrade QEMU.
> 
> I think is the most reasonable option we have.  See my reply to
> the patch you sent.

Great, let's try going down this route.

Thanks,
Roman.

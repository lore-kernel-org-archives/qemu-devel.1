Received: from eggs.gnu.org ([2001:4830:134:3::10]:58886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO8gw-000428-8x
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fO8gt-0005bp-3N
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:31:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fO8gs-0005b4-TR
	for qemu-devel@nongnu.org; Wed, 30 May 2018 17:31:31 -0400
Date: Wed, 30 May 2018 18:31:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180530213122.GA3184@localhost.localdomain>
References: <20180529193730.9204-1-crosa@redhat.com>
	<20180529193730.9204-4-crosa@redhat.com>
	<20180530125705.GL14623@stefanha-x1.localdomain>
	<20180530162949.GE7451@localhost.localdomain>
	<47189c37-afec-6366-e9e4-cae5999d9eb2@redhat.com>
	<20180530200032.GF7451@localhost.localdomain>
	<8a92255d-51b7-89b0-59e5-2ac60cf026b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a92255d-51b7-89b0-59e5-2ac60cf026b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] Acceptance tests: add quick VNC
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Amador Pahim <amador@pahim.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, May 30, 2018 at 05:03:56PM -0400, Cleber Rosa wrote:
> On 05/30/2018 04:00 PM, Eduardo Habkost wrote:
[...]
>       [...]   Now, in addition to this very personal, and thus
> insignificant botheration, it restricts API design.  By signaling to
> users that this is valid:
> 
>   self.vm.add_args(...).launch(...).shutdown()
> 
> We'd be restricted on the design of, say, migrate().  Even if it sounds
> sensible to return a boolean indicating migration success, for
> consistency, it'd require a "return self".
[...]
> > I don't see why this would be an argument against making this
> > possible:
> > 
> >   self.vm.add_args('-nodefaults', '-S').launch()
> 
> Right, it's *mostly* style.  But, it suggests that all methods work
> similarly and thus restricts API design as mentioned before.
[...]
> > They are more readable than the complex method chaining examples
> > you have shown, but I don't see any argument against:
> > 
> >   self.vm.add_args(...).launch()
> 
> Right.  This one looks nice indeed.  *My* issues are related to
> expectations (all methods support this?), consistency (all methods
> should support this!) and the design limitations it brings.
> 

These are good points.

I believe it would be a reasonable convention to make methods
that change QEMU configuration return self (because they are
often called one after another), but other methods like launch()
migrate(), and shutdown() don't have to.

So this would work:

  self.vm.add_args(...).add_drive(...).launch()

But this doesn't have to:

  self.vm.add_args(...).launch().migrate().shutdown()

-- 
Eduardo

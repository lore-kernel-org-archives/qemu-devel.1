Received: from eggs.gnu.org ([2001:4830:134:3::10]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZpE9-0002cv-RX
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZpE4-0001SV-3L
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:42:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZpE3-0001OL-S8
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 22:42:20 -0500
Date: Wed, 19 Dec 2018 22:42:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219223700-mutt-send-email-mst@kernel.org>
References: <cover.1545120100.git.yi.z.zhang@linux.intel.com>
	<5eb87eb9a389242772375dd52bd97c17564a0829.1545120100.git.yi.z.zhang@linux.intel.com>
	<20181218085249-mutt-send-email-mst@kernel.org>
	<20181219091017.GA35378@tiger-server>
	<20181219105555-mutt-send-email-mst@kernel.org>
	<20181220030312.GA70591@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220030312.GA70591@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V7 6/6] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com

On Thu, Dec 20, 2018 at 11:03:12AM +0800, Yi Zhang wrote:
> On 2018-12-19 at 10:59:10 -0500, Michael S. Tsirkin wrote:
> > On Wed, Dec 19, 2018 at 05:10:18PM +0800, Yi Zhang wrote:
> > > > > +
> > > > > + - 'sync' option of memory-backend-file is not 'off', and
> > > > > +
> > > > > + - 'share' option of memory-backend-file is 'on'.
> > > > > +
> > > > > + - 'pmem' option of memory-backend-file is 'on'
> > > > > +
> > > > 
> > > > Wait isn't this what pmem was supposed to do?
> > > > Doesn't it mean "persistent memory"?
> > > pmem is a option for memory-backend-file, user should know the backend
> > > is in host persistent memory, with this flags on, while there is a host crash
> > > or a power failures.
> > > 
> > > [1] Qemu will take necessary operations to guarantee the persistence.
> > > https://patchwork.ozlabs.org/cover/944749/ 
> > > 
> > > [2] Host kernel also take opretions to consistent filesystem metadata.
> > > Add MAP_SYNC flags.
> > 
> > OK so I'm a user. Can you educate me please?  
> We suppose an administrator should know it, what is the back-end region coming from,
> is it persistent? what is the font-end device is? a volatile dimm or an
> nonvolatile dimm? then they can choice put the pmem=on[off] and sync=on[off].
> If he didn't, we encourage that don't set these 2 flags.
> 
> > When should MAP_SYNC not
> > be set? Are there any disadvantages (e.g.  performance?)?
> Not only the performance, sometimes like the front-end device is an
> volatile ram, we don't wanna set such option although the backend is a
> novolatile memory, if power lose, all of thing should lose in this ram.



I am not sure how does above answer the questions. If I don't know,
neither will the hypothetical administrator. Looks like a better
interface is needed to make the choice on behalf of the user.


> > 
> > -- 
> > MST
> > 

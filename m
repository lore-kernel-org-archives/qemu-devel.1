Received: from eggs.gnu.org ([2001:4830:134:3::10]:59584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwo7-0002o9-Qa
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQwo6-0006SV-Vd
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:22:03 -0400
Date: Fri, 30 Jun 2017 22:21:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170630142153.GA26114@lemon>
References: <1498734863-164338-1-git-send-email-imammedo@redhat.com>
	<41be440c-e158-fb83-15dd-e9853460d5a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41be440c-e158-fb83-15dd-e9853460d5a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qom: enforce readonly nature of link's
 check callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, alistair.francis@xilinx.com, edgar.iglesias@gmail.com, mst@redhat.com, afaerber@suse.de, qemu-arm@nongnu.org

On Fri, 06/30 12:41, Paolo Bonzini wrote:
> 
> 
> On 29/06/2017 13:14, Igor Mammedov wrote:
> > link's check callback is supposed to verify/permit setting it,
> > however currently nothing restricts it from misusing it
> > and modifying target object from within.
> > Make sure that readonly semantics are checked by compiler
> > to prevent callback's misuse.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > Fam,
> >  it probably conflicts with yours DEFINE_PROP_LINK series,
> >  feel free to include this patch if you'll have to respin
> 
> Since there will be a respin, I'm _not_ queuing this patch.

I am going to include this in my next version of DEFINE_PROP_LINK series.

Fam

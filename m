Received: from eggs.gnu.org ([2001:4830:134:3::10]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fuBYl-0007kg-Bx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fuBYk-0007ry-N6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fuBYk-0007ri-IE
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:03:34 -0400
Date: Mon, 27 Aug 2018 15:03:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180827070331.GC19413@lemon.usersys.redhat.com>
References: <20180827022253.28140-1-famz@redhat.com>
	<bbffc053-985e-3e27-dddf-1146891e0acb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbffc053-985e-3e27-dddf-1146891e0acb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Implement RFC2132 TFTP server
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, brad@comstyle.com

On Mon, 08/27 08:51, Thomas Huth wrote:
> On 2018-08-27 04:22, Fam Zheng wrote:
> > This new usernet option can be used to add data for option 66 (tftp
> > server name) in the BOOTP reply, which is useful in PXE based automatic
> > OS install such as OpenBSD.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> > 
> > v2: - Adjust parameter order and field placement to be closer to other
> > tftp options. [Samuel]
> >     - Drop 'optional'. [Eric]
> > ---
> >  net/slirp.c      | 5 ++++-
> >  qapi/net.json    | 5 ++++-
> >  slirp/bootp.c    | 8 ++++++++
> >  slirp/bootp.h    | 1 +
> >  slirp/libslirp.h | 4 +++-
> >  slirp/slirp.c    | 5 ++++-
> >  slirp/slirp.h    | 1 +
> >  7 files changed, 25 insertions(+), 4 deletions(-)
> 
> Please add information about this new parameter to the documentation in
> qemu-options.hx, too!

Oops, I totally forgot that. Yes!

Fam

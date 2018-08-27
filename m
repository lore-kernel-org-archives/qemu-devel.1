Received: from eggs.gnu.org ([2001:4830:134:3::10]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu78v-0007gG-Gt
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu78s-0000RH-5K
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fu78s-0000QS-13
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:34 -0400
Date: Mon, 27 Aug 2018 10:20:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180827022031.GB19413@lemon.usersys.redhat.com>
References: <20180824135312.1606-1-famz@redhat.com>
	<1f5e48b3-4fa1-1ff4-0775-1d36604cad3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f5e48b3-4fa1-1ff4-0775-1d36604cad3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: Implement RFC2132 TFTP server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, brad@comstyle.com

On Fri, 08/24 11:21, Eric Blake wrote:
> On 08/24/2018 08:53 AM, Fam Zheng wrote:
> > This new usernet option can be used to add data for option 66 (tftp
> > server name) in the BOOTP reply, which is useful in PXE based automatic
> > OS install such as OpenBSD.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> 
> > +++ b/qapi/net.json
> > @@ -174,6 +174,8 @@
> >   #
> >   # @guestfwd: forward guest TCP connections
> >   #
> > +# @tftp-server-name: (optional) RFC2132 "TFTP server name" string (Since 3.1)
> 
> The doc generator automatically marks up optional members these days, so you
> can drop '(optional)' from this line.

OK, will drop in v2. Thanks!

Fam

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTUbg-0002WD-2P
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1cTUbc-0001SQ-4f
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:19:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1cTUbb-0001SF-Un
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:19:24 -0500
Date: Tue, 17 Jan 2017 14:19:21 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170117141921.GE14855@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170117134208.GB14855@redhat.com>
	<20170117134440.GC14855@redhat.com>
	<20170117135734.GD14855@redhat.com>
	<20170117140541.GJ3491@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117140541.GJ3491@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Tue, Jan 17, 2017 at 12:05:41PM -0200, Eduardo Habkost wrote:
> On Tue, Jan 17, 2017 at 01:57:34PM +0000, Richard W.M. Jones wrote:
> > 
> > Oh no wait, these errors are just because of the new version of qemu
> > that I am using to test your patch, so nothing to do with this patch.
> > 
> > /me fires up git bisect ...
> 
> Probably it's the bug I have bisected and reported yesterday.
> See:
> 
>   Subject: [Qemu-devel] [PATCH 49/65] tcg/i386: Rely on undefined/undocumented behaviour of BSF/BSR

Yup, you're way ahead of me.  Reverting that commit (4ac76910734209)
does indeed fix Fedora kernel + TCG.

Please add:

  Tested-by: Richard W.M. Jones <rjones@redhat.com>

to the current patch (``i386: Support "-cpu host" on TCG too'') if you
wish, and CC me on any future versions so I can test those as well.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUOS-00044B-Gy
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTUOO-0003Vh-SR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:05:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTUOO-0003VH-J0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:05:44 -0500
Date: Tue, 17 Jan 2017 12:05:41 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170117140541.GJ3491@thinpad.lan.raisama.net>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<20170117134208.GB14855@redhat.com>
	<20170117134440.GC14855@redhat.com>
	<20170117135734.GD14855@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170117135734.GD14855@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On Tue, Jan 17, 2017 at 01:57:34PM +0000, Richard W.M. Jones wrote:
> 
> Oh no wait, these errors are just because of the new version of qemu
> that I am using to test your patch, so nothing to do with this patch.
> 
> /me fires up git bisect ...

Probably it's the bug I have bisected and reported yesterday.
See:

  Subject: [Qemu-devel] [PATCH 49/65] tcg/i386: Rely on undefined/undocumented behaviour of BSF/BSR

-- 
Eduardo

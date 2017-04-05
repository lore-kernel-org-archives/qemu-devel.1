Received: from eggs.gnu.org ([2001:4830:134:3::10]:56088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvjWQ-0006MU-NF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvjWP-0007hq-V0
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:54:46 -0400
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
	<9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
	<274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
	<20170405081835.GB30620@redhat.com>
	<alpine.DEB.2.20.1704051020170.3005@hadrien>
	<20170405082443.GD30620@redhat.com>
	<alpine.DEB.2.20.1704051037490.3005@hadrien>
	<20170405090151.GK30620@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1af948cb-4fbd-8ae4-8690-8a3f9e439987@redhat.com>
Date: Wed, 5 Apr 2017 13:54:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170405090151.GK30620@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/04/2017 11:01, Richard W.M. Jones wrote:
> On Wed, Apr 05, 2017 at 10:38:37AM +0200, Julia Lawall wrote:
>> OK, there is nothing special about g_assert_cmpint, but Coccinelle expects
>> expressions or types in function argument lists, so it gives a parse error
>> on finding an ==.
> 
> I should have checked the coccinelle mailing list before asking you,
> because I see that Eric already asked this question and you answered
> it.  For reference, that is here:
> 
>   https://systeme.lip6.fr/pipermail/cocci/2017-April/004107.html
> 
> Thanks again,

Eric, are you using the scripts/cocci-macro-file.h?

    commit 6ad978e9f40d3edfd9f4a86b4a60e3523eff08fe
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Wed May 18 11:11:55 2016 +0200

    coccinelle: add g_assert_cmp* to macro file

    This helps applying semantic patches to unit tests.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo

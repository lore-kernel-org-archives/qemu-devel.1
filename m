Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBeju-0001dt-Cj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBejp-0004WZ-E9
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:07:02 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:3671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBejp-0004UA-49
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 07:06:57 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23265.45771.760936.993507@mariner.uk.xensource.com>
Date: Thu, 26 Apr 2018 12:06:51 +0100
In-Reply-To: <1524592709-6553-2-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-2-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] checkpatch: Add
 xendevicemodel_handle to the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Eric Blake <eblake@redhat.com>, Paolo
	Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

(expanding the CC to include everyone that get_maintainer suggests)

Ian Jackson writes ("[PATCH 01/16] checkpatch: Add xendevicemodel_handle to the list of types"):
> This avoids checkpatch misparsing (as statements) long function
> definitions or declarations, which sometimes start with constructs
> like this:
> 
>   static inline int xendevicemodel_relocate_memory(
>       xendevicemodel_handle *dmod, domid_t domid, ...
> 
> The type xendevicemodel_handle does not conform to Qemu CODING_STYLE,
> which would suggest CamelCase.  However, it is a type defined by the
> Xen Project in xen.git.  It would be possible to introduce a typedef
> to allow the qemu code to refer to it by a differently-spelled name,
> but that would obfuscate more than it would clarify.

This patch has been posted in substantially similar form quite a few
times now.  Paolo Bonzini understandably suggested that renaming the
variable would be better but that's not within qemu's bailiwick as I
say above.

I think everything else in this series has a review and/or an ack.
So I would like to send a pull request.

Does someone want to review this patch ?  Should I drop it and just
let checkpatch complain ?  Shold I include it in my pull request
anyway ?

Thanks,
Ian.

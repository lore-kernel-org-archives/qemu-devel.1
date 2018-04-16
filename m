Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f87Uq-0000mf-Cc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f87Un-0004eI-5a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:00:52 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:11768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f87Um-0004dA-R6
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:00:49 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23252.54972.659826.276061@mariner.uk.xensource.com>
Date: Mon, 16 Apr 2018 18:00:44 +0100
In-Reply-To: <87tvsbm8gl.fsf@dusky.pond.sub.org>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-9-git-send-email-ian.jackson@eu.citrix.com>
	<874lkfxfxt.fsf@dusky.pond.sub.org>
	<23252.44539.262716.947319@mariner.uk.xensource.com>
	<87tvsbm8gl.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas <uid>:<gid> facility"):
> Ian Jackson <ian.jackson@citrix.com> writes:
> > That would defer the getpwnam from argument parsing to os_setup_post.
> > I think that's undesriable.
> 
> No argument.  But why can't os_parse_cmd_args() call getpwnam() as it
> does now, then store user_pwd->pw_uid, ->pw_gid and ->pw_name instead of
> user_pwd?  Store a null name when it parses the argument as UID:GID.

Oh, I see.  It seems less obvious to me than what I have done, but I
can do it like that if you like.

Ian.

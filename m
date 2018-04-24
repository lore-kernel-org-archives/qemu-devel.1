Received: from eggs.gnu.org ([2001:4830:134:3::10]:39871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzVi-0007Sn-Rj
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzVZ-0002dw-7Z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:05:38 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:57325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6454bde7c=Ian.Jackson@citrix.com>)
	id 1fAzVY-0002XS-U9
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:05:29 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23263.18333.710326.753665@mariner.uk.xensource.com>
Date: Tue, 24 Apr 2018 16:05:01 +0100
In-Reply-To: <4402483b-17fd-60e0-4f00-05887a11320d@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-17-git-send-email-ian.jackson@eu.citrix.com>
	<20180423162142.GG1980@perard>
	<23262.3101.567189.675156@mariner.uk.xensource.com>
	<4402483b-17fd-60e0-4f00-05887a11320d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some
 extra info under bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefano  Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo
	Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org

Eric Blake writes ("Re: [Qemu-devel] [PATCH 16/16] configure: do_compiler: Dump some extra info under bash"):
> That's still fork-heavy.  You could do:
> 
> test -n "$BASH_VERSION" && eval '
> echo >>config.log "
> funcs: ${FUNCNAME[*]}
> lines: ${BASH_LINENO[*]}
> files: ${BASH_SOURCE[*]}"'
> 
> which avoids the fork, but remains silent on dash.

Thanks.  I will adopt this.  Although I will use if ... then as that
seems to be the usual style.  (&& would break with set -e which
configure does not use...)

Ian.

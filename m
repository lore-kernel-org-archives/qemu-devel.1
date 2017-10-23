Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4622db8cb=Ian.Jackson@citrix.com>)
	id 1e6ajx-0000Ua-BU
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4622db8cb=Ian.Jackson@citrix.com>)
	id 1e6ajt-0004Lk-AL
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:17:53 -0400
Received: from smtp.citrix.com ([66.165.176.89]:11493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4622db8cb=Ian.Jackson@citrix.com>)
	id 1e6ajt-0004LA-2o
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:17:49 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23021.53199.570668.934105@mariner.uk.xensource.com>
Date: Mon, 23 Oct 2017 12:17:35 +0100
In-Reply-To: <1508506702-17704-8-git-send-email-ian.jackson@eu.citrix.com>,
	<1508528463.474221335@apps.rackspace.com>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-8-git-send-email-ian.jackson@eu.citrix.com>
	<1508528463.474221335@apps.rackspace.com>
Subject: [Qemu-devel] [PATCH v5.1 8/8] configure: do_compiler: Dump some
 extra info under bash [and 1 more messages]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kent R. Spillner" <kspillner@acm.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano
	Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Ian Jackson writes ("[PATCH v5.1 8/8] configure: do_compiler: Dump some extra info under bash"):
> This makes it much easier to find a particular thing in config.log.
> 
> The information may be lacking in other shells, resulting in harmless
> empty output.  (This is why we don't use the proper ${FUNCNAME[*]}
> array syntax - other shells will choke on that.)
> 
> The extra output is only printed if configure is run with bash.  The
> something), it is necessary to say   bash ./configure  to get the extra
> debug info in the log.

Kent Spillner points out that this last sentence is garbled.  The
paragraph should read:

  The extra output is only printed if configure is run with bash.  On
  systems where /bin/sh is not bash, it is necessary to say bash
  ./configure to get the extra debug info in the log.

I have updated it in my branch.

Ian.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqDGB-0000PW-Ch
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqDG6-0000QE-NB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqDG6-0000P7-Ho
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:59:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57412C04B303
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 06:59:21 +0000 (UTC)
Date: Fri, 8 Sep 2017 14:59:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908065919.GG4511@lemon>
References: <20170906124900.17354-1-famz@redhat.com>
	<20170908063106.GF4511@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908063106.GF4511@lemon>
Subject: Re: [Qemu-devel] [PATCH v4] buildsys: Move crypto cflags/libs to
 per object variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Fri, 09/08 14:31, Fam Zheng wrote:
> On Wed, 09/06 20:49, Fam Zheng wrote:
> > This patch groups the crypto objects into a few .mo objects based on
> > functional submodules, and moves inclusion conditions to *-objs
> > variables, then moves the global cflags/libs to the *-cflags and *-libs
> > variables.
> > 
> > For init.o and cipher.o, which may or may not need the library flags
> > depending on config, adding flags and libs unconditionally doesn't hurt,
> > because if the library is not available, the variables are empty.  This
> > makes less code.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Cc Dan. No idea why it was empty.

Hmm, what is going on? Trying again with email address only.

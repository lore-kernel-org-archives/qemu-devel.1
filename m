Received: from eggs.gnu.org ([2001:4830:134:3::10]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e5Cgi-0001T6-SE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdenemar@redhat.com>) id 1e5Cgf-0000qh-MW
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1e5Cgf-0000qQ-GI
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:24:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92DF5C05004B
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 15:24:44 +0000 (UTC)
Date: Thu, 19 Oct 2017 17:24:42 +0200
From: Jiri Denemark <jdenemar@redhat.com>
Message-ID: <20171019152442.GG130425@orkuz.home>
References: <20171018174013.22709-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018174013.22709-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] migration: pause-before-switchover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

The libvirt changes which will make use of this new migration capability
can be found in migration-pause branch of my gitlab repository:

    git fetch https://gitlab.com/jirkade/libvirt.git migration-pause

It's not properly split into patches, it has no commit message etc.,
but the functionality should be complete.

Feel free to test it and report any issues.

Thanks,

Jirka

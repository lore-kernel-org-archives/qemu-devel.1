Received: from eggs.gnu.org ([2001:4830:134:3::10]:50753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfjbC-0002m2-Mc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfjbB-00022m-My
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:17:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-9-pbonzini@redhat.com>
Date: Thu, 10 Aug 2017 11:17:37 +0200
In-Reply-To: <20170809215510.22802-9-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 9 Aug 2017 23:55:06 +0200")
Message-ID: <874ltfhjda.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/12] qemu-iotests: fix uninitialized
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

Drive-by comment:

Paolo Bonzini <pbonzini@redhat.com> writes:

> The function is used in "common" but defined only after the file

"This variable"

> is sourced.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

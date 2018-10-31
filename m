Received: from eggs.gnu.org ([2001:4830:134:3::10]:44286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrrF-0001NJ-St
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHrrF-0006gV-65
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:52:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181031053920.7565-1-famz@redhat.com>
Date: Wed, 31 Oct 2018 15:51:53 +0100
In-Reply-To: <20181031053920.7565-1-famz@redhat.com> (Fam Zheng's message of
	"Wed, 31 Oct 2018 13:39:20 +0800")
Message-ID: <87va5irwxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Fam Zheng <famz@redhat.com> writes:

> Use error_report for situations that affect user operation (i.e.  we're
> actually returning error), and warn_report/warn_report_err when some
> less critical error happened but the user operation can still carry on.
>
> For raw_normalize_devicepath, add Error parameter to propagate to
> its callers.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Kevin, if you'd prefer this to go through my tree, let me know.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cilIy-0007oy-SJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cilIy-0001fB-3L
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:11:16 -0500
Date: Tue, 28 Feb 2017 18:11:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228171107.GR4090@noname.redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-17-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488194450-28056-17-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/24] monitor: Assert qmp_schema_json[] is
 sane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com

Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
> qmp_query_qmp_schema() parses qmp_schema_json[] with
> qobject_from_json().  This must not fail, so pass &error_abort.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

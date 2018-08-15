Received: from eggs.gnu.org ([2001:4830:134:3::10]:44525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpopk-0001Qm-No
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpoph-0006i6-B1
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:59:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpoph-0006hC-0B
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 01:59:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180524044454.11792-1-peterx@redhat.com>
Date: Wed, 15 Aug 2018 07:58:52 +0200
In-Reply-To: <20180524044454.11792-1-peterx@redhat.com> (Peter Xu's message of
	"Thu, 24 May 2018 12:44:52 +0800")
Message-ID: <87mutop3vn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/2] error-report: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

I'm afraid I let this fall through the cracks.  Sorry about that!

PATCH 2 conflicts semantically with commmit 63b88968f13: the latter adds
a trace_vtd_err() the former doesn't replace.  Please respin.

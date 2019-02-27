Received: from eggs.gnu.org ([209.51.188.92]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gz4pR-0003Cv-0G
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gz4pQ-0007tt-0z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:25:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gz4pP-0007rr-Qp
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 14:25:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190222153254.22739-1-stefanha@redhat.com>
	<87imx8uu99.fsf@dusky.pond.sub.org>
	<20190225092846.GA4757@angien.pipo.sk>
	<20190225174001.GI379@stefanha-x1.localdomain>
	<87a7iincg0.fsf@dusky.pond.sub.org>
	<20190227145117.GD22539@stefanha-x1.localdomain>
Date: Wed, 27 Feb 2019 20:25:08 +0100
In-Reply-To: <20190227145117.GD22539@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Wed, 27 Feb 2019 14:51:17 +0000")
Message-ID: <878sy1uj8r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Feb 26, 2019 at 10:09:19AM +0100, Markus Armbruster wrote:
>> The migrate-with-cache-direct-off-on-linux case is compile-time static.
>
> By the way, I will change "migrate-with-cache-direct-off-on-linux" to
> "migrate-with-cache-direct-off".  Linux builds will report this feature
> while non-Linux builds will not.  If we ever add non-Linux support, then
> we can report this feature in those builds too.

Good idea.

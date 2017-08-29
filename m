Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhdV-000068-Rw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmhdR-0001vN-Hp
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:37:01 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:41765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dmhdR-0001ut-8M
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:36:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Tue, 29 Aug 2017 16:36:45 +0200
Message-ID: <w51fucafnk2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Tue 29 Aug 2017 04:23:01 PM CEST, Pradeep Jagadeesh wrote:
> These patches provide the qmp interface, to query the io throttle 
> status of the all fsdev devices that are present in a vm.
> also, it provides an interface to set the io throttle parameters of a
> fsdev to a required value. some of the patches also remove the duplicate
> code that was present in block and fsdev files. 

Oops, I was just reviewing the previous version of this series, but it
looks like you just moved code around, so my comments still apply.

Anyway, this should be v9, shouldn't it? v8 was published weeks ago:

   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01043.html

Berto

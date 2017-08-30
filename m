Received: from eggs.gnu.org ([2001:4830:134:3::10]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn4dr-00035h-EE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dn4do-0000OA-0R
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:10:55 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:43929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dn4dn-0000Md-Il
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:10:51 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <f6cdc881-39a4-92f6-c218-a57516ca0921@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51fuc98di8.fsf@maestria.local.igalia.com>
	<9b24c28f-f891-1046-f09f-bffded9e316f@huawei.com>
	<w51bmmx85so.fsf@maestria.local.igalia.com>
	<f6cdc881-39a4-92f6-c218-a57516ca0921@huawei.com>
Date: Wed, 30 Aug 2017 17:10:36 +0200
Message-ID: <w518ti1851v.fsf@maestria.local.igalia.com>
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
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Wed 30 Aug 2017 05:07:29 PM CEST, Pradeep Jagadeesh wrote:

> Thanks for the steps, I did reproduce the issue easily. Looking into
> the code, may be we also need to try the same with the block devices.

I did some tests and it was working fine, so I'd suspect of the fsdev
code first.

Berto

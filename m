Received: from eggs.gnu.org ([2001:4830:134:3::10]:37873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dqI2W-0002Sf-7E
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dqI2Q-0005zI-9W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:05:40 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:51406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dqI2P-0005Kw-T7
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:05:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87d171fqzd.fsf@dusky.pond.sub.org>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<87d171fqzd.fsf@dusky.pond.sub.org>
Date: Fri, 08 Sep 2017 13:33:46 +0200
Message-ID: <w51mv652zmt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

On Fri 08 Sep 2017 12:02:14 PM CEST, Markus Armbruster wrote:

>> +    fse = get_fsdev_fsentry(arg->has_id ? arg->id : NULL);
>
> !arg->has_id implies !arg->id.

Hey Markus,

I have the impression that I've also written code that never uses
arg->foo when arg->has_foo is false.

Can we then assume that to be NULL/0 in all cases? Also for other data
types (int, bool, ...)?

Berto

Received: from eggs.gnu.org ([209.51.188.92]:34063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHr3-0002yj-Vd
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyHr3-0000cz-9r
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:07:41 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-4-jsnow@redhat.com>
	<be3360bb-cbc1-daa1-2297-f3f8a88faac9@virtuozzo.com>
	<f8cee179-d67f-2426-7d65-c208a82f1876@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b293f181-7b78-c11b-81ab-0f4b04e6fb25@redhat.com>
Date: Mon, 25 Feb 2019 09:07:23 -0600
MIME-Version: 1.0
In-Reply-To: <f8cee179-d67f-2426-7d65-c208a82f1876@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] block/dirty-bitmaps: add
 block_dirty_bitmap_check function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

On 2/25/19 8:59 AM, Vladimir Sementsov-Ogievskiy wrote:

> 
> And one more important question: we now creating new qapi bitmap status, consisting of several bool fields.
> Shouldn't we instead implement it as an array of flags?

Parsing:

{ "busy": false, "persistent": false, "recording": true }

is easier than parsing:

{ "flags": [ "recording" ] }

(and knowing that unlisted flags "busy", "persistent", and
"inconsistent" are false), or:

{ "flags": [ { "busy": false }, { "persistent": false }, { "recording":
true } ] }

So without more reason why an array of flags would be needed, I don't
see the point for it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

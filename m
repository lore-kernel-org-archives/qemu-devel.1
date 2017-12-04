Received: from eggs.gnu.org ([2001:4830:134:3::10]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLz1m-0006rj-6i
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eLz1l-0008Ek-7C
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 17:15:54 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
Date: Mon, 4 Dec 2017 17:15:45 -0500
MIME-Version: 1.0
In-Reply-To: <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com



On 12/01/2017 02:41 PM, Max Reitz wrote:
> ((By the way, I don't suppose that's how it should work...  But I don't
> suppose that we want propagation of dirtying towards the BDS roots, do
> we? :-/))

I have never really satisfactorily explained to myself what bitmaps on
intermediate notes truly represent or mean.

The simple case is "This layer itself serviced a write request."

If that information is not necessarily meaningful, I'm not sure that's a
problem except in configuration.


...Now, if you wanted to talk about bitmaps that associate with a
Backend instead of a Node...

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dUZiq-0000XI-Q3
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dUZip-0007PH-WB
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:31:36 -0400
References: <20170710083553.6167-1-den@openvz.org>
	<bb92a87e-193a-9f61-38c5-ee69fcff2a97@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <1b8afbef-5c44-d81a-68d2-52e239b7e46f@openvz.org>
Date: Mon, 10 Jul 2017 17:31:00 +0300
MIME-Version: 1.0
In-Reply-To: <bb92a87e-193a-9f61-38c5-ee69fcff2a97@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix possible return code
 clobbering in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 07/10/2017 04:51 PM, Eric Blake wrote:
> On 07/10/2017 03:35 AM, Denis V. Lunev wrote:
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com> (supporter:Block I/O path)
>> CC: Fam Zheng <famz@redhat.com> (supporter:Block I/O path)
> The commit message is a bit sparse; I might have written:
>
> block: fix shadowed variable in bdrv_co_pdiscard
>
> We've had a shadowed 'ret' variable, which risks returning the wrong
> value, introduced in commit b9c64947.
thank you for the proposal.

Den

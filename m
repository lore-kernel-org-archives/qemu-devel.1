Received: from eggs.gnu.org ([2001:4830:134:3::10]:54448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cYIWc-0000yP-04
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cYIWX-0007aM-0J
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:26:06 -0500
Received: from mail-db5eur01on0091.outbound.protection.outlook.com
	([104.47.2.91]:27379
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cYIWW-0007a5-BA
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:26:00 -0500
References: <1485782396-22341-1-git-send-email-den@openvz.org>
	<20170130154749.GJ27325@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <054865b8-9d37-e51c-8f52-30aed490a2e9@openvz.org>
Date: Mon, 30 Jan 2017 18:52:17 +0300
MIME-Version: 1.0
In-Reply-To: <20170130154749.GJ27325@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] io: ignore case in WebSocket HTTP
 header #PSBM-57554
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

On 01/30/2017 06:47 PM, Daniel P. Berrange wrote:
> What is #PSBM-57554 referring to ?  Is that some custom bug tracker
> you have ? I'm going to drop that unless its something we need to
> keep
it must be dropped. Sorry, this is my mistake.

Den


> On Mon, Jan 30, 2017 at 04:19:56PM +0300, Denis V. Lunev wrote:
>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>
>> According to RFC7230 Section 3.2, header field name is case-insensitive.
>>
>> The haystack string length is limited by 4096 bytes by
>> qio_channel_websock_handshake_read().
>>
>> Further, handshake_process() dups and NULL-terminates the string
>> so it is safe to call non length-limited functions like strcasestr().
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  io/channel-websock.c | 25 ++++++++++++++-----------
>>  1 file changed, 14 insertions(+), 11 deletions(-)
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>
> will add this to my io queue
>
> Regards,
> Daniel

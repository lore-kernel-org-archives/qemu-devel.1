Received: from eggs.gnu.org ([2001:4830:134:3::10]:50098)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYEO9-0001Aa-TE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYEO5-000833-W0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:33:21 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54865 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYEO5-00082Z-N4
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:33:17 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-11-git-send-email-pl@kamp.de>
	<cc13b2a9-82be-e3d8-5a6b-4d29814c70e4@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <f9204b7c-61d4-2947-9c31-8d6e1626fd6e@kamp.de>
Date: Thu, 20 Jul 2017 18:33:14 +0200
MIME-Version: 1.0
In-Reply-To: <cc13b2a9-82be-e3d8-5a6b-4d29814c70e4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 10/10] block/qcow2: add compress info to
 image specific info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 20.07.2017 um 18:05 schrieb Eric Blake:
> On 07/20/2017 09:20 AM, Peter Lieven wrote:
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/qcow2.c        | 9 +++++++++
>>  qapi/block-core.json | 6 +++++-
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 9eb76df..9310715 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -68,6 +68,9 @@
>>  # @encrypt: details about encryption parameters; only set if image
>>  #           is encrypted (since 2.10)
>>  #
>> +# @compress: details about parameters for compressed clusters; only set if
>> +#            the compress format header extension is present (since 2.10)
> Would it be possible/wise to ALWAYS output compression information, even
> if it is the older style zlib with small window and default level?  Made
> easier if you can represent all tunables of zlib (where you special-case
> writing the qcow2 header to omit the extension header when the user has
> requested the defaults).

If we would store it in the header it will make the read and write of
the header much more complicated if we don't add the window size
to the default header (e.g. shrinking the format name to 14 and adding
to uint8_t for level and window size)

>
> This is a new feature, and unfortunately we've missed soft freeze for
> 2.10.  You'll want to update your series to uniformly state since 2.11.
>
Okay.

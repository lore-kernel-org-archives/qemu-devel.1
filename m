Received: from eggs.gnu.org ([2001:4830:134:3::10]:51139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMAVd-00048W-8r
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMAVa-0005q4-6I
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:31:29 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
	<w51k1y2307y.fsf@maestria.local.igalia.com>
	<bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
Date: Tue, 05 Dec 2017 11:31:14 +0100
Message-ID: <w51h8t531ql.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 04 Dec 2017 07:26:02 PM CET, Max Reitz wrote:
>>> +static void curl_refresh_filename(BlockDriverState *bs)
>>> +{
>>> +    BDRVCURLState *s = bs->opaque;
>>> +
>>> +    if (!s->sslverify || s->cookie ||
>>> +        s->username || s->password || s->proxyusername || s->proxypassword)
>>> +    {
>> 
>> Is !s->sslverify negative because that setting is true by default?
>
> Yes, exactly.  If it's false, you'd need to override it (and you can't
> do that through a plain filename).

I think this is not the only case in this series, but I'm not very
comfortable with the idea that this condition and the default value of
the setting are implicity dependent on each other. If you change one and
forget to change the other things will break.

I understand that the default value is never supposed to change so in
practice I don't see this breaking, but is it perhaps worth adding tests
for all these cases?

Berto

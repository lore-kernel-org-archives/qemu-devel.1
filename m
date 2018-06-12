Received: from eggs.gnu.org ([2001:4830:134:3::10]:60602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSd9p-00082d-A9
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vskytta@gmail.com>) id 1fSd9o-00069R-JM
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:51:57 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:43729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vskytta@gmail.com>) id 1fSd9o-00069F-ED
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:51:56 -0400
Received: by mail-io0-x244.google.com with SMTP id t6-v6so26790156iob.10
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 23:51:56 -0700 (PDT)
MIME-Version: 1.0
Sender: vskytta@gmail.com
In-Reply-To: <c04beb13-18f6-f5d9-6864-00206e7cbea0@redhat.com>
References: <20180611202532.2334-1-ville.skytta@iki.fi>
	<c04beb13-18f6-f5d9-6864-00206e7cbea0@redhat.com>
From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Date: Tue, 12 Jun 2018 09:51:35 +0300
Message-ID: <CABr9L5DZ7M_6V+Xv+KPToHKqyc2LWeYZa6T6TimSAjOAqNBm7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jun 12, 2018 at 1:00 AM, Eric Blake <eblake@redhat.com> wrote:
> On 06/11/2018 03:25 PM, Ville Skytt=C3=A4 wrote:
>>
>> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
>> ---
>
[...]
>
>> +++ b/docs/interop/qcow2.txt
>> @@ -326,7 +326,7 @@ in the image file.
>>   It contains pointers to the second level structures which are called
>> refcount
>>   blocks and are exactly one cluster in size.
>>   -Given a offset into the image file, the refcount of its cluster can b=
e
>> obtained
>> +Given an offset into the image file, the refcount of its cluster can be
>> obtained
>>   as follows:
>
>
> This line is now long; it might be better if you reflow 'obtained', more
> like...
>
>>         refcount_block_entries =3D (cluster_size * 8 / refcount_bits)
>> @@ -365,7 +365,7 @@ The L1 table has a variable size (stored in the
>> header) and may use multiple
>>   clusters, however it must be contiguous in the image file. L2 tables a=
re
>>   exactly one cluster in size.
>>   -Given a offset into the virtual disk, the offset into the image file
>> can be
>> +Given an offset into the virtual disk, the offset into the image file c=
an
>> be
>>   obtained as follows:
>
>
> ...this line.
>
> With or without the reflow,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reflowing, new patch follows in a separate mail.

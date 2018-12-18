Received: from eggs.gnu.org ([2001:4830:134:3::10]:34956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZLFX-00059r-Ce
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZL2n-00027D-Ox
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:28:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZL2n-00023f-HX
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 14:28:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id f81so3968988wmd.4
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 11:28:41 -0800 (PST)
References: <20181218175122.3229-1-philmd@redhat.com>
	<20181218175122.3229-2-philmd@redhat.com>
	<b7ebdd16-17d2-676d-d444-78eb85627e5d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a8ffe704-62e6-5a98-075f-4f8942be978f@redhat.com>
Date: Tue, 18 Dec 2018 20:28:38 +0100
MIME-Version: 1.0
In-Reply-To: <b7ebdd16-17d2-676d-d444-78eb85627e5d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qemu/compiler: Define QEMU_NONSTRING
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, 1803872@bugs.launchpad.net, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ben Pye <ben@curlybracket.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liu Yuan <namei.unix@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Max Reitz <mreitz@redhat.com>

On 12/18/18 7:29 PM, Eric Blake wrote:
> On 12/18/18 11:51 AM, Philippe Mathieu-Daudé wrote:
>> GCC 8 introduced the -Wstringop-truncation checker to detect
>> truncation by
>> the strncat and strncpy functions (closely related to
>> -Wstringop-overflow,
>> which detect buffer overflow by string-modifying functions declared in
>> <string.h>).
> 
> This paragraph talks about a new warning checker, but makes no mention
> of an attribute.
> 
>>
>> Add the QEMU_NONSTRING macro which checks if the compiler supports this
>> attribute.
> 
> Thus, "this attribute" has no antecedent; did you forget to add a
> sentence to the previous paragraph, or maybe put the mention of adding
> QEMU_NONSTRING after...
> 
>>
>>> From the GCC manual [*]:
>>
>>    The nonstring variable attribute specifies that an object or member
>>    declaration with type array of char, signed char, or unsigned char,
>>    or pointer to such a type is intended to store character arrays that
>>    do not necessarily contain a terminating NUL. This is useful in
>> detecting
>>    uses of such arrays or pointers with functions that expect
>> NUL-terminated
>>    strings, and to avoid warnings when such an array or pointer is
>> used as
>>    an argument to a bounded string manipulation function such as strncpy.
> 
> ...the explanation of how the attribute was added in tandem with the new
> warning checker for silencing specific instances of the warning?

Yes... I will rewrite this.

> 
>>
>> [*]
>> https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-nonstring-variable-attribute
>>
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   include/qemu/compiler.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

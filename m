Received: from eggs.gnu.org ([2001:4830:134:3::10]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPzT-00045l-Vi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eCPzR-0000dt-8C
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 08:02:00 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-19-mreitz@redhat.com>
	<w51o9okwtgx.fsf@maestria.local.igalia.com>
	<15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
Date: Wed, 08 Nov 2017 14:01:42 +0100
Message-ID: <w51r2t8zzyh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
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

On Thu 02 Nov 2017 05:18:31 PM CET, Max Reitz wrote:
> On 2017-11-02 17:11, Alberto Garcia wrote:
>> On Fri 29 Sep 2017 06:53:40 PM CEST, Max Reitz wrote:
>>>      QLIST_ENTRY(BlockDriver) list;
>>> +
>>> +    /* Pointer to a NULL-terminated array of names of significant options that
>>> +     * can be specified for bdrv_open(). A significant option is one that
>>> +     * changes the data of a BDS.
>>> +     * If this pointer is NULL, the array is considered empty.
>>> +     * "filename" and "driver" are always considered significant. */
>>> +    const char *const *sgfnt_runtime_opts;
>>>  };
>> 
>> Is sgfnt a common acronym? I actually had to look it up...
>
> I'm open for other suggestions to shorten "significant". :-)

Nah, it's ok :)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

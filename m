Received: from eggs.gnu.org ([2001:4830:134:3::10]:53646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gM9a5-000792-VF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gM9Zy-0000fu-S1
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:36:32 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
References: <cover.1541595424.git.berto@igalia.com>
	<d213fb4eb326353eccde0ea1c5a05bba2da706e0.1541595424.git.berto@igalia.com>
	<62cb7e48-9120-ace4-cd84-f462b3100251@redhat.com>
Date: Mon, 12 Nov 2018 11:36:23 +0100
Message-ID: <w51k1libn14.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 14/15] block: Remove assertions from
 update_flags_from_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Sun 11 Nov 2018 10:01:05 PM CET, Max Reitz wrote:
>> -    assert(qemu_opt_find(opts, BDRV_OPT_CACHE_DIRECT));
>>      if (qemu_opt_get_bool_del(opts, BDRV_OPT_CACHE_DIRECT, false)) {
>>          *flags |= BDRV_O_NOCACHE;
>>      }
>>  
>>      *flags &= ~BDRV_O_RDWR;
>
> Unrelated to this patch, but isn't BDRV_O_AUTO_RDONLY missing here?

I forgot to mention, but I think you're right here. I'll include this
fix in the next version of the series.

Berto

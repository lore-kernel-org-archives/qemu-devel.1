Received: from eggs.gnu.org ([2001:4830:134:3::10]:47700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evqEp-0001JY-7w
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evqEo-0006y5-9v
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:09:35 -0400
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
	<152096780751.39.15281812348627104231@71c20359a636>
	<DB6PR0801MB20563C8F2FAF24F77D3101A5C1D20@DB6PR0801MB2056.eurprd08.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abfda9ee-e7b7-39a5-f1ba-f825efd5007f@redhat.com>
Date: Tue, 13 Mar 2018 15:09:02 -0500
MIME-Version: 1.0
In-Reply-To: <DB6PR0801MB20563C8F2FAF24F77D3101A5C1D20@DB6PR0801MB2056.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 00/13] Dirty bitmaps postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "famz@redhat.com" <famz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "lirans@il.ibm.com" <lirans@il.ibm.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, Denis Lunev <den@virtuozzo.com>, Su Hang <suhang16@mails.ucas.ac.cn>Paolo Bonzini <pbonzini@redhat.com>

On 03/13/2018 03:01 PM, Vladimir Sementsov-Ogievskiy wrote:
> It looks like a bug in a recent commit to checkpatch. It don't support do { } while
> 

> Checking PATCH 11/13: migration: add postcopy migration of dirty bitmaps...
> ERROR: braces {} are necessary for all arms of this statement
> #737: FILE: migration/block-dirty-bitmap.c:690:
> +    } while (!(s.flags & DIRTY_BITMAP_MIG_FLAG_EOS));
> [...]
> 

Indeed, this is a regression in Su Hang's commit 2b9aef6f.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

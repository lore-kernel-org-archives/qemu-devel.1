Received: from eggs.gnu.org ([2001:4830:134:3::10]:52464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3P9o-0007aA-Pm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3P9j-0006E4-UU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3P9j-0006Dk-OA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:47:03 -0400
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d45d6e46-32fa-a4f2-53cb-680ca773d609@redhat.com>
Date: Wed, 26 Apr 2017 17:46:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170424164244.GJ2362@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yang Hongyang <yanghongyang@huawei.com>
Cc: quintela@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Huangzhichao <huangzhichao@huawei.com>, wangxinxin.wang@huawei.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>



On 24/04/2017 18:42, Dr. David Alan Gilbert wrote:
> I suppose there's a few questions;
>   a) Do we actually need the BQL - and if so why
>   b) What actually takes 13s?  It's probably worth figuring
> out where it goes,  the whole bitmap is only 1GB isn't it
> even on a 4TB machine, and even the simplest way to fill
> that takes way less than 13s.

It's more likely that it is the migration_bitmap_sync immediately after
that.

I think it is possible to move migration_bitmap_sync outside BQL.  It
should be simpler to evaluate that after Juan's cleanups go in.

Paolo

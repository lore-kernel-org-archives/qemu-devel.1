Received: from eggs.gnu.org ([2001:4830:134:3::10]:34279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpcS9-00087x-Vn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpcS7-0006wc-Bf
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpcS7-0006ve-5Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39530821C7
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 15:41:18 +0000 (UTC)
References: <cover.1504696921.git.mprivozn@redhat.com>
	<874lsfvo5j.fsf@dusky.pond.sub.org> <20170906153709.GQ20914@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <081be856-0e3d-9b21-6b19-34c88823f730@redhat.com>
Date: Wed, 6 Sep 2017 17:41:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170906153709.GQ20914@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/3] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 09/06/2017 05:37 PM, Richard W.M. Jones wrote:
> On Wed, Sep 06, 2017 at 05:32:08PM +0200, Markus Armbruster wrote:
>> Series
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> Perhaps Rich would like to have a look, too.
> 
> I looked at them and they seemed OK but I didn't review them.
> 
> I also added this comment on the bug which maybe relevant,
> maybe not ...
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1447169#c4
> 
>   "Not that it matters, but the real hardware was built into the
>    southbridge and so not hotpluggable.
> 
>    Do you know what happens (or should happen) if the guest kernel
>    loads the i6300esb driver with nowayout=1 and the hardware is
>    unplugged?  My reading of the driver says that this will not break
>    or crash, although it probably won't work as the guest user
>    expects.  You can tell from the qemu side if the guest selected
>    nowayout because ESB_WDT_LOCK is written to the ESB_LOCK_REG
>    register.
> 
>    Anyway, this may not matter."

I've tested this and the guest continued running happily after I've
detached the watchdog.

Michal

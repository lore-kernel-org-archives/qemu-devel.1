Received: from eggs.gnu.org ([209.51.188.92]:49317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4QV-00074W-Su
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4QS-0000ql-5P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hB4QQ-0000oa-8v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:25:02 -0400
From: Bandan Das <bsd@redhat.com>
References: <20190328173722.26465-1-bsd@redhat.com>
	<20190328173722.26465-2-bsd@redhat.com>
	<20190401065620.qca6h5qxxapdoyq5@sirius.home.kraxel.org>
Date: Mon, 01 Apr 2019 17:19:23 -0400
In-Reply-To: <20190401065620.qca6h5qxxapdoyq5@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Mon, 1 Apr 2019 08:56:20 +0200")
Message-ID: <jpg7ecdh19g.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2 v3] usb-mtp: remove
 usb_mtp_object_free_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Thu, Mar 28, 2019 at 01:37:21PM -0400, Bandan Das wrote:
>> This function is used in the delete path only and can
>> be replaced by a call to usb_mtp_object_free.
>> 
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Bandan Das <bsd@redhat.com>
>
> Tried to cherry-pick this one for 4.0 (I think we should leave 2/2 to
> 4.1 at this point).  Doesn't apply to master, seems to depend on a
> not-yet merged patch.  Can you re-post this one and the depending patch
> please?
>

Posted a v4, message-id: <20190401211712.19012-1-bsd@redhat.com>
I forgot to skip 3/3, but I will remember to post it again as a single
patch if it's easier for you that way.

Bandan

> thanks,
>   Gerd

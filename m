Received: from eggs.gnu.org ([2001:4830:134:3::10]:58340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMzwf-0007op-Ii
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMzwe-0001oy-KA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:54:33 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMzwe-0001oq-E1
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 12:54:32 -0400
Received: by mail-wm0-x234.google.com with SMTP id m125so82352801wmm.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 09:54:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8760fsatis.fsf@secure.mitica>
References: <20170616160658.32290-1-famz@redhat.com>
	<8760fsatis.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2017 17:54:10 +0100
Message-ID: <CAFEAcA-g8Ofu_WZjLBGb70qnXfdyM+DUqXQHf0-HixaDWmmy=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Fix race of image locking
 between src and dst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>

On 19 June 2017 at 16:26, Juan Quintela <quintela@redhat.com> wrote:
> Fam Zheng <famz@redhat.com> wrote:
>> Previously, dst side will immediately try to lock the write byte upon
>> receiving QEMU_VM_EOF, but at src side, bdrv_inactivate_all() is only
>> done after sending it. If the src host is under load, dst may fail to
>> acquire the lock due to racing with the src unlocking it.
>>
>> Fix this by hoisting the bdrv_inactivate_all() operation before
>> QEMU_VM_EOF.
>>
>> N.B. A further improvement could possibly be done to cleanly handover
>> locks between src and dst, so that there is no window where a third QEMU
>> could steal the locks and prevent src and dst from running.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Applied to master, thanks all.

-- PMM

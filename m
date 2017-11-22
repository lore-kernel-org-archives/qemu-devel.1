Received: from eggs.gnu.org ([2001:4830:134:3::10]:59378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHTmi-0000LK-6h
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eHTmf-0000wg-3f
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:05:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eHTme-0000wX-Ti
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:05:41 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_qh+mxGe9AjxDCVEnyPeKfg511HOAhF7H+jOBg2fLuhQ@mail.gmail.com>
	(Peter Maydell's message of "Wed, 22 Nov 2017 12:01:55 +0000")
References: <20171122084157.11480-1-quintela@redhat.com>
	<CAFEAcA_qh+mxGe9AjxDCVEnyPeKfg511HOAhF7H+jOBg2fLuhQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Nov 2017 13:05:36 +0100
Message-ID: <877euiplgv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 November 2017 at 08:41, Juan Quintela <quintela@redhat.com> wrote:
>> This commit started use tb_unlock() and tlb_set_dirty() on non TCG
>> code.  Add the function as stubs.
>>
>> commit 27266271977c5a30f2f7d493e042be1897827bdd
>> Author: Peter Maydell <peter.maydell@linaro.org>
>> Date:   Mon Nov 20 18:08:27 2017 +0000
>>
>>     exec.c: Factor out before/after actions for notdirty memory writes
>>     ....
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Subject seems confusing -- do you mean "without TCG" ?

yeap, sorry about that.

>
> thanks
> -- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMe3-0003Yu-97
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezMe2-0001T7-ID
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:22:11 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezMe2-0001St-C1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 09:22:10 -0400
Received: by mail-ot0-x243.google.com with SMTP id r30-v6so13193008otr.2
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 06:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323130117.GP32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-21-peterx@redhat.com>
	<1bd08e1d-b6ff-6b39-e053-599bddd1a208@de.ibm.com>
	<20180323122538.GN32362@xz-mi>
	<332a9ef5-549a-d329-ec5e-d68609b1fbe1@de.ibm.com>
	<20180323130117.GP32362@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Mar 2018 13:21:49 +0000
Message-ID: <CAFEAcA86ruK6QhkUj_YnjGYkXEr0yonoT7iWj9v9JoYXwo7ddQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 20/23] monitor: enable IO thread for
 (qmp & !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Auger Eric <eric.auger@redhat.com>

On 23 March 2018 at 13:01, Peter Xu <peterx@redhat.com> wrote:
> On Fri, Mar 23, 2018 at 01:44:54PM +0100, Christian Borntraeger wrote:
>>
>>
>> On 03/23/2018 01:25 PM, Peter Xu wrote:
>> > On Fri, Mar 23, 2018 at 01:10:51PM +0100, Christian Borntraeger wrote:
>> >> As Max Reitz said, this breaks several qemu iotests. I can reproduce that on s390
>> >> e.g. with ./check -qcow2 030 in the qemu-iotest.
>> >>
>> >> Why was this merged?
>> >
>> > My fault.  Sorry.  I should have done iotests before submission.
>> >
>> > Now I'm trying to fix those iotest issues.
>> >
>> > I'm not extremely familiar with block, so the progress is a bit slow,
>> > but I'll do it asap (though I'll possibly need some help from the
>> > block team, since there are some not-easy ones for me).
>>
>> As this patch also seems to trigger something else for Eric, can we revert this
>> patch for the time being and re-apply as soon as we have solutions for the issues?
>>
>> After all a hard hang in the iotest can break CI environments (as you run into timeouts).
>
> I'm fine with it if it helps.

OK. I'm running a revert of commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1
through my buildtests and will push it to master assuming it passes.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1copRH-0003JL-Tk
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1copRG-0001QQ-Oh
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:48:55 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1copRG-0001QH-IX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:48:54 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n11so12590414wma.0
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 03:48:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <73b74fc6-033d-de06-5e00-50868f6862a6@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<0f504dd2-235b-7ada-98b2-e0ccbd376fa7@redhat.com>
	<7e86352b-add7-7b73-4e6b-08016b3e7a5d@redhat.com>
	<20170317101257.GB8050@redhat.com>
	<CAFEAcA9vYs2aCaDON6FDBzG9P8Vo73e3o1NfC=W4FbGQPSVapg@mail.gmail.com>
	<73b74fc6-033d-de06-5e00-50868f6862a6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 10:48:32 +0000
Message-ID: <CAFEAcA8Ho-9Kah7xb36E7TtKdmZ=_UZtDG5xYTXJ-ZMW=U_ABw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Sean Bruno <sbruno@freebsd.org>

On 17 March 2017 at 10:30, Thomas Huth <thuth@redhat.com> wrote:
> On 17.03.2017 11:15, Peter Maydell wrote:
>> On 17 March 2017 at 10:12, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> In the mail thread two months back Sean Bruno did suggest he might like
>>> to just start over with bsd-user:
>>>
>>>   https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg00171.html
>>>
>>> So perhaps someone should just ping him to see if he objects to us
>>> deleting bsd-usr now (on off chance he's got patches nearly ready to
>>> fix it)
>>
>> It's because Sean is (on-and-off) still around that I'm not
>> very inclined to delete bsd-user. We actually have somebody
>> who cares about the code, which means we should move it into
>> tier 1, not dump it into tier 3 and delete.
>
> OK, fair, but even Sean was suggesting to purge the old code first ...
> so maybe we should just do so and start with a new bsd-user folder when
> he is ready?

That's not so great for the other BSDs, and I'm not convinced that
"here's a huge pile of code" is going to be easier to review than
the incremental changes.

(It's the "what's easiest to review" part I think is most important.)

thanks
-- PMM

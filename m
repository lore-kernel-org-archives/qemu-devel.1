Received: from eggs.gnu.org ([2001:4830:134:3::10]:44911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUTG-0000Jd-2k
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnUTF-0006Ug-7z
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:13:26 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnUTF-0006UN-1S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 14:13:25 -0400
Received: by mail-wm0-x230.google.com with SMTP id n11so46945474wma.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 11:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170103155347.GF14707@stefanha-x1.localdomain>
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
	<20170103155347.GF14707@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 19:13:02 +0100
Message-ID: <CAFEAcA8mfjHvrM=92QJJ=Q0gSg0SS7jBZGyND1Lbh-Of44EZpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 3 January 2017 at 16:53, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
>> Considering that Easter is on April 16th, we'd probably want to have the
>> release before that date even in case of a slip.
>>
>> On the other hand, the Christmas / New Year break here means that we'll
>> have to make the development time 1-2 week shorter in practice.
>>
>> 2016-02-21     2.9 soft freeze
>> 2016-03-07     hard freeze / rc0
>> 2016-03-28     rc3 (+3 weeks)
>> 2016-04-04     rc4 or release
>> 2016-04-11     release (if rc4)

[these should all have been 2017, heh]

>> One possibility is to make soft freeze happen a few days later.
>> Peter/Stefan, how did the experiment go with the new rules for soft
>> freeze?  Is it worth repeating it for 2.9 and would it make sense to
>> shorten soft freeze given the new rules?
>
> I would shorten the soft freeze by 1 week.

I hadn't noticed that this meant that we had a 1 week softfreeze
period. This completely failed, partly because I didn't think
we'd gone down to just 1 week, partly because I was away at a
conference last week when rc0 was theoretically due, and
partly because of the enormous pile of merges that needed
to be done -- I only finished the merge work on the Saturday.

I plan to tag rc0 tomorrow (the 14th) and push all the other
dates out by a week accordingly.

thanks
-- PMM

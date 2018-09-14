Received: from eggs.gnu.org ([2001:4830:134:3::10]:35106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0psR-0007jc-SP
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0psM-0006Ns-Sc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0psM-0006M2-Ju
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 11:19:18 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081950.3228.68987.stgit@pasha-VirtualBox>
	<f7b7533c-a9db-d660-4981-678ae5143950@redhat.com>
	<002101d44bee$9edf9720$dc9ec560$@ru>
	<cccee26e-80fc-605a-43ef-b5e116912720@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb23ae44-1634-d608-fa1e-92511ffe6d9e@redhat.com>
Date: Fri, 14 Sep 2018 17:19:11 +0200
MIME-Version: 1.0
In-Reply-To: <cccee26e-80fc-605a-43ef-b5e116912720@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 21/25] replay: replay BH for IDE trim
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 14/09/2018 16:00, John Snow wrote:
>> Maybe not. We can hardly analyze all peripheral devices code and fix all the calls.
>> But I think we can improve that patch and at least look through ide core to fix other calls.
>>
>> Pavel Dovgalyuk
>>
> It just seems odd that if you're working on a replay mechanism that
> requires you to intercept my QEMU API calls that you're only changing a
> trim callback.

You need it only here because the block layer is already calling
replay_bh_schedule_event (actually replay_bh_schedule_oneshot_event
after patch 22 of this series) on reads and writes.

Paolo

> I'd kind of expect that you don't need to intercept any, unless these
> are legacy calls that I shouldn't be making at all and you have a more
> generic intercept somewhere deeper in the codebase.
> 
> In that case, I really ought to hustle off of my use of legacy calls.
> 
> What are the criteria for things you need to intercept/wrap?

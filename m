Received: from eggs.gnu.org ([2001:4830:134:3::10]:36334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0RwF-0002cs-HO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0RwC-0005gP-C9
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:45:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0RwC-0005fh-45
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:45:40 -0400
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081956.3228.17903.stgit@pasha-VirtualBox>
	<b0deae03-cfdf-85c0-4262-884a1e07e5a3@redhat.com>
	<000901d44b52$c1bdcd30$45396790$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <988eaaac-f2cc-69a7-c4c4-cdf63afd65e8@redhat.com>
Date: Thu, 13 Sep 2018 15:45:32 +0200
MIME-Version: 1.0
In-Reply-To: <000901d44b52$c1bdcd30$45396790$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 22/25] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

On 13/09/2018 13:13, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 12/09/2018 10:19, Pavel Dovgalyuk wrote:
>>> + uint64_t id = replay_get_current_step();
>>> + replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
>>
>> Why does it need an id, while REPLAY_ASYNC_EVENT_BH does not?
> 
> Because _oneshot() function takes only context and callback,
> and BH object is created inside that function.
> Therefore to use the normal bh scheduling events we have to refactor
> block code - add bh creation, scheduling, and freeing.

No, I'm asking only why the id is 0 for REPLAY_ASYNC_EVENT_BH and
replay_get_current_step() for REPLAY_ASYNC_EVENT_BH_ONESHOT.

Thanks,

Paolo

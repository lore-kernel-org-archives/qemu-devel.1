Received: from eggs.gnu.org ([2001:4830:134:3::10]:37400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWKeR-0004cH-9A
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fWKeQ-0004jp-Hx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:54:51 -0400
References: <1529326004-32239-1-git-send-email-eric.auger@redhat.com>
	<1529326004-32239-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9X2ASVtcG0Nw5_Bx-rn2+M5hW7g3+QhZvhASYn9aV+SA@mail.gmail.com>
	<418f7043-8f4f-3b04-f771-b9e392c64d00@redhat.com>
	<CAFEAcA_Kq1ABz1b03vHQQ_wO2G+HPOe6DkYjdA9mYAvzvowREQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d10437f0-1c39-48b8-243b-49c9f251e9d6@redhat.com>
Date: Fri, 22 Jun 2018 13:54:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Kq1ABz1b03vHQQ_wO2G+HPOe6DkYjdA9mYAvzvowREQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/arm/virt: Silence dtc /memory
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, ">" <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,

On 06/22/2018 01:52 PM, Peter Maydell wrote:
> On 22 June 2018 at 12:48, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 06/22/2018 01:02 PM, Peter Maydell wrote:
>>> This removes all nodes named "memory" or "memory@*", rather than
>>> just the ones in the root, right?
>>
>> correct
>>
>>  Is that definitely what we want to
>>> do? The old code only deleted /memory, and the comment implies
>>> that we only look in the root.
>>>
>>> (I'm wondering if there are DTs that use memory nodes for random
>>> odd things other than system memory...)
>>
>> I don't know the exact use case. Removing the exact /memory@40000000
>> node is simpler and does not require 2/3 I think. So if this is what is
>> expected I can stick to that node.
> 
> Well, I think we should remove the wildcard /memory@*, but not
> /foo/bar/memory@xyz and other things that aren't in the root...
OK

Thanks

Eric
> 
> thanks
> -- PMM
> 

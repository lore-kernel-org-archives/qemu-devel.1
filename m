Received: from eggs.gnu.org ([2001:4830:134:3::10]:37016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKco-0003Rf-Ai
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKcn-00041L-ME
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:53:10 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:35820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWKcn-000412-H0
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:53:09 -0400
Received: by mail-oi0-x234.google.com with SMTP id e8-v6so5901414oii.2
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:53:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <418f7043-8f4f-3b04-f771-b9e392c64d00@redhat.com>
References: <1529326004-32239-1-git-send-email-eric.auger@redhat.com>
	<1529326004-32239-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9X2ASVtcG0Nw5_Bx-rn2+M5hW7g3+QhZvhASYn9aV+SA@mail.gmail.com>
	<418f7043-8f4f-3b04-f771-b9e392c64d00@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 12:52:48 +0100
Message-ID: <CAFEAcA_Kq1ABz1b03vHQQ_wO2G+HPOe6DkYjdA9mYAvzvowREQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, ">" <crosthwaite.peter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>

On 22 June 2018 at 12:48, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 06/22/2018 01:02 PM, Peter Maydell wrote:
>> This removes all nodes named "memory" or "memory@*", rather than
>> just the ones in the root, right?
>
> correct
>
>  Is that definitely what we want to
>> do? The old code only deleted /memory, and the comment implies
>> that we only look in the root.
>>
>> (I'm wondering if there are DTs that use memory nodes for random
>> odd things other than system memory...)
>
> I don't know the exact use case. Removing the exact /memory@40000000
> node is simpler and does not require 2/3 I think. So if this is what is
> expected I can stick to that node.

Well, I think we should remove the wildcard /memory@*, but not
/foo/bar/memory@xyz and other things that aren't in the root...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3K2-0005z0-2i
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fn3K1-0002hC-BC
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:50:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA8O-SL4Bg4ar3QLLFCPcF8A7W7mRu4D8bbXvJkFUsXTKQ@mail.gmail.com>
	(Peter Maydell's message of "Tue, 7 Aug 2018 15:45:09 +0100")
References: <20180806123445.1459-1-peter.maydell@linaro.org>
	<20180806123445.1459-4-peter.maydell@linaro.org>
	<87600m2qb2.fsf@trasno.org>
	<CAFEAcA8O-SL4Bg4ar3QLLFCPcF8A7W7mRu4D8bbXvJkFUsXTKQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 07 Aug 2018 16:50:42 +0200
Message-ID: <87sh3q1b99.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 v2 3/5] target/arm: Add dummy
 needed functions to M profile vmstate subsections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 August 2018 at 15:40, Juan Quintela <quintela@redhat.com> wrote:
>> But having 3 subsections with the same needed function ... we could have
>> a single subsection.
>
> I wanted to keep the change small here since we're very
> late in the release cycle, so I kept it to a change
> that restores the intent of the code, ie "always transfer
> the subsection".

ok with minimizing changes.  But I can't understand why that is going
that way.  Seeing this, I am making a patch that at registration time
check that we are not doing something stupid, like not having needed
function, bad names, whatever.

Thanks.

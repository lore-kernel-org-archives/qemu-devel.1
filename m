Received: from eggs.gnu.org ([2001:4830:134:3::10]:55982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXrYh-0007YE-KJ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fXrYg-0006Fl-SP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:15:15 -0400
References: <1529673765-16627-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9Pg3C+XD7WuLyNr5RfifRCvXB6t01YuLiK9Cs15v-Dpg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a49d3e03-a6aa-b627-c2e3-2b3c4bddf74d@redhat.com>
Date: Tue, 26 Jun 2018 19:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Pg3C+XD7WuLyNr5RfifRCvXB6t01YuLiK9Cs15v-Dpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] ARM virt: Silence dtc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>

Hi Peter,

On 06/26/2018 07:06 PM, Peter Maydell wrote:
> On 22 June 2018 at 14:22, Eric Auger <eric.auger@redhat.com> wrote:
>> When running dtc on the guest /proc/device-tree, we get the
>> following warnings: "Warning (unit_address_vs_reg): Node <name>
>> has a reg or ranges property, but no unit name", with name:
>> /intc, /intc/its, /intc/v2m, /memory.
>>
>> This series removes those warnings by adding the unit address to
>> the corresponding node names.
> 
> This didn't apply to my target-arm.next tree. Once I've
> applied my on-list arm pullreq to master, could you
> rebase it, please?

Sure

Thanks

Eric
> 
> thanks
> -- PMM
> 

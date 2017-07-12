Received: from eggs.gnu.org ([2001:4830:134:3::10]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVEyl-0003WC-JZ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVEyg-0008Ax-PC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:34:47 -0400
References: <CAFEAcA_HPtBhES_9L1KZzJTDJRpxD=0Ux-OyC3BV2UDNKZg2hg@mail.gmail.com>
	<40961524-561e-aa31-b043-7b8ae9203b7c@suse.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7bb17d85-a21b-d890-03cc-18f56b785361@redhat.com>
Date: Wed, 12 Jul 2017 12:34:35 +0200
MIME-Version: 1.0
In-Reply-To: <40961524-561e-aa31-b043-7b8ae9203b7c@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] should we update QEMU's u-boot submodule and
 binary?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 11.07.2017 20:22, Alexander Graf wrote:
> 
> On 11.07.17 19:43, Peter Maydell wrote:
>> Hi; I just noticed that our u-boot submodule is still stuck on
>> a commit from 2014 when it was first added to QEMU. Should we
>> move this forward to some more recent u-boot release?
>>
>> I think we only use this for our ppc e500 rom...
> 
> It probably makes sense to update the e500 rom and bump the submodule to
> the latest U-Boot release along the way, yes.
> 
> U-Boot 2017.07 just got released, so now is quite a good point in time
> to do so.

I think we should rather update the submodule to commit 79c884d7e4 since
that is the level that is used for the pc-bios/u-boot.e500 binary (see
http://git.qemu.org/?p=qemu.git;a=commitdiff;h=d4574435a6530bbd96ae13 ).

The problematic mv_gen_reg.h is also not part of that commit level anymore.

Alex, could you please send a patch for the update? Or shall I prepare one?

 Thomas

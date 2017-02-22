Received: from eggs.gnu.org ([2001:4830:134:3::10]:59229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cgXLb-0001ul-Gs
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1cgXLa-0004Tx-OR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:52:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170222123158.GJ4112@noname.str.redhat.com>
References: <20170217005127.21010-1-nirsof@gmail.com>
	<20170222123158.GJ4112@noname.str.redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Wed, 22 Feb 2017 15:52:43 +0200
Message-ID: <CAMr-obvLzLc2n6TdpjMcidUeRaY9GyL1a2c4K-nUsMOM8Scp4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img raw preallocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Wed, Feb 22, 2017 at 2:31 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 17.02.2017 um 01:51 hat Nir Soffer geschrieben:
>> This series add missing tests for raw image preallocation, refine
>> preallocation=full and improve documentation.
>>
>> Create on top of the commit   10ddfe7b6044 (qemu-img: Do not truncate
>> before preallocation) from Kevin block branch.
>
> Thanks, applied to the block branch.
>
> I changed the commit message of patch 2 so that it doesn't mention the
> commit ID. This is because the commit ID is only stable once the commit
> has made it into master. I also added a few words ("...so don't do that
> here") to the comment in patch 3 because outside the context of the
> patch, talking about a truncation seemed weird when there is no
> truncation happening. I hope you're okay with these changes.

Looks fine, thanks!

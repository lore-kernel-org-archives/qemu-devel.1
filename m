Received: from eggs.gnu.org ([2001:4830:134:3::10]:60868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xk-00065l-PT
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xj-00025S-O0
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:16 -0400
Received: from [59.151.112.132] (port=38342 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cw2xj-00024m-C8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 04:40:15 -0400
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161238.366ce6a7@t450s.home> <58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
	<20170328205513.21b97381@t450s.home>
	<20170330205823-mutt-send-email-mst@kernel.org>
	<20170330121652.2ac8fa62@t450s.home> <58E4B0C9.50109@cn.fujitsu.com>
	<20170406005028-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58E6011F.6030002@cn.fujitsu.com>
Date: Thu, 6 Apr 2017 16:49:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170406005028-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com



On 04/06/2017 05:56 AM, Michael S. Tsirkin wrote:
> On Wed, Apr 05, 2017 at 04:54:33PM +0800, Cao jin wrote:
>> Apparently, I don't have experience to induce non-fatal error, device
>> error is more of a chance related with the environment(temperature,
>> humidity, etc) as I understand.
> 
> I'm not sure how to interpret this statement. I think what Alex is
> saying is simply that patches should include some justification. They
> make changes but what are they improving?
> For example:
> 
> 	I tested device ABC in conditions DEF. Without a patch VM
> 	stops. With the patches applied VM recovers and proceeds to
> 	use the device normally.
> 
> is one reasonable justification imho.
> 

Got it. But unfortunately, until now, I haven't seen a VM stop caused by
a real device non-fatal error during device assignment(Only saw real
fatal errors after start VM).
On one side, AER error could occur theoretically; on the other side,
seldom people have seen a VM stop caused by AER. Now I am asked that do
I have a real evidence or scenario to prove that this patchset is really
useful? I don't, and we all know it is hard to trigger a real hardware
error, so, seems I am pushed into the corner.  I guess these questions
also apply for AER driver's author, if the scenario is easy to
reproduce, there is no need to write aer_inject to fake errors.

-- 
Sincerely,
Cao jin

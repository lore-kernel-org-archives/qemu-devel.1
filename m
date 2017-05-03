Received: from eggs.gnu.org ([2001:4830:134:3::10]:60185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPg-0005UA-8u
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPf-0006az-FF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:28 -0400
Received: from [59.151.112.132] (port=58394 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oPf-0006ah-2l
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:09:27 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<6824abf3c4e5b865de1799c302f60e8055c8d3dc.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<20170427162055.GB30599@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <37e47842-e163-8543-34be-bf23d20d9f1c@cn.fujitsu.com>
Date: Wed, 3 May 2017 15:02:45 +0800
MIME-Version: 1.0
In-Reply-To: <20170427162055.GB30599@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] net/socket: Convert the
 non-blocking connection mechanism to QIOchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

Hi, Daniel

On 04/28/2017 12:20 AM, Daniel P. Berrange wrote:
> On Wed, Apr 26, 2017 at 04:04:15PM +0800, Mao Zhongyi wrote:
>> Currently, socket connection in net is realized by an old
>> mechanism which is non-blocking.

[...]

             NULL);
>>      return 0;
>
> You've not saved a copy of the QIOChannelSocket poiinter here, and
> the net_socket_connected() method doesn't release the reference
> either. So htere is a memory leak. Of course if you relesae the
> reference in net_socket_connected(), then you need to dup() the
> file descriptor you're borrowing.
>
> Regards,
> Daniel


Sorry for delay, thanks for your detailed reply.
I see, will fix it in the next version.

Thanks
Mao
>

Received: from eggs.gnu.org ([208.118.235.92]:56817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1doi2I-0005ba-1b
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 23:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1doi1K-0005n3-9C
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 23:26:54 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25619
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1doi1J-0005gS-MU
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 23:25:54 -0400
References: <cover.1499329674.git.maozy.fnst@cn.fujitsu.com>
	<307d18b6-54e6-e3e0-541e-9ad053955b84@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <12d7263d-5903-119c-c901-c6252ff044b3@cn.fujitsu.com>
Date: Mon, 4 Sep 2017 11:23:44 +0800
MIME-Version: 1.0
In-Reply-To: <307d18b6-54e6-e3e0-541e-9ad053955b84@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 0/4] Improve error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com

On 09/04/2017 11:09 AM, Jason Wang wrote:
>
>
> On 2017年07月06日 16:47, Mao Zhongyi wrote:
>> v8:
>> * PATCH 02 & 04
>>    -resetting the error message for the user to read.   [Markus Armbruster]
>>    -fix the indentation and commit message.  [Markus Armbruster]
>>    v7:
>> * PATCH 01
>>    -fix the error message.    [Daniel P. Berrange]
>>    -adjust the indentation problem.    [Eric Blake]
>> * PATCH 03
>>    -print a generic message when gethostbyname() failed in parse_host_port(),
>>     drop the misleading ": unkonwn host" part.    [Markus Armbruster]
>>
>> v6:
>> * PATCH 02
>>    -rename the subject
>>    -drop the "qemu: error: " prefix.
>>    -correct inappropriate error information settings.
>> * PATCH 03,04
>>    -correct inappropriate error information settings.    [Markus Armbruster]
>>
>> v5:
>> * PATCH 01 make the commit message more exact about the actual function.    [Markus Armbruster]
>> * PATCH 02, 03, 04 still retains the original function, but specific
>>             content and order of each patch has been adjusted substantially,
>>             so that ensure each patch is a completed fix.    [Markus Armbruster]
>>
>> v4:
>> * PATCH 01 is redoing previous patch 1, replace the fprintf() with error_report()
>>              in the 'default' case of net_socket_fd_init() [Markus Armbruster]
>>
>> v3:
>> * PATCH 01 is suggested by Markus and Daniel that removes the dubious 'default' case
>>             in the net_socket_fd_init(). Jason agreed.
>> * PATCH 02 is redoing previous patch 4.
>> * PATCH 04 is redoing previous patch 2, improves sort of error messages.
>>
>> v2:
>> * PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
>>             in the function called by net_socket_*_init() to Error. Also add many error
>>             handling information.
>> * PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init()
>>             use the function such as fprintf, perror to report an error message. Convert it
>>             to Error.
>> * PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
>>             error when it fails.
>>
>> Cc: jasowang@redhat.com
>> Cc: armbru@redhat.com
>> Cc: berrange@redhat.com
>> Cc: kraxel@redhat.com
>> Cc: pbonzini@redhat.com
>> Cc: eblake@redhat.com
>>
>> Mao Zhongyi (4):
>>    net/socket: Don't treat odd socket type as SOCK_STREAM
>>    net/socket: Convert several helper functions to Error
>>    net/net: Convert parse_host_port() to Error
>>    net/socket: Improve -net socket error reporting
>>
>>   include/qemu/sockets.h |   3 +-
>>   net/net.c              |  22 +++++--
>>   net/socket.c           | 153 ++++++++++++++++++++++++++++---------------------
>>   3 files changed, 106 insertions(+), 72 deletions(-)
>>
>
> Hi:
>
> Want to apply this, but looks like it does not apply cleanly, could you please send a new version?
>
> Thanks

OK, I will.

Thanks,
Mao

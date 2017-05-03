Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oYo-0000Bv-MR
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oYl-0001xW-IE
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:18:54 -0400
Received: from [59.151.112.132] (port=30181 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1d5oYl-0001xK-6C
	for qemu-devel@nongnu.org; Wed, 03 May 2017 03:18:51 -0400
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
	<87o9vhu8av.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <1d9ca059-5f68-b677-4faa-8689c37c5f57@cn.fujitsu.com>
Date: Wed, 3 May 2017 15:12:10 +0800
MIME-Version: 1.0
In-Reply-To: <87o9vhu8av.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Convert non-blocking connect and
 fix its error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: pbonzini@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com



On 04/28/2017 12:25 AM, Markus Armbruster wrote:
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:
>
>> v2:
>> * PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
>>   in the function called by net_socket_*_init() to Error. Also add many error handling
>>   information.
>> * PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init()
>>   use the function such as fprintf, perror to report an error message. Convert it to Error.
>> * PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
>>   error when it fails.
>
> Needs a bit more work.  I'll continue review with v3.

Hi, Markus,

Thanks for your kind reply very much.
I will fix it in the v3 as soon as.

Thanks
Mao
>
>
>
>
>

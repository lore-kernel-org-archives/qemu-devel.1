Received: from eggs.gnu.org ([2001:4830:134:3::10]:51002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmVt-0006Cu-Re
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmVq-0000t9-P3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:46:41 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1etmVq-0000sx-DQ
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:46:38 -0500
References: <cover.1519961667.git.jbaron@akamai.com>
	<864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
	<20180302195256-mutt-send-email-mst@kernel.org>
	<a44eda0c-7f5b-ad31-f357-730fb62afb77@akamai.com>
	<20180306201354-mutt-send-email-mst@kernel.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <2477b427-76bb-93fa-507a-d37cca371a2a@akamai.com>
Date: Wed, 7 Mar 2018 22:46:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180306201354-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] eth: add speed and duplex definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org



On 03/06/2018 01:15 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 06, 2018 at 12:53:14PM -0500, Jason Baron wrote:
>>
>>
>> On 03/02/2018 12:54 PM, Michael S. Tsirkin wrote:
>>> On Thu, Mar 01, 2018 at 10:46:33PM -0500, Jason Baron wrote:
>>>> Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
>>>> and DUPLEX_FULL.
>>>>
>>>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: virtio-dev@lists.oasis-open.org
>>>> ---
>>>>  include/net/eth.h | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/include/net/eth.h b/include/net/eth.h
>>>> index 09054a5..9843678 100644
>>>> --- a/include/net/eth.h
>>>> +++ b/include/net/eth.h
>>>> @@ -417,4 +417,11 @@ bool
>>>>  eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
>>>>                     size_t ip6hdr_off, eth_ip6_hdr_info *info);
>>>>  
>>>> +/* ethtool defines - from linux/ethtool.h */
>>>> +#define SPEED_UNKNOWN           -1
>>>> +
>>>> +#define DUPLEX_HALF             0x00
>>>> +#define DUPLEX_FULL             0x01
>>>> +#define DUPLEX_UNKNOWN          0xff
>>>> +
>>>>  #endif
>>>
>>> While that's not a lot, I think we should import linux/ethtool.h into
>>> include/standard-headers/linux/ using scripts/update-linux-headers.sh
>>>
>>
>> Ok, I had started down that path, by including
>> include/uapi/linux/ethtool.h but that resulted in a few other headers -
>> kernel.h, sysinfo.h. And so it seemed like a lot of headers for only a
>> few lines. But I will re-visit it...
>>
>> Thanks,
>>
>> -Jason
> 
> I don't know why is sysinfo there. Want to try sending a patch to
> drop it from linux/kernel.h?
> 

Seems like this also ripples into glibc headers, if you look at:
/usr/include/x86_64-linux-gnu/sys/sysinfo.h. It also includes kernel.h
in order to get struct sysinfo. So that would need updating as well.

I've done a v2 that just pulls in sysinfo.h, it doesn't look too bad,
but let me know...

Thanks,

-Jason

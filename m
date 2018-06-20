Received: from eggs.gnu.org ([2001:4830:134:3::10]:58506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVRXn-0006Iy-Sg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fVRXk-0001MM-Pe
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:04:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:43655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fVRXk-0001Lh-Hd
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 21:04:16 -0400
References: <1529421657-14969-1-git-send-email-jingqi.liu@intel.com>
	<1529421657-14969-5-git-send-email-jingqi.liu@intel.com>
	<7b770927-f967-da61-cfd3-90b97f7d6e00@redhat.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <893e0c15-4f11-6ff5-b17b-7e4af1e8e975@intel.com>
Date: Wed, 20 Jun 2018 09:04:04 +0800
MIME-Version: 1.0
In-Reply-To: <7b770927-f967-da61-cfd3-90b97f7d6e00@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V1 RESEND 4/6] numa: Extend the
 command-line to provide memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, rth@twiddle.net, armbru@redhat.com
Cc: qemu-devel@nongnu.org


On 6/19/2018 11:39 PM, Eric Blake wrote:
> On 06/19/2018 10:20 AM, Liu Jingqi wrote:
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> ---
>>   numa.c          | 124 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   qapi/misc.json  |  92 ++++++++++++++++++++++++++++++++++++++++-
>>   qemu-options.hx |  28 ++++++++++++-
>>   3 files changed, 241 insertions(+), 3 deletions(-)
>>
>
>> +++ b/qapi/misc.json
>> @@ -2736,10 +2736,12 @@
>>   #
>>   # @cpu: property based CPU(s) to node mapping (Since: 2.10)
>>   #
>> +# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
>
> s/2.13/3.0/ through your series
>
>
>>   ##
>> +# @HmatLBMemoryHierarchy:
>> +#
>> +# The memory hierarchy in the System Locality Latency
>> +# and Bandwidth Information Structure of HMAT
>
> Worth including the expansion of the acronym HMAT for someone not 
> familiar with the term?
>
>> +#
>> +# @memory: the structure represents the memory performance
>> +#
>> +# @last-level: last level memory of memory side cached memory
>> +#
>> +# @1st-level: first level memory of memory side cached memory
>> +#
>> +# @2nd-level: second level memory of memory side cached memory
>> +#
>> +# @3rd-level: third level memory of memory side cached memory
>> +#
>> +# Since: 2.13
>> +##
>> +{ 'enum': 'HmatLBMemoryHierarchy',
>> +  'data': [ 'memory', 'last-level', '1st-level',
>> +            '2nd-level', '3rd-level' ] }
>
> enum values starting with a digit is permitted for legacy reasons, but 
> I'm reluctant to add more without good cause.  Can you spell these 
> 'first, second, third' instead of '1st, 2nd, 3rd'?
>
>> +
>> +##
>> +# @HmatLBDataType:
>> +#
>> +# Data type in the System Locality Latency
>> +# and Bandwidth Information Structure of HMAT
>> +#
>> +# @access-latency: access latency
>> +#
>> +# @read-latency: read latency
>> +#
>> +# @write-latency: write latency
>> +#
>> +# @access-bandwidth: access bandwitch
>
> s/witch/width/
>
> Also, in what units are these numbers?
>
Thanks for your review. I will modify them accordingly.
Jingqi

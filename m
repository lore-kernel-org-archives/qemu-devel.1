Received: from eggs.gnu.org ([209.51.188.92]:46922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwIFu-0006GV-Np
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwIFu-0005yw-4F
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:09:06 -0500
Date: Wed, 20 Feb 2019 11:08:38 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190220030838.GA25911@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190220003113.20746-1-richardw.yang@linux.intel.com>
	<20190220003113.20746-2-richardw.yang@linux.intel.com>
	<6b850e7b-78ed-b68e-6a46-9bdbb2962507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b850e7b-78ed-b68e-6a46-9bdbb2962507@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] CODING_STYLE: specify the indent
 rule for multiline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru, imammedo@redhat.com, philmd@redhat.com, peter.maydell@linaro.org

On Tue, Feb 19, 2019 at 09:02:34PM -0600, Eric Blake wrote:
>On 2/19/19 6:31 PM, Wei Yang wrote:
>> We didn't specify the indent rule for multiline code here, which may
>> misleading users. And in current code, the code use different rules.
>
>s/misleading/mislead/
>
>> 
>> Add this rule in CODING_STYLE to make sure this is clear to every one.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> 
>> ---
>> v2:
>>    * rephrase changelog suggested by Eric Blake
>>      - remove one redundant line
>>      - fix some awkward grammar
>>      - add { ; at the end of example
>> ---
>>  CODING_STYLE | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>
>> +
>> +    do_something(arg1, arg2
>> +                 arg3);
>
>Missing a comma after arg2. With that fixed,
>Reviewed-by: Eric Blake <eblake@redhat.com>

You are right.

>
>-- 
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3226
>Virtualization:  qemu.org | libvirt.org

-- 
Wei Yang
Help you, Help me

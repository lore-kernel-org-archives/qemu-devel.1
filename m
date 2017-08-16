Received: from eggs.gnu.org ([2001:4830:134:3::10]:44039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dhuEM-0002s5-DJ
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dhuEI-0008Dr-DA
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:03:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dhuEI-0008Db-2c
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:03:10 -0400
References: <1499783493-15911-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<e75d34d2-9fda-b514-3c22-655bb0c4b455@redhat.com>
	<274c8078-9de0-9a7a-1122-8124cdf0232c@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8d289429-4a37-0299-a872-874fa2d03ee2@redhat.com>
Date: Wed, 16 Aug 2017 11:03:02 +0200
MIME-Version: 1.0
In-Reply-To: <274c8078-9de0-9a7a-1122-8124cdf0232c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 08/16/17 10:33, Javier Martinez Canillas wrote:
> On 07/11/2017 09:36 PM, Laszlo Ersek wrote:
>> On 07/11/17 16:31, Stefan Berger wrote:
>>> This patch adds a description of the current TPM support in QEMU
>>> to the specs.
>>>
>>> Several public specs are referenced via their landing page on the
>>> trustedcomputinggroup.org website.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>
>>> ---
>>>
>>> v1->v2:
>>>   - fixed typos
>>>   - added command line for starting an x86_64 VM with TPM passthrough device
>>>   - added command lines for checks inside the VM
>>> ---
>>>  docs/specs/tpm.txt | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 124 insertions(+)
>>>  create mode 100644 docs/specs/tpm.txt
>>
>> Awesome, thank you very much!
>>
>> I think I noticed one typo in new text:
>>
>>> +#> dmesg | grep TCPA
>>> +[    0.000000] ACPI: TCP 0x0000000003FFD191C 000032 (v02 BOCHS  \
>>> +    BXPCTCPA 0000001 BXPC 00000001)
>>
>> I think the prefix here should be "ACPI: TCPA"; the letter "A" probably
>> fell victim to wrapping the line nicely.
>>
>> Not sure which maintainer will pick up the patch, but I think they can
>> fix up this typo on their end (assuming no other reviewer asks for v3).
>>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>
> 
> It seems this patch was never picked.

Michael, can you pick this up please? (Asking you just based on the
output of "scripts/get_maintainer.pl -f docs/specs".)

This is a documentation-only patch (about existing code), so it can't
regress anything. It's been on the list for more than one month, so I
think it should be fine for 2.10.

Otherwise, should Stefan repost it when 2.11 is open (or whatever
version number will come next)?

Thanks,
Laszlo

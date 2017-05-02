Received: from eggs.gnu.org ([2001:4830:134:3::10]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5S1x-0007Md-7H
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5S1s-0003v2-9Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:15:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:46439)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d5S1s-0003uY-0Q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 03:15:24 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-6-git-send-email-amarnath.valluri@intel.com>
	<e8ebc62a-63eb-c4c8-3f80-5e67d10b42ed@linux.vnet.ibm.com>
	<1614e603-2d69-296b-cc31-716e710937e3@redhat.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <a5adf92a-7f38-f3e6-3a98-49149f8c5402@intel.com>
Date: Tue, 2 May 2017 10:17:24 +0300
MIME-Version: 1.0
In-Reply-To: <1614e603-2d69-296b-cc31-716e710937e3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/9] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com



On 04/25/2017 09:59 PM, Eric Blake wrote:
> On 04/25/2017 01:51 PM, Stefan Berger wrote:
>
>>> +++ b/qapi-schema.json
>>> @@ -5140,6 +5140,16 @@
>>>    { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
>>>
>>>    ##
>>> +# @TPMOptions:
>>> +#
>>> +# Base type for TPM options
>>> +#
>>> +# Since: 2.10
>>> +##
>>> +{ 'struct': 'TPMOptions',
>>> +  'data': { } }
>>> +
>>> +##
>>>    # @TPMPassthroughOptions:
>>>    #
>>>    # Information about the TPM passthrough type
>>> @@ -5151,20 +5161,9 @@
>>>    #
>>>    # Since: 1.5
>>>    ##
>>> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
>>> -                                             '*cancel-path' : 'str'} }
>>> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
>>> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>>
>> I don't think that you can change it like this anymore since this is
>> part of the public interface.
> The change is backwards compatible; it doesn't break any existing QMP
> usage.  It's weird to have an empty base class, though.
This empty base class(TPMOptions) makes sense when its shared by more 
than one(Passthrough and Emulator) bakcends.

- Amarnath

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figpT-0000x5-IP
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1figpQ-0002HX-Kk
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:01:19 -0400
References: <1513111443-22790-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1513111443-22790-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<20180726053127.GF12001@umbus.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01b36c8d-eb01-63b1-73b2-4e43649b11de@redhat.com>
Date: Thu, 26 Jul 2018 09:01:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180726053127.GF12001@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 2/2] tpm_spapr: Support
 suspend and resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: lo1@us.ibm.com, qemu-devel@nongnu.org, James.Bottomley@hansenpartnership.com, qemu-ppc@nongnu.org, clg@kaod.org, marcandre.lureau@redhat.com

On 07/26/2018 12:31 AM, David Gibson wrote:
> 
> On Tue, Dec 12, 2017 at 03:44:03PM -0500, Stefan Berger wrote:
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/tpm/tpm_spapr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 57 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
>> index ef5e62d..0b8a424 100644
>> --- a/hw/tpm/tpm_spapr.c
>> +++ b/hw/tpm/tpm_spapr.c
>> @@ -248,9 +248,8 @@ static int tpm_spapr_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq_data)
>>       return H_SUCCESS;
>>   }
>>   
>> -static void tpm_spapr_request_completed(TPMIf *ti)
>> +static void _tpm_spapr_request_completed(SPAPRvTPMState *s)
> 
> Don't start identifiers with _, please, they're reserved by the
> standard library.

Technically, is is _[_A-Z] reserved by the implementation; use of _[a-z] 
is just fine for file-scoped identifiers, like this one. But it is still 
unusual in our codebase, and best avoided.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

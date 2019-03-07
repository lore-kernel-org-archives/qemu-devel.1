Received: from eggs.gnu.org ([209.51.188.92]:50490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1qMB-0003DC-7w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1qM9-0003I0-E4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:34:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1qM8-0003Hg-P4
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:34:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so16770873wrs.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:34:28 -0800 (PST)
References: <20190307052137.2780-1-david@gibson.dropbear.id.au>
	<ad194b40-507d-5de1-dc1c-23adb046fac7@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b4397a2-ac07-eac1-9f49-5e6d439cb688@redhat.com>
Date: Thu, 7 Mar 2019 11:34:25 +0100
MIME-Version: 1.0
In-Reply-To: <ad194b40-507d-5de1-dc1c-23adb046fac7@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Use CamelCase properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 3/7/19 6:38 AM, Alexey Kardashevskiy wrote:
> On 07/03/2019 16:21, David Gibson wrote:
>> The qemu coding standard is to use CamelCase for type and structure names,
>> and the pseries code follows that... sort of.  There are quite a lot of
>> places where we bend the rules in order to preserve the capitalization of
>> internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR".
>>
>> That was a bad idea - it frequently leads to names ending up with hard to
>> read clusters of capital letters, and means they don't catch the eye as
>> type identifiers, which is kind of the point of the CamelCase convention in
>> the first place.
>>
>> In short, keeping type identifiers look like CamelCase is more important
>> than preserving standard capitalization of internal "words".  So, this
>> patch renames a heap of spapr internal type names to a more standard
>> CamelCase.
>>
>> In addition to case changes, we also make some other identifier renames:
>>   VIOsPAPR* -> SpaprVio*
>>     The reverse word ordering was only ever used to mitigate the capital
>>     cluster, so revert to the natural ordering.
>>   VIOsPAPRVTYDevice -> SpaprVioVty
>>   VIOsPAPRVLANDevice -> SpaprVioVlan
>>     Brevity, since the "Device" didn't add useful information
>>   sPAPRDRConnector -> SpaprDrc
>>   sPAPRDRConnectorClass -> SpaprDrcClass
>>     Brevity, and makes it clearer this is the same thing as a "DRC"
>>     mentioned in many other places in the code
>>
>> This is 100% a mechanical search-and-replace patch. It will, however,
>> conflict with essentially any and all outstanding patches touching the
>> spapr code.
> 
> 
> so it would be nice to have the script to fix those outstanding patches
> before reposting.

What I usually do:

$ sed -i 's/sPAPRDRConnectorClass/SpaprDrcClass/' \
  $(git grep -l sPAPRDRConnectorClass)

> 
> 
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>> Changes since RFC:
>>  * Added a number of extra renames for brevity and/or clarity
>>  * Fixed couple of places the new capitalization still wasn't right
>>

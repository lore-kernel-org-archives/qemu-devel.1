Received: from eggs.gnu.org ([209.51.188.92]:44366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h1ljo-0006jq-Lw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1h1ljn-0000fF-Rp
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:38:36 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1h1ljn-0000et-AE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 00:38:35 -0500
Received: by mail-pg1-x543.google.com with SMTP id h11so10362736pgl.0
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 21:38:35 -0800 (PST)
References: <20190307052137.2780-1-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ad194b40-507d-5de1-dc1c-23adb046fac7@ozlabs.ru>
Date: Thu, 7 Mar 2019 16:38:28 +1100
MIME-Version: 1.0
In-Reply-To: <20190307052137.2780-1-david@gibson.dropbear.id.au>
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
To: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org



On 07/03/2019 16:21, David Gibson wrote:
> The qemu coding standard is to use CamelCase for type and structure names,
> and the pseries code follows that... sort of.  There are quite a lot of
> places where we bend the rules in order to preserve the capitalization of
> internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR".
> 
> That was a bad idea - it frequently leads to names ending up with hard to
> read clusters of capital letters, and means they don't catch the eye as
> type identifiers, which is kind of the point of the CamelCase convention in
> the first place.
> 
> In short, keeping type identifiers look like CamelCase is more important
> than preserving standard capitalization of internal "words".  So, this
> patch renames a heap of spapr internal type names to a more standard
> CamelCase.
> 
> In addition to case changes, we also make some other identifier renames:
>   VIOsPAPR* -> SpaprVio*
>     The reverse word ordering was only ever used to mitigate the capital
>     cluster, so revert to the natural ordering.
>   VIOsPAPRVTYDevice -> SpaprVioVty
>   VIOsPAPRVLANDevice -> SpaprVioVlan
>     Brevity, since the "Device" didn't add useful information
>   sPAPRDRConnector -> SpaprDrc
>   sPAPRDRConnectorClass -> SpaprDrcClass
>     Brevity, and makes it clearer this is the same thing as a "DRC"
>     mentioned in many other places in the code
> 
> This is 100% a mechanical search-and-replace patch. It will, however,
> conflict with essentially any and all outstanding patches touching the
> spapr code.


so it would be nice to have the script to fix those outstanding patches
before reposting.


> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> Changes since RFC:
>  * Added a number of extra renames for brevity and/or clarity
>  * Fixed couple of places the new capitalization still wasn't right
> 



-- 
Alexey

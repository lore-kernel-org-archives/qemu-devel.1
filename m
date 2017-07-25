Received: from eggs.gnu.org ([2001:4830:134:3::10]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZqAv-0003Kh-MJ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 23:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZqAs-0002P3-Hr
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 23:06:21 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZqAs-0002Oq-C8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 23:06:18 -0400
Received: by mail-pg0-x242.google.com with SMTP id v190so13333504pgv.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 20:06:18 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-7-git-send-email-clg@kaod.org>
	<20170724040220.GC17228@umbus.fritz.box>
	<86b8aca2-ffc9-e912-da00-b64a78cfc338@ozlabs.ru>
	<ef215827-4d22-7386-d389-d058c6b1f292@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6d7d541c-613e-9a12-34e1-8de8a2858fe6@ozlabs.ru>
Date: Tue, 25 Jul 2017 13:06:10 +1000
MIME-Version: 1.0
In-Reply-To: <ef215827-4d22-7386-d389-d058c6b1f292@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 06/26] ppc/xive: introduce a XIVE
 interrupt source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On 25/07/17 01:20, Cédric Le Goater wrote:
> On 07/24/2017 08:00 AM, Alexey Kardashevskiy wrote:
>> On 24/07/17 14:02, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:19PM +0200, Cédric Le Goater wrote:
>>>> This is very similar to the current ICS_SIMPLE model in XICS. We try
>>>> to reuse the ICS model because the sPAPR machine is tied to the
>>>> XICSFabric interface and should be using a common framework to switch
>>>> from one controller model to another: XICS <-> XIVE.
>>>
>>> Hm.  I'm not entirely concvinced re-using the xics ICSState class in
>>> this way is a good idea, though maybe it's a reasonable first step.
>>> With this patch alone some code is shared, but there are some real
>>> uglies around the edges.
>>
>>
>> Agree, using the "ICS" term in XIVE is quite confusing as "ICS" is not
>> mentioned in neither XIVE nor P9 specs.
> 
> Indeed. 
> 
> The XIVE specs mention Source Controller (P3SC) or Interrupt 
> Virtualization Source Engine (IVSE). The sPAPR specs use 
> Interrupt Source a lot.
> 
> Let's unify them all under one name ? I propose ICS :)


Too late because it is a part of XICS :) Ben calls them "source
controller", seems appropriate.


-- 
Alexey

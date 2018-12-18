Received: from eggs.gnu.org ([2001:4830:134:3::10]:41356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZDFK-0001Ac-CS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gZD49-0002Kr-5r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:57:36 -0500
References: <20181217140055.8545-1-lvivier@redhat.com>
	<20181218042938.GI23604@umbus.fritz.box>
	<8cf7e664-27e6-d4f4-ea71-29a61a3122e6@redhat.com>
	<20181218102311.68400aa5@bahia.lan>
	<639bdcc3-3974-b762-2089-808fd55d9226@redhat.com>
	<20181218115015.1564d0a2@bahia.lan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <4e667a79-68b7-4cf1-994c-b72ee738e0a6@redhat.com>
Date: Tue, 18 Dec 2018 11:57:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181218115015.1564d0a2@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 18/12/2018 11:50, Greg Kurz wrote:
> On Tue, 18 Dec 2018 11:00:01 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
> 
>> On 18/12/2018 10:23, Greg Kurz wrote:
>>> On Tue, 18 Dec 2018 08:50:00 +0100
...
>>> Also, even if linux only seems to call this with 0x1, this is a
>>> limitation from a LoPAPR standpoint. Not sure H_PARAMETER is the
>>> appropriate return value if flags is 0x2 since the guest did
>>> nothing wrong... I'd rather return H_FUNCTION in this case.  
>>
>> The doc says:
>>
>>   H_Function:  The function is not supported
>>   H_Parameter: Unsupported flag parameter value
>>
>> in that case function is supported but not the flag, so I think
>> H_PARAMETER is a better choice.
>>
> 
> Well... neither LoPAPR, nor IBM confidential PAPR+ do say anything
> about partial support for this hcall. If the guest was to use the
> flags == 0x2 variant, eg, some closed-source OS supporting PAPR,
> it could be legitimately confused to get an H_PARAMETER error when
> passing supposedly valid parameters... how to cope with that ?
> On the other hand, if QEMU cannot honor the flags == 0x2 variant
> and returns H_FUNCTION then the OS can recover since it is
> required by the specification.

You have certainly access to more information than I have, so I'll
change H_PARAMETER to H_FUNCTION.

Thanks,
Laurent

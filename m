Received: from eggs.gnu.org ([2001:4830:134:3::10]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTdJ-0005UO-Ec
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTdG-0002je-C9
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:49:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezTdG-0002j8-6e
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:49:50 -0400
References: <1520860275-101576-1-git-send-email-imammedo@redhat.com>
	<1520860275-101576-3-git-send-email-imammedo@redhat.com>
	<20180323204218.GC28161@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebc23db4-34f8-5774-2486-6773af015d30@redhat.com>
Date: Fri, 23 Mar 2018 15:49:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180323204218.GC28161@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/9] numa: split out NumaOptions parsing
 into parse_NumaOptions()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, Laurent Vivier <lvivier@redhat.com>

On 03/23/2018 03:42 PM, Eduardo Habkost wrote:
> On Mon, Mar 12, 2018 at 02:11:08PM +0100, Igor Mammedov wrote:
>> it will allow to reuse parse_NumaOptions() for parsing
>> configuration commands received via QMP interface
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---

>>   end:
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +    }
> 
> "if (err)" is not necessary here.  See
> scripts/coccinelle/error_propagate_null.cocci.
> 

>> +    parse_NumaOptions(ms, object, &err);
>> +
>> +end:
>>       qapi_free_NumaOptions(object);
>>       if (err) {
>>           error_report_err(err);
> 
> We can fix this one too while at it.

Hmm - this is the same script mentioned here:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06293.html

Except that patch didn't pick up this file.  Why is Coccinelle not 
seeing this?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

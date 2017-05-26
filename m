Received: from eggs.gnu.org ([2001:4830:134:3::10]:43949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEF7W-0002Cm-Ow
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dEF7T-0000Fx-Jp
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dEF7T-0000Ft-D8
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BB8A85547
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 13:17:30 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-2-git-send-email-vyasevic@redhat.com>
	<97bb0fa8-eddf-5721-6578-7223bc6e6bed@redhat.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <ce9bf7df-7751-29e5-e075-8c5d40cc93a0@redhat.com>
Date: Fri, 26 May 2017 09:17:22 -0400
MIME-Version: 1.0
In-Reply-To: <97bb0fa8-eddf-5721-6578-7223bc6e6bed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: Introduce announce
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, kashyap@redhat.com, jdenemar@redhat.com

On 05/26/2017 09:08 AM, Eric Blake wrote:
> On 05/24/2017 01:05 PM, Vladislav Yasevich wrote:
>> Add parameters that control RARP/GARP announcement timeouts.
>> The parameters structure is added to the QAPI and a qmp command
>> is added to set/get the parameter data.
>>
>> Based on work by "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>> ---
> 
> Just an interface review for now:
> 
>> +++ b/qapi-schema.json
>> @@ -569,6 +569,90 @@
>>  ##
>>  { 'command': 'query-events', 'returns': ['EventInfo'] }
>>  
>> +
>> +##
>> +# @AnnounceParameter:
>> +#
>> +# @AnnounceParameter enumeration
>> +#
>> +# @initial: Initial delay (in ms) before sending the first GARP/RARP
>> +#       announcement
>> +#
>> +# @max: Maximum delay (in ms) to between GARP/RARP announcemnt packets
> 
> s/announcemnt/announcement/
> 
>> +#
>> +# @rounds: Number of self-announcement attempts
>> +#
>> +# @step: Delay increate (in ms) after each self-announcment attempt
> 
> s/increate/increase/
> s/announcment/announcement/
> 
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'enum' : 'AnnounceParameter',
>> +  'data' : [ 'initial', 'max', 'rounds', 'step' ] }
> 
> Why are we creating an enum here?  Without reading further, it looks
> like you plan on using the enum to delineate members of a union? But
> that feels like it will be overly complicated.  A struct should be
> sufficient (each parameter being an optional member of the struct, where
> you can supply as many or as few on input, but all are reported on output).
> 

I end up using them for the HMP interface.  If it's better, I can move this
definition to the HMP patch.

Thanks
-vlad

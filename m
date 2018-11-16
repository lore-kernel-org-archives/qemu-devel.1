Received: from eggs.gnu.org ([2001:4830:134:3::10]:45164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfyQ-000659-ID
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfyI-0001af-DL
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNfyI-0001RA-6K
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:23:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97ECF8CC2
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 15:23:28 +0000 (UTC)
References: <20181026105711.29605-1-cohuck@redhat.com>
	<20181115172032.53945f5e.cohuck@redhat.com>
	<1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
	<20181116161400.1e3c2669.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <20654e1b-38a0-7f70-df97-7ccd5bf17197@redhat.com>
Date: Fri, 16 Nov 2018 09:23:27 -0600
MIME-Version: 1.0
In-Reply-To: <20181116161400.1e3c2669.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

On 11/16/18 9:14 AM, Cornelia Huck wrote:

>> Recent threads have mentioned the possibility of potentially adding a
>> new category P: for the person that submits pull requests, although I'm
>> not quite sure how that is different from M: as a maintainer
> 
> Let's wait how that discussion turns out (I'm not quite sure about the
> semantics, either.) We can document it then.

Indeed, incremental patches are better than doing nothing while waiting 
for perfection.

> 
>>
>>>> +++ b/MAINTAINERS
>>>> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
>>>>    Descriptions of section entries:
>>>>    
>>>>    	M: Mail patches to: FullName <address@domain>
>>>> +	   Maintainers are looking after a certain area and must be CCed on
>>>> +	   patches. They are considered the main contact point.
>>
>> Maybe add something along the lines of "However, a maintainer may accept
>> code that has been reviewed by others without explicitly reviewing it
>> themselves"?
> 
> I'm not sure whether that adds vital information. If a maintainer picks
> a patch that has been reviewed by others, they may or may not do a
> proper review themselves; but the end result is basically the same
> (patch makes its way into the tree.)

Okay. There's also the counter argument that too much text makes it 
something that no one will want to spend time reading, so leaving things 
concise is desirable.

>> At any rate, I like the idea of adding the additional descriptions for
>> the categories, even if we still bike-shed on the wording or even the
>> set of categories to use.
> 
> What about going with this as a starting point?

Yes, works for me. We can always add more patches later if desired.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKmj-0006Xv-6Y
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNKme-00028m-Si
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:46:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNKme-00028N-NC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1D2A307DAA4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 16:46:23 +0000 (UTC)
References: <20181026105711.29605-1-cohuck@redhat.com>
	<20181115172032.53945f5e.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c020087-acd7-302a-d5be-dcdbf7b7084d@redhat.com>
Date: Thu, 15 Nov 2018 10:46:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181115172032.53945f5e.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 11/15/18 10:20 AM, Cornelia Huck wrote:
> On Fri, 26 Oct 2018 12:57:11 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> The MAINTAINERS file is a bit sparse on information about what
>> the different designators are. Let's add some more information
>> to give contributors a better idea about what the different
>> roles are.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> This came out of a discussion about what being a 'reviewer' listed in
>> this file actually means. A reviewer probably should already have a
>> track record of doing helpful reviews before being listed in here.
>>
>> While at it, I also tried to add some more hints for the other entries.
>> This patch is supposed to be a starting point for further discussion.
> 
> Ping. Further discussion would be good :)

Recent threads have mentioned the possibility of potentially adding a 
new category P: for the person that submits pull requests, although I'm 
not quite sure how that is different from M: as a maintainer

>> +++ b/MAINTAINERS
>> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
>>   Descriptions of section entries:
>>   
>>   	M: Mail patches to: FullName <address@domain>
>> +	   Maintainers are looking after a certain area and must be CCed on
>> +	   patches. They are considered the main contact point.

Maybe add something along the lines of "However, a maintainer may accept 
code that has been reviewed by others without explicitly reviewing it 
themselves"?

>>   	R: Designated reviewer: FullName <address@domain>
>>   	   These reviewers should be CCed on patches.
>> +	   Reviewers are familiar with the subject matter and provide feedback
>> +	   even though they are not maintainers.
>>   	L: Mailing list that is relevant to this area
>> +	   These lists should be CCed on patches.
>>   	W: Web-page with status/info
>>   	Q: Patchwork web based patch tracking system site
>>   	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.
> 

At any rate, I like the idea of adding the additional descriptions for 
the categories, even if we still bike-shed on the wording or even the 
set of categories to use.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

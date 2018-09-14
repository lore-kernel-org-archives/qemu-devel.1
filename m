Received: from eggs.gnu.org ([2001:4830:134:3::10]:36416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0of0-000257-4V
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0oew-0005FR-Ib
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g0oew-0005Dd-8k
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:01:22 -0400
References: <1536814370-12997-1-git-send-email-zhangckid@gmail.com>
	<ad44caaa-c588-f730-2c6b-dc6896a1cea5@redhat.com>
	<CAK3tnvJ3Pv9pGneHNd6zyMcBUnhvBEVvXL6k3kh1Bw_+A9pT5w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42ca29eb-37bc-97e9-def5-2dab5a3279e1@redhat.com>
Date: Fri, 14 Sep 2018 09:01:17 -0500
MIME-Version: 1.0
In-Reply-To: <CAK3tnvJ3Pv9pGneHNd6zyMcBUnhvBEVvXL6k3kh1Bw_+A9pT5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V12-fix 01/19] filter-rewriter: Add TCP
 state machine and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, jasowang@redhat.com, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Zhang Chen <chen.zhang@intel.com>

On 9/13/18 7:58 PM, Zhang Chen wrote:

>>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>
>> Should both of these last two S-o-b be present?
>>
>>
> 
> Maybe it will be more convenient to contact me, I use both of the email. :)

I can't tell you it's wrong, only that it is unusual. Statistics-wise, 
it's nicer if .mailmap consolidates multiple working email addresses 
into one individual, both for the sake of 'git shortlog' author 
attribution, and for making it easier to grep the git logs for your 
contributions regardless of which of the two emails that particular 
commit was sent under. If it were me, I'd rely on .mailmap rather than 
trying to double-sign my contributions.

Also, since one email appears to be personal while the other Intel, your 
company may have specific rules on which email address to use (was the 
patch written on your time or on Intel time?) (here, I have to admit 
that Red Hat's policy allows me to choose either my personal or my work 
email for open source contributions, regardless of whether I did it on 
my time or company time, but very few companies have equivalent policies 
that relaxed).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

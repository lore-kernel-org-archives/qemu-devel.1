Received: from eggs.gnu.org ([2001:4830:134:3::10]:45395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV2Mv-0007oM-2A
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fV2Mr-0004H3-T9
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:11:25 -0400
References: <1528859749-25286-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20180613035030.GB25430@flamenco>
	<23a38716-196f-53a0-0a3d-61f269b1dab4@redhat.com>
	<20180613141510.GA672@byw>
	<20180615173013.GH12972@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4fb174ba-ec91-483e-63ed-ca3c118ae9f8@redhat.com>
Date: Mon, 18 Jun 2018 17:11:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180615173013.GH12972@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tracing.txt: add missing '-' for trace
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 06/15/2018 12:30 PM, Stefan Hajnoczi wrote:

>>>
>>> So I'm in favor of this patch, although it may need more of a commit
>>> message summarizing the justification I've just pointed you to.
>>
>> Thanks for your nice explaination. If this patch could be merged i will
>> send V2 with a commit message.
> 
> Please update the remaining occurrences of the -trace option syntax in
> v2:
> 
>    $ git grep -- -trace docs/devel/tracing.txt

Also fixing strings in trace/control.[ch] would be appropriate.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

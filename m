Received: from eggs.gnu.org ([2001:4830:134:3::10]:51402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb75n-00056M-4t
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cb75j-0002Ts-7G
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:50:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cb75j-0002Ss-0a
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:49:59 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 522A0C04B95A
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 14:49:58 +0000 (UTC)
References: <1486463022-4780-1-git-send-email-thuth@redhat.com>
	<71e68e8c-1a7f-2c93-f380-4da1e27090a0@redhat.com>
	<98d02b12-fb47-5bd5-dc8b-b1b6a0025f8e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb93d4be-46d2-fb8d-3b0c-92cba7a59484@redhat.com>
Date: Tue, 7 Feb 2017 15:49:55 +0100
MIME-Version: 1.0
In-Reply-To: <98d02b12-fb47-5bd5-dc8b-b1b6a0025f8e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH 0/2] Fix HTML issues discovered
 with the W3 HTML validator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org



On 07/02/2017 11:50, Thomas Huth wrote:
> On 07.02.2017 11:40, Paolo Bonzini wrote:
>>
>>
>> On 07/02/2017 11:23, Thomas Huth wrote:
>>> The W3 HTML validator (https://validator.w3.org/) complains about
>>> missing "alt" attributes and a missing "</section>" tag for the
>>> new QEMU website. Here are two patches to fix the issues.
>>>
>>> Thomas Huth (2):
>>>   Add missing HTML tag to close the screenshots section
>>>   Add "alt" attributes to the img tags
>>>
>>>  _includes/screenshot.html | 2 +-
>>>  index.html                | 1 +
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>
>> Applied, thanks! :)
> 
> There is another error reported by the validator on the blog page:
> 
> https://validator.w3.org/nu/?doc=http%3A%2F%2Fwww.qemu-project.org%2Fblog%2F
> 
> But I don't have a clue how to fix that one ... the space in the URL
> should be translated to %20 - any ideas how to do that with Jekyll?

No idea, the best would probably be to make the category page "web_site"
instead of "web site".

Paolo

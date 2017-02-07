Received: from eggs.gnu.org ([2001:4830:134:3::10]:45405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb3MU-0003Ue-AH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cb3MQ-0003Vt-Dv
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cb3MQ-0003Vp-87
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:50:58 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 483D83D957
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 10:50:58 +0000 (UTC)
References: <1486463022-4780-1-git-send-email-thuth@redhat.com>
	<71e68e8c-1a7f-2c93-f380-4da1e27090a0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <98d02b12-fb47-5bd5-dc8b-b1b6a0025f8e@redhat.com>
Date: Tue, 7 Feb 2017 11:50:55 +0100
MIME-Version: 1.0
In-Reply-To: <71e68e8c-1a7f-2c93-f380-4da1e27090a0@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 07.02.2017 11:40, Paolo Bonzini wrote:
> 
> 
> On 07/02/2017 11:23, Thomas Huth wrote:
>> The W3 HTML validator (https://validator.w3.org/) complains about
>> missing "alt" attributes and a missing "</section>" tag for the
>> new QEMU website. Here are two patches to fix the issues.
>>
>> Thomas Huth (2):
>>   Add missing HTML tag to close the screenshots section
>>   Add "alt" attributes to the img tags
>>
>>  _includes/screenshot.html | 2 +-
>>  index.html                | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
> 
> Applied, thanks! :)

There is another error reported by the validator on the blog page:

https://validator.w3.org/nu/?doc=http%3A%2F%2Fwww.qemu-project.org%2Fblog%2F

But I don't have a clue how to fix that one ... the space in the URL
should be translated to %20 - any ideas how to do that with Jekyll?

 Thomas

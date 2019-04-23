Received: from eggs.gnu.org ([209.51.188.92]:36040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hItbr-0000Aq-Du
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hItbq-00038X-9W
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:29:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hItbp-00036U-Vk
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:29:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30A3A3086212
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 11:29:09 +0000 (UTC)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-2-ehabkost@redhat.com>
	<91f001e1-a47a-9eb0-f9af-746699f72fb4@redhat.com>
	<20190423110842.GB25134@habkost.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <238f448e-4e46-dc5e-6437-38d265fde067@redhat.com>
Date: Tue, 23 Apr 2019 13:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190423110842.GB25134@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fixup! qtest: Move accel code to
 accel/qtest.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 23/04/2019 13.08, Eduardo Habkost wrote:
> On Tue, Apr 23, 2019 at 07:07:06AM +0200, Thomas Huth wrote:
>> On 22/04/2019 23.04, Eduardo Habkost wrote:
>>> QTest has two parts: the server (-qtest) and the accelerator
>>> (-machine accel=qtest).  The accelerator depends on CONFIG_POSIX
>>> due to its usage of sigwait(), but the server doesn't.
>>>
>>> Move the accel code to accel/qtest.c.  Later we will disable
>>> compilation of accel/qtest.c on non-POSIX systems.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  accel/qtest.c       | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>
>> New file ==> You should update MAINTAINERS here as well.
> 
> Oops, sorry!  Fixup below.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56139ac8ab..cf3156d952 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2024,6 +2024,7 @@ M: Laurent Vivier <lvivier@redhat.com>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
>  F: qtest.c
> +F: accel/qtest.c
>  F: tests/libqtest.*
>  F: tests/libqos/
>  F: tests/*-test.c

All right, queued the patches on my qtest-next branch:

  https://gitlab.com/huth/qemu/tree/qtest-next

 Thanks,
  Thomas

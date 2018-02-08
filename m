Received: from eggs.gnu.org ([2001:4830:134:3::10]:51274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejuss-0002D0-RS
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejusp-00075t-Od
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:41:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejusp-00075n-K4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:41:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38B2440FB630
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 22:41:35 +0000 (UTC)
References: <1518120582-26647-1-git-send-email-thuth@redhat.com>
	<1518120582-26647-14-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed70ae18-1864-63c6-ba5a-26cade9832e9@redhat.com>
Date: Thu, 8 Feb 2018 16:41:34 -0600
MIME-Version: 1.0
In-Reply-To: <1518120582-26647-14-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/14] tests/boot-serial: Add tests for
 PowerPC Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 02/08/2018 02:09 PM, Thomas Huth wrote:
> OpenBIOS prints out the CPU type on these machine types, so we can use
> this string to test whether the CPU detection is working correctly.
> 
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/boot-serial-test.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 996d3d7..72873ee 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -69,8 +69,11 @@ static testdef_t tests[] = {
>       { "alpha", "clipper", "", "PCI:" },
>       { "ppc", "ppce500", "", "U-Boot" },
>       { "ppc", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc", "g3beige", "", "PowerPC,750" },
> +    { "ppc", "mac99", "", "PowerPC,G4" },
>       { "ppc64", "ppce500", "", "U-Boot" },
>       { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc64", "mac99", "", "PowerPC,970FX" },

[I wish thunderbird wouldn't corrupt whitespace when quoting patches - 
it seems to be a recent regression on something that used to work]

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

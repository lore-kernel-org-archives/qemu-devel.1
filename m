Received: from eggs.gnu.org ([2001:4830:134:3::10]:56747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYuV7-0001DO-Uz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYuV1-0002vQ-Dd
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gYuV0-0002tJ-Kh
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:08:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 333ECBCD29
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 15:08:00 +0000 (UTC)
References: <20181214084754.23854-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <028958fa-d970-7e75-4994-1c1e8fc862e9@redhat.com>
Date: Mon, 17 Dec 2018 09:07:58 -0600
MIME-Version: 1.0
In-Reply-To: <20181214084754.23854-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: Remake config-host.mak when VERSION
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 12/14/18 2:47 AM, Markus Armbruster wrote:
> configure gets the version number from VERSION, and writes it to
> config-host.mak.  The make dependency for that is missing.  Because of
> that, a rebuild after a VERSION change may not pick up the change.
> Fix that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/Makefile b/Makefile
> index c8b9efdad4..038780c6d0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -67,7 +67,7 @@ CONFIG_ALL=y
>   -include config-all-devices.mak
>   -include config-all-disas.mak
>   
> -config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios
> +config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
>   	@echo $@ is out-of-date, running configure
>   	@# TODO: The next lines include code which supports a smooth
>   	@# transition from old configurations without config.status.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

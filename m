Received: from eggs.gnu.org ([2001:4830:134:3::10]:53256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84EL-0003OX-4H
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84EF-00020m-A1
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g84EE-0001zX-VV
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:03:47 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F41F630014DC
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 14:03:45 +0000 (UTC)
References: <20180925075646.25114-1-kraxel@redhat.com>
	<20180925075646.25114-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <947ea402-204c-a81e-8392-f499e762197f@redhat.com>
Date: Thu, 4 Oct 2018 09:03:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180925075646.25114-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] display/edid: add edid generator to
 qemu.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

On 9/25/18 2:56 AM, Gerd Hoffmann wrote:
> EDID is a metadata format to describe monitors.  On physical hardware
> the monitor has an eeprom with that data block which can be read over
> i2c bus.
> 

> +++ b/Makefile
> @@ -543,6 +543,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>   
>   qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
>   
> +qemu-edid$(EXESUF): qemu-edid.o hw/display/edid-generate.o $(COMMON_LDADDS)

For an in-tree build, this forgot to add qemu-edid to .gitignore.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

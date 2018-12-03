Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTuOb-0002Kl-AU
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gTuOY-0003jH-5S
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:00:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gTuOX-0003Pj-Ut
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 15:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8BC730821F1
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 20:00:34 +0000 (UTC)
References: <20181203195039.29597-1-kraxel@redhat.com>
	<20181203195039.29597-2-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <96a5eae1-e2eb-b4ae-35c5-6ebdf864614e@redhat.com>
Date: Mon, 3 Dec 2018 14:00:19 -0600
MIME-Version: 1.0
In-Reply-To: <20181203195039.29597-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/2] usb-mtp: fix utf16_to_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 12/3/18 1:50 PM, Gerd Hoffmann wrote:
> Make utf16_to_str return an allocated string.  Remove the assumtion that

s/assumtion/assumption/ (but probably too late to worry about commit 
typos in a pull request :)

> the number of string bytes equals the number of utf16 chars (which is
> only true for ascii chars).  Instead call wcstombs twice, once to figure
> the storage size and once for the actual conversion (as suggested by the
> wcstombs manpage).
> 
> FIXME: surrogate pairs are not working correctly.  Pre-existing bug,
> fixing that is left for another day.
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

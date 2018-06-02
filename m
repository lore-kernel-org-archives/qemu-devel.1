Received: from eggs.gnu.org ([2001:4830:134:3::10]:59173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fP43b-0005YF-Gk
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fP43Y-0001Po-92
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:46:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fP43Y-0001P9-2t
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EBCA805A52F
	for <qemu-devel@nongnu.org>; Sat,  2 Jun 2018 10:46:43 +0000 (UTC)
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
Date: Sat, 2 Jun 2018 12:46:40 +0200
MIME-Version: 1.0
In-Reply-To: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 06/01/2018 03:28 PM, Max Reitz wrote:
> Hi,
> 
> The @preconfig RunState documentation states:
> 
>> The state is reachable only if the --preconfig CLI option is used.
> 
> However, this is not true:
> 
> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
> QEMU 2.12.50 monitor - type 'help' for more information
> (qemu)
> HMP not available in preconfig state, use QMP instead

Not sure if this is the same bug, but I've noticed libvirt having
troubles detecting capabilities of qemu and debugging lead to this patch:

http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html

(which by no means I claim is proper solution. It might be viewed as
workaround by expert qemu devels)

> 
> On IRC, Daniel proposed doing the runstate transition immediately after
> the command line has been read and no --preconfig option has been found.
>  Doing that indeed fixes the issue for me (but I don't know whether
> that's the best solution).

Oh has he? I can't find it anywhere.

Michal

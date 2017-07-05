Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSfsy-0005Qf-6f
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dSfst-0000UF-Ck
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dSfst-0000U2-69
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 04:42:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499234355-138591-1-git-send-email-agraf@suse.de>
Date: Wed, 05 Jul 2017 10:42:00 +0200
In-Reply-To: <1499234355-138591-1-git-send-email-agraf@suse.de> (Alexander
	Graf's message of "Wed, 5 Jul 2017 07:59:15 +0200")
Message-ID: <87bmozb7hj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] vnc: Set default kbd delay to 10ms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Alexander Graf <agraf@suse.de> writes:

> The default keyboard delay time in the input layer is 10ms. I don't know

Do you mean "is 1ms"?

> how that number came to be, but empirical tests on some OpenQA driven ARM
> systems show that 10ms really is a reasonable default number for the delay.
>
> With the current 1ms we're constantly typing faster than the guest receives
> keyboard events from our XHCI attached USB HID device.
>
> This patch moves the delay to 10ms. That way our default is much safer (good!)
> and also consistent with the input layer default (also good!).
>
> Signed-off-by: Alexander Graf <agraf@suse.de>

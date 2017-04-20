Received: from eggs.gnu.org ([2001:4830:134:3::10]:51857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d16cz-0002Ia-PD
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d16cw-0003NU-I9
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d16cw-0003NB-Bf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:35:42 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <149263859862.10521.4608468144116665031@6c512846dbc7>
	(no-reply@patchew.org's message of "Wed, 19 Apr 2017 14:49:59 -0700
	(PDT)")
References: <149263859862.10521.4608468144116665031@6c512846dbc7>
Reply-To: quintela@redhat.com
Date: Thu, 20 Apr 2017 09:35:32 +0200
Message-ID: <87pog7fs57.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/59] RAMState + qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, dgilbert@redhat.com

no-reply@patchew.org wrote:
> Hi,

> ERROR: do not initialise globals to 0 or NULL
> #24: FILE: hw/core/qdev.c:42:
> +bool qdev_hotplug = false;
>
> total: 1 errors, 0 warnings, 24 lines checked

I am just removing one static here.  This is maintainer preference.
there are three bools together, but I don't feel like changing this.

How are we supposed to fix this kind of errors?

Later, Juan.

Received: from eggs.gnu.org ([209.51.188.92]:42663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjxR-0000Ch-J8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjxQ-0003cj-Ri
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:10:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDjxQ-0003bW-JJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAFC889C45
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 06:10:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-15-armbru@redhat.com>
	<53312567-fb1e-0f9d-f2d1-1adbf584ef21@redhat.com>
Date: Tue, 09 Apr 2019 08:10:03 +0200
In-Reply-To: <53312567-fb1e-0f9d-f2d1-1adbf584ef21@redhat.com> (Eric Blake's
	message of "Mon, 8 Apr 2019 14:04:13 -0500")
Message-ID: <87y34jhfpg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/15] char: Make -chardev help print to
 stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 4/8/19 3:36 AM, Markus Armbruster wrote:
>> Command line help explicitly requested by the user should be printed
>> to stdout, not stderr.  We do elsewhere.  Adjust -chardev to match:
>> use qemu_printf() instead of error_printf().  Plain printf() would be
>> wrong because we need to print to the current monitor for chardev-add
>> help".
>
> Mismatched "

Eagle eyes.  Will fix, thanks!

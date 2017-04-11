Received: from eggs.gnu.org ([2001:4830:134:3::10]:51644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxx1e-0005zQ-0d
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxx1a-0003sk-R7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxx1a-0003sM-Ka
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:44:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1491814997-58268-1-git-send-email-longpeng2@huawei.com>
Date: Tue, 11 Apr 2017 16:43:55 +0200
In-Reply-To: <1491814997-58268-1-git-send-email-longpeng2@huawei.com>
	(Longpeng's message of "Mon, 10 Apr 2017 17:03:17 +0800")
Message-ID: <87y3v7c8d0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 00/19] crypto: add af_alg-backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, xuquan8@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org

"Longpeng(Mike)" <longpeng2@huawei.com> writes:

> The AF_ALG socket family is the userspace interface for linux
> crypto API, users can use it to access hardware accelerators.
>
> This patchset adds a afalg-backend for qemu crypto subsystem. Currently
> when performs encrypt/decrypt, we'll try afalg-backend first and will
> back to libiary-backend if it failed.
>
> In the next step, It would support a command parameter to specifies
> which backends prefer to and some other improvements.

Series isn't threaded properly even though your Message-Id suggests use
of git-send-email.  Did you pass --no-thread, or do you have
sendemail.thread configured off?

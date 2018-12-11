Received: from eggs.gnu.org ([2001:4830:134:3::10]:53322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gWfQC-0000OL-O7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gWfQ6-0002pm-G6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:37:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gWfQ4-0002n5-AY
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:37:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id q26so1660253wmf.5
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 02:37:36 -0800 (PST)
References: <20181206101423.17344-1-remy.noel@blade-group.com>
	<20181210190548.GB31743@stefanha-x1.localdomain>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <761476c8-008a-ada0-4c2a-8e630b8490c5@blade-group.com>
Date: Tue, 11 Dec 2018 11:37:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181210190548.GB31743@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v2] aio-posix: Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, "open list:Block I/O path" <qemu-block@nongnu.org>

On 12/10/18 8:05 PM, Stefan Hajnoczi wrote:

> On Thu, Dec 06, 2018 at 11:14:23AM +0100, remy.noel@blade-group.com wrote:
>> +        if (is_new) {
>> +            new_node->pfd.fd = fd;
>> +        } else {
>> +            deleted = aio_remove_fd_handler(ctx, node);
>> +            new_node->pfd = node->pfd;
> Does this drop revents?  Imagine revents has bits set, then
> aio_remove_fd_handler() will clear them and new_node->pfd = node->pfd is
> too late to preserve them.

Indeed, i will invert those.

Thanks !

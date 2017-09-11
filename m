Received: from eggs.gnu.org ([2001:4830:134:3::10]:52561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drU6x-0008Pi-D7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drU6u-00053Z-Mo
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:11:11 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drU6u-00052i-GP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:11:08 -0400
Received: by mail-io0-x22f.google.com with SMTP id j141so32770938ioj.4
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 12:11:08 -0700 (PDT)
Date: Mon, 11 Sep 2017 12:04:15 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1505156655.1214.3@smtp.gmail.com>
In-Reply-To: <20170911171015.GU21444@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911085043.GE21444@redhat.com> <1505149415.1214.1@smtp.gmail.com>
	<20170911171015.GU21444@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 6/6] io: Reply to ping frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Sep 11, 2017 at 10:10 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> It feels like this is still dangerous - the client simply has to 
> interleave each "ping" with a 1 byte binary frame to get around this 
> limit. We need to make sure we have an absolute cap on the output 
> buffer size.

Okay. I see that now that I look at it more closely. This breed of 
asynchronous I/O is tricky because the conditions for reading/writing 
are all over the place. There's a lot of context to keep in your head.

I have a fix. And I realized that I was missing a patch in the series 
for RFC-compliant closing of websocket connections, which I must have 
lost during a rebase. Should I submit v3 of the patch series or just 
add those patches to this thread?

Thank you,
--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

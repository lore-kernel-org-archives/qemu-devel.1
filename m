Received: from eggs.gnu.org ([2001:4830:134:3::10]:46973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drSk5-0002bZ-Nc
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drSk0-0005Du-Qz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:43:29 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:37751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drSk0-0005D6-LB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:43:24 -0400
Received: by mail-io0-x22f.google.com with SMTP id j141so31071420ioj.4
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 10:43:24 -0700 (PDT)
Date: Mon, 11 Sep 2017 10:43:21 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1505151801.1214.2@smtp.gmail.com>
In-Reply-To: <20170911173743.GV21444@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911173743.GV21444@redhat.com>
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

On Mon, Sep 11, 2017 at 10:37 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> At the time qio_channel_websock_decode_header is run, 'encinput' is 
> only guaranteed to contain enough data to decode the header.

Because the PING opcode is a control frame, this bit of code earlier in 
the function will ensure the entire frame has been read before the PING 
processing occurs:

>       if (ioc->encinput.offset < ioc->payload_remain) {
>             /* Wait for the entire payload before processing control 
> frames
>              * because the payload will most likely be echoed back. */
>             if (ioc->opcode & 
> QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
>                 return QIO_CHANNEL_ERR_BLOCK;
>             }
>             payload_len = ioc->encinput.offset - 
> (ioc->encinput.offset % 4);

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

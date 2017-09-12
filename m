Received: from eggs.gnu.org ([2001:4830:134:3::10]:44150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn7t-0002ke-S2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn7s-0003Lc-PN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:29:25 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:35111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn7s-0003LI-J0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:29:24 -0400
Received: by mail-pg0-x22e.google.com with SMTP id 188so21857372pgb.2
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:29:24 -0700 (PDT)
Date: Tue, 12 Sep 2017 08:29:21 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1505230161.29344.0@smtp.gmail.com>
In-Reply-To: <20170912090104.GB17633@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911173743.GV21444@redhat.com> <1505151801.1214.2@smtp.gmail.com>
	<20170912090104.GB17633@redhat.com>
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

On Tue, Sep 12, 2017 at 2:01 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> The problem is in the qio_channel_websock_read_wire method we refuse 
> to read more than 4k into encinput. So if the ping payload is greater 
> than 4k this will just loop forever.

The RFC limits the payload length of control messages to 126 bytes, , 
limiting the total message size to 132 bytes. This is enforced in 
qio_channel_websock_decode_header(). If anything larger is sent in a 
control message, including pings, the connection is immediately closed.
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

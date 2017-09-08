Received: from eggs.gnu.org ([2001:4830:134:3::10]:34314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNkV-0008KT-Mg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNkS-0000EE-GZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:11:27 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNkS-0000Dx-8v
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 14:11:24 -0400
Received: by mail-pf0-x234.google.com with SMTP id e1so5671078pfk.1
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 11:11:24 -0700 (PDT)
Date: Fri, 08 Sep 2017 11:11:21 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1504894281.1214.0@smtp.gmail.com>
In-Reply-To: <c4d0a4bb-79d4-3a59-ba50-46ba696249cf@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170724181544.20292-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-1-brandon.carpenter@cypherpath.com>
	<c4d0a4bb-79d4-3a59-ba50-46ba696249cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

My apologies. I read that document before submitting the patch, but 
there was a lot to take in. Would you like me to resend the patch 
without the references?
--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060

On Fri, Sep 8, 2017 at 11:01 AM, Eric Blake <eblake@redhat.com> wrote:
> On 09/08/2017 12:37 PM, Brandon Carpenter wrote:
>>  We've been experiencing issues where the qemu websocket server 
>> closes
>>  connections from noVNC clients for no apparent reason. Debugging 
>> shows
>>  that certain web browsers are injecting ping and pong frames when 
>> the
>>  connection becomes idle. Some browsers send those frames without a
>>  payload, which also is causing closure. This patch series addresses
>>  these issues by making the websocket server more conformant to RFC
>>  6455 - The WebSocket Protocol.
> 
> meta-comment: sending v2 in-reply-to v1 makes it harder for automated
> tooling to recognize that you are sending new patches.  We prefer that
> v2 be a top-level thread.  More patch submission hints at:
> https://wiki.qemu.org/index.php/Contribute/SubmitAPatch
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1da2Fb-0002me-5Q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1da2FY-0004MH-5G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:59:59 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:38614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1da2FX-0004Ly-Va
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:59:56 -0400
Received: by mail-pg0-x22a.google.com with SMTP id k190so6428412pgk.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:59:55 -0700 (PDT)
Date: Tue, 25 Jul 2017 08:59:52 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1500998392.23634.0@smtp.gmail.com>
In-Reply-To: <20170725083849.GE26394@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170725083849.GE26394@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH] io: Improve websocket support by becoming
 more RFC compliant.
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

Sure thing. I implemented it in multiple commits, but there was enough 
overlap in those commits that I thought it would require extra 
unnecessary work to review. But I also found an issue that needs fixed, 
so I need to resubmit anyway.

--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060

On Tue, Jul 25, 2017 at 1:38 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> On Mon, Jul 24, 2017 at 11:42:17AM -0700, Brandon Carpenter wrote:
>>  Remembering the opcode is sufficient for handling fragmented frames 
>> from
>>  the client, which may be introduced by an intermediary server/proxy.
>>  Respond to pings and ignore pongs rather than close the connection 
>> as
>>  many browsers use ping/pong to test an idle connection. Close
>>  connections according to the RFC, including providing reason code 
>> and
>>  message to aid debugging of unexpected disconnects. Empty payloads
>>  should not cause a disconnect.
> 
> Couuld you split this up into multiple patches, each one only fixing
> a single problem at a time. It is rather hard to review this for
> correctness when everything is changed at once.
> 
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    
> https://www.instagram.com/dberrange :|


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.

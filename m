Received: from eggs.gnu.org ([2001:4830:134:3::10]:35323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqLyv-0003IH-6G
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqLyq-0001J6-UZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:18:13 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqLyq-0001ID-Hu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:18:08 -0400
Received: by mail-pg0-x236.google.com with SMTP id 188so5598247pgb.2
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 09:18:07 -0700 (PDT)
Date: Fri, 08 Sep 2017 09:18:04 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1504887484.8245.0@smtp.gmail.com>
In-Reply-To: <20170725083603.GC26394@redhat.com>
References: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
	<20170725083603.GC26394@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH] io: Always remove an old channel watch
 before adding a new one.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

I haven't seen this patch hit master yet and am about to submit a patch 
set that is dependent on this one because it triggers the bug fixed by 
this patch, causing a segmentation fault. Is it preferred that I 
include this patch in that series with the Reviewed-by: tags or to just 
reference this patch in the cover letter?

Thanks.
--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060

On Tue, Jul 25, 2017 at 1:36 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> On Mon, Jul 24, 2017 at 11:15:44AM -0700, Brandon Carpenter wrote:
>>  Also set saved handle to zero when removing without adding a new 
>> watch.
>> 
>>  Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
>>  ---
>>   ui/vnc-auth-vencrypt.c | 3 +++
>>   ui/vnc-ws.c            | 6 ++++++
>>   ui/vnc.c               | 4 ++++
>>   3 files changed, 13 insertions(+)
> 
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> 
> 
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

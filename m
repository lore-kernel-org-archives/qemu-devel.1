Received: from eggs.gnu.org ([2001:4830:134:3::10]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dB9EB-0000MG-R1
	for qemu-devel@nongnu.org; Wed, 17 May 2017 20:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dB9E6-0002mc-Sh
	for qemu-devel@nongnu.org; Wed, 17 May 2017 20:23:39 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dB9E6-0002mR-N0
	for qemu-devel@nongnu.org; Wed, 17 May 2017 20:23:34 -0400
Received: by mail-io0-x241.google.com with SMTP id f102so3016601ioi.3
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 17:23:34 -0700 (PDT)
In-Reply-To: <mailman.71687.1494691106.22739.qemu-devel@nongnu.org>
References: <mailman.71687.1494691106.22739.qemu-devel@nongnu.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <181A050E-196D-40CB-A6D8-85FDC773F261@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Wed, 17 May 2017 20:23:28 -0400
Subject: [Qemu-devel]  [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian McKellar <ianloic@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On May 13, 2017, at 11:58 AM, qemu-devel-request@nongnu.org wrote:

>
> I had two problems with QEMU on macOS:
>  1) Sometimes when alt-tabbing to QEMU it would act as if the 'a' key
>     was pressed so I'd get 'aaaaaaaaa....'.
>  2) Using Sikuli to programatically send keys to the QEMU window text
>     like "foo_bar" would come out as "fooa-bar".
>
> They looked similar and after much digging the problem turned out  
> to be
> the same. When QEMU's ui/cocoa.m received an NSFlagsChanged NSEvent it
> looked at the keyCode to determine what modifier key changed. This
> usually works fine but sometimes the keyCode is 0 and the app should
> instead be looking at the modifierFlags bitmask. Key code 0 is the 'a'
> key.
>
> I added code that handles keyCode == 0 differently. It checks the
> modifierFlags and if they differ from QEMU's idea of which modifier
> keys are currently pressed it toggles those changed keys.
>
> This fixes my problems and seems work fine.
>
> The patch itself is an attachment.
>
> Ian
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-Improve-Cocoa-modifier-key-handling.patch
> Type: application/octet-stream
> Size: 4920 bytes
> Desc: not available
> URL: <http://lists.nongnu.org/archive/html/qemu-devel/attachments/ 
> 20170512/990496cd/attachment.obj>

Could you send your patch via email to the qemu developer list? I am  
interested in testing it. Attachments don't work here.

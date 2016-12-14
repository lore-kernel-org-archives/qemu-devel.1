Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cH5M3-00020D-KY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cH5M0-0002eN-JR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:56:03 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cH5M0-0002eH-C5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 03:56:00 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so3080533wjc.2
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 00:56:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-6-git-send-email-thuth@redhat.com>
	<CAFEAcA-BbkYdTkTWQcqyK-jU+dncnrfDyGwQamMTZ4jr1VqL9A@mail.gmail.com>
	<192aeaa3-042c-6e37-80b3-7a21453c542f@redhat.com>
	<bd4c203a-ac68-2532-b248-41c25bd90065@vivier.eu>
	<604aea80-b160-8cc8-c4e5-231669ca7443@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebb0d6a4-5a33-93d2-ced6-879db75e5cc0@redhat.com>
Date: Wed, 14 Dec 2016 09:54:53 +0100
MIME-Version: 1.0
In-Reply-To: <604aea80-b160-8cc8-c4e5-231669ca7443@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/20] arm: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Anthony Green <green@moxielogic.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Jia Liu <proljc@gmail.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.n>



On 14/12/2016 08:59, Thomas Huth wrote:
>>> Right, good catch, thanks! Looks like I did it right in the other
>>> patches and used target/ppc/cpu.h there for example ... I'll fix it for
>>> ARM in the next version of the patch...
>> There is the same problem in: m68k, alpha, mips and sh4.
>>
>> Could you fix them too?
> You mean the #inlcude "cpu-qom.h" statements? I think they are less
> critical since there is no cpu-qom.h in the generic include folder ...
> but yes, better safe than sorry, I'll fix these statements, too.

There is no cpu.h either in include/.  The only path added is include/,
not include/migration/ or include/qom/, so "cpu.h" can only come from
targets.

"git grep include.*cpu.h hw" shows that a wide majority of inclusions
(120 against 9, many of which in hw/arm) doesn't prepend target-foo/. So
the patch looks good to me.

Paolo

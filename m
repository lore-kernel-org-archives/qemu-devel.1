Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fORfM-0005Hl-9z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fORfL-00023h-KA
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:47:12 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:34747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fORfL-00023C-E2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:47:11 -0400
Received: by mail-pf0-x235.google.com with SMTP id a14-v6so11147834pfi.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 10:47:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528145945.05e22d0f@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<f7e1cd54774642aec19dd2c547a5e560050ab9cd.1527310210.git.keno@alumni.harvard.edu>
	<20180528145945.05e22d0f@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 13:46:29 -0400
Message-ID: <CABV8kRxgK7wV6ZS4pwp6VGUo0AbncciwduUjPHC3t0B6xDQ0qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 13/13] 9p: darwin: configure: Allow VirtFS
 on Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

>> +    elif test "$darwin" = yes; then
>>        virtfs=yes
>> -      tools="$tools fsdev/virtfs-proxy-helper\$(EXESUF)"
>
> So, no proxy helper on Darwin ? Why ? The limitation should be mentioned in
> the changelog at least.

I just had no use for it. I'll try to build it and see what happens.

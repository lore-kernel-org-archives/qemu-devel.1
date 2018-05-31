Received: from eggs.gnu.org ([2001:4830:134:3::10]:46266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQEL-0002Gn-9G
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQEK-00033V-H2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:15:13 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOQEK-00031Y-8s
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:15:12 -0400
Received: by mail-pl0-x242.google.com with SMTP id c11-v6so13520425plr.5
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:15:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529203426.3aa6305a@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<033ba6f2e3f0daccb31e1930a1c65cf7a18ae66c.1527310210.git.keno@alumni.harvard.edu>
	<20180529203426.3aa6305a@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 12:14:30 -0400
Message-ID: <CABV8kRzhiVy9ix67OfPcSZ-SNa6Zh6j5uZ05-yhKW_=Ujyd1HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/13] 9p: Move a couple xattr functions to
 9p-util
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

> I'm ok with this move, but if the functions need to have distinct
> implementations, and they really do according to patch 10, then
> I'd rather have distinct files and rely on conditional building in
> the makefile. Maybe rename the current file to 9p-util-linux.c
> and introduce a 9p-util-darwin.c later.

Sounds good, I will make this change.

>> Additionally, introduce a _follow version of fgetxattr and use it.
>> On darwin, fgetxattr has a more general interface, so we'll need to factor
>> it out anyway.
>>
>
> No need for the _follow version in this case.

I'm not entirely sure what you're proposing. On darwin `fgetxattr`
takes two extra
arguments, so I believe it needs to be factored out nevertheless. Are you just
proposing doing that later in the patch series?

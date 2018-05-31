Received: from eggs.gnu.org ([2001:4830:134:3::10]:40845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOWVG-0002aA-AY
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOWVF-0000Iu-Kl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:57:06 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:35067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOWVF-0000Ik-EK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 18:57:05 -0400
Received: by mail-pf0-x235.google.com with SMTP id x9-v6so11503082pfm.2
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 15:57:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180531215624.2c7b7083@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
	<20180530142026.7c59d967@bahia.lan>
	<CABV8kRzAJxeEB4rb4R0o7Fx_uBqf82tDDWC_6o0Xht3-F63AOA@mail.gmail.com>
	<20180531215624.2c7b7083@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 18:56:23 -0400
Message-ID: <CABV8kRwaVq1HRUh2aeObXOoC_UOinpkb0xKBQkBLqLMYz=omNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 11/13] 9p: darwin: Mark mknod as unsupported
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

>> My concern was that allowing this would cause unexpected
>> behavior, since the device numbers will differ between OS X
>> and Linux. Though maybe this isn't the place to worry about
>> that.
>
> The numbers may differ indeed but we don't really care since the
> server never opens device files. This is just a directory entry.

Ok, let me try to implement it. However, I don't think it is possible
to implement mknodat (or at least I can't think of how) on Darwin
directly. I could use regular mknod, but presumably, this is used
to avoid a race condition between creating the device and setting
the permissions. Can you think of a good way to resolve that?

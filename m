Received: from eggs.gnu.org ([2001:4830:134:3::10]:49359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQPH-0000zs-SW
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQPH-0005DG-4H
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:26:31 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:37501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOQPG-0005CS-UX
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:26:31 -0400
Received: by mail-pg0-x22d.google.com with SMTP id a13-v6so9942609pgu.4
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:26:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529224311.79e0c201@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<cd4661a5e122b1dcd848ff5cdf202e728a0359a8.1527310210.git.keno@alumni.harvard.edu>
	<20180529224311.79e0c201@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 12:25:49 -0400
Message-ID: <CABV8kRz7GiQS3HFxoBJoTfz_TCdwHUX+14ZgaL=m=fVu86OR4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/13] 9p: darwin: Properly translate
 AT_REMOVEDIR flag
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

>> +        errno = EINVAL;
>> +        return -1;
>
> ... I'm more concerned about this new error path. How can this happen ?
>

As far as I can tell, the flags come from the client without any
intermediate error
checking. Since the Darwin constants do not match the Linux constants (which
have the same numerical values as the 9p constants), we need to perform this
checking/translation somewhere to ensure correct behavior.
Is there a more appropriate place to put this check?

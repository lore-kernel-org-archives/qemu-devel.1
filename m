Received: from eggs.gnu.org ([2001:4830:134:3::10]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQb1-00053y-M6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQb0-0005dB-PO
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:38:39 -0400
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOQb0-0005cb-JK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:38:38 -0400
Received: by mail-pl0-x231.google.com with SMTP id n10-v6so13553801plp.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:38:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530142026.7c59d967@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<e47c58ca95c93503a9d85dc6d749acf9fe9c6e76.1527310210.git.keno@alumni.harvard.edu>
	<20180530142026.7c59d967@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 12:37:56 -0400
Message-ID: <CABV8kRzAJxeEB4rb4R0o7Fx_uBqf82tDDWC_6o0Xht3-F63AOA@mail.gmail.com>
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

>> +#ifdef CONFIG_DARWIN
>> +    /* Darwin doesn't have mknodat and it's unlikely to work anyway,
>
> What's unlikely to work ?
>

My concern was that allowing this would cause unexpected
behavior, since the device numbers will differ between OS X
and Linux. Though maybe this isn't the place to worry about
that.

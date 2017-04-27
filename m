Received: from eggs.gnu.org ([2001:4830:134:3::10]:59480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3iSf-0003Yp-As
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d3iSe-0003Ls-He
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:23:53 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:36813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d3iSe-0003LU-By
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:23:52 -0400
Received: by mail-it0-x22c.google.com with SMTP id g66so10341007ite.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:23:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170426170553.1d45e1d7.cornelia.huck@de.ibm.com>
References: <1493211188-24086-1-git-send-email-tgnyang@gmail.com>
	<f2769605-4cd0-7f95-0409-850258ccbaeb@redhat.com>
	<20170426170553.1d45e1d7.cornelia.huck@de.ibm.com>
From: Zihan Yang <tgnyang@gmail.com>
Date: Thu, 27 Apr 2017 20:23:51 +0800
Message-ID: <CAPnP68gpK8zzOo+g9cc6YZsQoHabH3hY4aKMXcB7b=RAitZQAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/5] hw/char: remove console_exit function
 in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

OK, sorry for the confusion, I will give a new patch series. I'm not very
familiar with
the conventions so I wonder if someone could help clarify some principles
for me.
I'd like to replace all the init/exit callback of DeviceClass to
realize/unrealize,  and
convert return type of exit callback of some higher-level classes, like
HDACodecDeviceClass, to void.

My first question Is it a good idea to split these patches into two series?
For example,
one series to convert exit callback of these higher-level classes to void,
and then the
other to replace all the init/exit callback of DeviceClass to
realize/unrealize.

The second question is that should I always give separate patch for
different directories?
One  example is that in both hw/ide and hw/block, I need to replace the
init callback with
realize in some high-level classes, should I give two patches or just give
one patch for
the work?

Thanks

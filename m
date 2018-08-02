Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fl7Xz-0002Hl-3r
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fl7Xy-0000Ij-2o
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:57:19 -0400
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fl7Xx-0000IN-RD
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 02:57:18 -0400
Received: by mail-vk0-x230.google.com with SMTP id k82-v6so541799vkd.5
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 23:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ac7d377c-db69-c4ee-3d90-94700259db56@redhat.com>
References: <CAB3eZfuTdzecv2ParQmbiO6sjrUJ7tpV0HEo_2=2cYC890mOCg@mail.gmail.com>
	<ac7d377c-db69-c4ee-3d90-94700259db56@redhat.com>
From: lampahome <pahome.chen@mirlab.org>
Date: Thu, 2 Aug 2018 14:57:16 +0800
Message-ID: <CAB3eZfuJ4g3nUdthx-sMkj9vCF6F=knu5YkGjcm8EdN-E-GQnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Any tutorial to read/write in qcow2 format by
 programming way?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

I have some questions about qcow2
If I have 2 img A & B, and A is backing file of B.
Is the format(such as L1, L2, ref block...etc) different from A and B?



> No real tutorial other than reading the code and the file format
> specification (it's open source, after all).  See:
> block/qcow2*
> docs/interop/qcow2.txt
>
> Other potential resources to study:
>
> https://github.com/jnsnow/qcheck.git
>
> implements a rudimentary qcow2 image checker, although it still does not
> handle incremental snapshots. Then again, if you want to learn the qcow2
> image format, enhancing that tool would be a great asset in your quest.
>
>

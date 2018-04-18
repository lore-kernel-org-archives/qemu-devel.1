Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mK6-0004Be-Md
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mK1-0006EG-7p
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:36:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8mK1-0006Dq-3A
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:36:25 -0400
Date: Wed, 18 Apr 2018 14:36:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418123616.2zllb4nlp3fqpcqi@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
	<c5e3f942-2c0e-9809-32ae-df97eaf2b7cd@redhat.com>
	<762b3dc8-a86f-a21f-1e21-334ec46677ef@redhat.com>
	<20180418120320.GH27579@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418120320.GH27579@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

  Hi,

>        "features": [
> 	  "bios"
>           "uefi",
>        ],
> 
> means a traditional BIOS firmware with compat for UEFI (thinking uboot
> being able to include uefi support in this case)

Well, uboot is it's own world, I would write that as [ "uboot", "uefi" ].

I like the idea to list all supported interfaces in order of preference.

cheers,
  Gerd

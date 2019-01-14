Received: from eggs.gnu.org ([209.51.188.92]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1giwVo-0008IR-ME
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1giwVn-0002Zj-TW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:20 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:34000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1giwVn-0002WF-MG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:18:19 -0500
Date: Mon, 14 Jan 2019 08:18:15 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190114071815.lcvod3nr5vr5usqs@function>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
	<154743580351.25737.15317721560138541527@2d170d368aaa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154743580351.25737.15317721560138541527@2d170d368aaa>
Subject: Re: [Qemu-devel] [PULLv2 00/65] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: fam@euphon.net, stefanha@redhat.com, jan.kiszka@siemens.com

no-reply@patchew.org, le dim. 13 janv. 2019 19:16:44 -0800, a ecrit:
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=1 J=14
> === TEST SCRIPT END ===
> 
> The full log is available at
> http://patchew.org/logs/20190114000326.29847-1-samuel.thibault@ens-lyon.org/testing.docker-mingw@fedora/?type=message.

make[1]: *** No rule to make target '../slirp/arp_table.o', needed by 'qemu-system-aarch64w.exe'.  Stop.

Samuel

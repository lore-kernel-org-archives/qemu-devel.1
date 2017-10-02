Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dz31L-0006zF-Ll
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dz31H-0003YU-OB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:52:39 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:48957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dz31H-0003Wy-JU
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:52:35 -0400
Received: by mail-io0-x22a.google.com with SMTP id n69so5113351ioi.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:52:34 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.5237.1506939080.14747.qemu-devel@gnu.org>
Date: Mon, 2 Oct 2017 11:52:31 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <13D44E07-31FB-4DCB-AAA7-6EF24670BF14@gmail.com>
References: <mailman.5237.1506939080.14747.qemu-devel@gnu.org>
Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for keycodemapdb
 GIT submodule
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>


> On Oct 2, 2017, at 6:11 AM, qemu-devel-request@gnu.org wrote:
>=20
> Message: 21
> Date: Mon, 2 Oct 2017 10:56:27 +0100
> From: "Daniel P. Berrange" <berrange@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
> 	Peter Maydell <peter.maydell@linaro.org>,	Paolo Bonzini
> 	<pbonzini@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v8 0/6] Initial support for
> 	keycodemapdb GIT submodule
> Message-ID: <20171002095627.GD27086@redhat.com>
> Content-Type: text/plain; charset=3Dutf-8
>=20
> FYI, in case people were wondering, patchew successfully passed all
> tests. So it looks like 8th time lucky for getting submodules working
> correctly unless someone can break it again.....
>=20
>  http://patchew.org/QEMU/20170929101201.21039-1-berrange@redhat.com/

Using the above link I was able to copy and paste your patches to my =
computer. The problem was 'git am' kept saying "Patch format detection =
failed". Using 'git apply' was what I used instead. After running 'make' =
I saw this error:=20

  GEN     config-host.h
  GIT     ui/keycodemapdb dtc
make: *** [git-submodule-update] Error 1

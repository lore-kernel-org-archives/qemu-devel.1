Received: from eggs.gnu.org ([2001:4830:134:3::10]:57256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCitf-0007R9-IL
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCitd-0001w8-De
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:17:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCitd-0001vb-5F
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:17:45 -0400
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
Date: Wed, 17 Oct 2018 12:17:39 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Clement Deschamps <clement.deschamps@greensocs.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On 17/10/2018 11:53, Artem Pisarenko wrote:
> See my last comment in bug report. This kind of modification, even
> adapted to changed function name, doesn't solve issue.
> I thought long time that it does, but once I catched qemu with a hang.
> And of course, I wasn't able to reproduce it. So it just better hides i=
ssue.
> Take a look at alternative solution from
> QBox:=C2=A0https://git.greensocs.com/qemu/qbox/commit/a8ed106032e375e71=
5a531d6e93e4d9ec295dbdb
> I didn't catched fail with it (yet).

Makes sense (and the patch I submitted was stupid).  Clement, can you
submit the patch from qbox with Signed-off-by?

Thanks,

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMVtB-0007AN-LU
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gMVt5-0006df-MH
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:25:41 -0500
MIME-Version: 1.0
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
	<20181113101704.GB4830@localhost.localdomain>
In-Reply-To: <20181113101704.GB4830@localhost.localdomain>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 13 Nov 2018 18:24:41 +0800
Message-ID: <CAKXe6SL+CkwGmfP9bb+_RKdL3n9u959i+0AE6r0=C5uzMAGxLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: keith.busch@intel.com, mreitz@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Kevin Wolf <kwolf@redhat.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:17=E5=86=99=E9=81=93=EF=BC=9A

> Am 13.11.2018 um 02:45 hat Li Qiang geschrieben:
> > Ping.... what't the status of this patch.
> >
> > I see Kevin's new pr doesn't contain this patch.
>
> Oh, I thought you said that you wanted to fix this at a higher level so
> that the problem is caught before even getting into nvme code?


The higher level fix may need a lot of another discussion, but this fix is
just as the other things
once we did.


> If you
> don't, I can apply the patch for my next pull request.
>

I think you can. Also, could you look at another patchset about nvme to fix
some small issues.
Seems they hangs a long time.

Thanks,
Li Qiang

>
> Kevin
>

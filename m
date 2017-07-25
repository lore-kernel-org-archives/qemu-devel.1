Received: from eggs.gnu.org ([2001:4830:134:3::10]:43777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jJ-0005Gk-P7
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1da9jE-0004PD-38
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1da9jD-0004Mu-PX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 19:59:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6PNwqGq127085
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:01 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxa168kbv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 19:59:01 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Jul 2017 17:59:00 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <CAFEAcA_tLBx---taBCugWXeRuiJAyUxHdo0d5w9v782zmwOtGQ@mail.gmail.com>
References: <20170705075411.6556-1-sameeh@daynix.com>
	<20170705075411.6556-2-sameeh@daynix.com>
	<CAFEAcA_tLBx---taBCugWXeRuiJAyUxHdo0d5w9v782zmwOtGQ@mail.gmail.com>
Date: Tue, 25 Jul 2017 18:10:19 -0500
Message-Id: <150102421956.26979.11807844910746708101@loki>
Subject: Re: [Qemu-devel] [PATCH 1/5] Makefile: clean: Clean exe files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

Quoting Peter Maydell (2017-07-23 15:03:56)
> On 5 July 2017 at 08:54, Sameeh Jubran <sameeh@daynix.com> wrote:
> > From: Sameeh Jubran <sjubran@redhat.com>
> >
> > Clean exe files such as qemu-ga.exe
> >
> > Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> > ---
> >  Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 16a0430..22d29d6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -487,6 +487,7 @@ clean:
> >         rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h op=
c-arm.h gen-op-arm.h
> >         rm -f qemu-options.def
> >         rm -f *.msi
> > +       rm -f *${EXESUF}
> =

> On every host OS except Windows, ${EXESUF} is defined
> to be the empty string, which means that this will be
> "rm -f *", which is probably not what we want...

Perhaps something like:

  clean:
    ...
  ifneq ($(EXESUF),)
    rm -f *${EXESUF}
  endif

?

> =

> thanks
> -- PMM
>=20

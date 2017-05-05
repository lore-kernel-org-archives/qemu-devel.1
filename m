Received: from eggs.gnu.org ([2001:4830:134:3::10]:53128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d6ePK-00031X-4J
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d6ePF-00061J-F4
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d6ePF-00060o-8p
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:40:29 -0400
Date: Fri, 5 May 2017 08:40:23 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170505084023.6e97a2b3@t450s.home>
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA8CD467A@SZXEMI503-MBS.china.huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA8CD467A@SZXEMI503-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Why we need redirect the access to bar0 through
 the PCI config space access function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "wuzongyong (A)" <wuzongyong1@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "vfio-users@redhat.com" <vfio-users@redhat.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "Lianxueguo (Albert)" <lianxueguo@huawei.com>, "Lifei (Louis)" <louis.lifei@huawei.com>

On Fri, 5 May 2017 09:49:33 +0000
"wuzongyong (A)" <wuzongyong1@huawei.com> wrote:

[contents deleted per legal clause]

________________________________
> =E5=8D=8E=E4=B8=BA=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8 =
Huawei Technologies Co., Ltd.
> [Company_logo]
> =E4=B8=AA=E4=BA=BA=E7=AD=BE=E5=90=8D=EF=BC=9A=E9=82=AC=E5=AE=97=E5=8B=87
> =E6=89=8B=E3=80=80=E3=80=80=E6=9C=BA=EF=BC=9A15656583887
> =E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=EF=BC=9Awuzongyong1@huawei.com
> ________________________________
> =EF=BB=BF =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=
=E5=90=AB=E6=9C=89=E5=8D=8E=E4=B8=BA=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=
=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81
> =E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=
=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=
=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=
=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=
=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD
> =E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=
=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=
=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=
=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=
=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from HUA=
WEI, which
> is intended only for the person or entity whose address is listed above. =
Any use of the
> information contained herein in any way (including, but not limited to, t=
otal or partial
> disclosure, reproduction, or dissemination) by persons other than the int=
ended
> recipient(s) is prohibited. If you receive this e-mail in error, please n=
otify the sender by
> phone or email immediately and delete it!

Sorry, per your legal clause, I don't think I'm allowed to answer in
reply to public mailing lists.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daMQL-0003YD-NA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daMQH-0003OV-Pw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:32:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daMQH-0003O2-KT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 09:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A31FE7CB98
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 13:32:20 +0000 (UTC)
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4435a881-308c-6f7b-8e01-ef8f4512221c@redhat.com>
Date: Wed, 26 Jul 2017 15:32:16 +0200
MIME-Version: 1.0
In-Reply-To: <1501075650-6971-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a favicon.ico file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>

On 26/07/2017 15:27, Thomas Huth wrote:
> Most browsers try to download a /favicon.ico file from the web servers
> which is then e.g. used in the browser tabs or bookmark lists. So let's
> add such a file for the QEMU website, too. The .ico has been created
> resizing the logo from http://wiki.qemu.org/Logo to 16x16 pixels.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  If I've got the Jekyll magic right, it should be enough to create this
>  file in the top of the repository, right? Or do we need to mark this
>  in one of the configuration files, too?

The icon appears in the built site, but I don't see it if I test this
locally with "jekyll serve".

It doesn't hurt really, so go ahead and push it. :)

Paolo

>  favicon.ico | Bin 0 -> 1150 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 favicon.ico
> 
> diff --git a/favicon.ico b/favicon.ico
> new file mode 100644
> index 0000000000000000000000000000000000000000..f22440604f92468c7102b1293bcc59426f0e5bbd
> GIT binary patch
> literal 1150
> zcmaizQAkr^6vxk&tGVdTETpGpNakuH(R%P9qV-Ul4}yd~lml1Jgz6y}S|r4v2VL}1
> z53Nz8R?tIWv_~sfFJab05QA8yk=07KW!v2D?(WzBY`Y;+bjI(Vd(U_O=bZ05cSJh;
> zYHA4AdOBG}R7XTj03k%maX2EZMK_cwJ^%f}@_uj+JO`8DCg=w1K^VLQ(_lZ)Oplv0
> z-~)(*A7FuMn^W+K3iI%bfY;sv17Krq5PSuic99yp)3micjTq-(l7Mq@jv=7g0B%-l
> z6I8u9MaRCVWUTvzwWSI_;W-EEdjVTLm;+i}<kzL>(4zu%yecBj^%*UXwx9QiN#Fwb
> z26#`LH$}V8=g2Dr?Y$)9Ia?tE&pEgU-opa$fG6NPU~Q6i^ej_vQIzy`t*p<1Ww2V$
> z^+rJqaIOSx*_ZyK^{PUusg)&3Vsa*vDXZ7(SJr3!V=xO!eVg{2E%%Myb-jw%xvRNo
> zv)L4o2RW<NnlTs*ynlY5d*<F>fF$BejYn=2N`3R*!S>Ek^{~^WIGs+}<#OfP+S;;q
> zyPapj{qlK_gAtHwXlTeB?7O9`)bsr&?`QQu-)*JKJCt{H4d&aAo?6B}xOYBtFKA&s
> z@@5A7R|~qna_w>+RaCj>g`w+>Sl2ltHg<$n=ZVX*(P(5n&yT-#wrduPB{McQrZoBD
> zs@8+vs|a0-Pe`6Q;U1Y*#>emE1Azd~lWU)5Va2N9C;fiE9DFcST-#rnANrS$e-f?d
> z-l<QgB85mKB0C%op8a*8t7tV>Z8n=j!C+AK-Ca<7f(a3L7+0UYo-M{=v0^kDRXiRK
> zYX<@UU;bq+Znyh>C=`l^!{OY-#6)&@c=#jE=L!VdR*QI;Q{W=HVg6^@dsAz0=w_nd
> DdRjod
> 
> literal 0
> HcmV?d00001
> 

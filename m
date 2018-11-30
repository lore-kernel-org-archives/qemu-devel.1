Received: from eggs.gnu.org ([2001:4830:134:3::10]:34677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSiTL-0007sN-OO
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gSiTJ-00085e-2S
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:04:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gSiTI-00084e-TJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:04:41 -0500
References: <20181129121449.4322-1-jasowang@redhat.com>
	<44516b60-dafd-70e3-1638-ea38a804c8a4@redhat.com>
	<nycvar.YSQ.7.76.1811301446050.9903@xnncv>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a61a2c9d-0366-b91b-b485-bb774581a34d@redhat.com>
Date: Fri, 30 Nov 2018 21:04:30 +0800
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1811301446050.9903@xnncv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com


On 2018/11/30 =E4=B8=8B=E5=8D=885:18, P J P wrote:
> +-- On Thu, 29 Nov 2018, Eric Blake wrote --+
> | How important is this for 3.1?  We've missed -rc3.  Is this CVE quali=
ty
> | because of a guest being able to cause mayhem by intentionally gettin=
g into
> | this condition (in which case, we need it, as well as a CVE assigned)=
?


Yes, malicious guest can do this, but only with some specific setup e.g=20
with hubports.


>   Is it
> | pre-existing in 3.0 at which point waiting for 4.0 is no worse off th=
an what
> | we already are?
>
> It is a revised patch to fix 'CVE-2018-17963' issue. Earlier patch was
> included in -rc0.
>
> $ git tag --contains 1592a9947036d60dde5404204a5d45975133caf5
> v3.1.0-rc0
> v3.1.0-rc1
> v3.1.0-rc2
> v3.1.0-rc3
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
>

Yes, it could be treated as a follow up fixes for CVE-2018-17963. I=20
think we need this.

Thanks

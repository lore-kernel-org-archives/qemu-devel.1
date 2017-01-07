Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPsxq-0002iu-IX
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 10:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPsxm-0002Ps-La
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 10:31:26 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:64562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cPsxm-0002Pg-Fq
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 10:31:22 -0500
References: <20170106011023.24057-1-zxq_yx_007@163.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <7abc5512-5799-1550-fe73-3ac45d66f2dc@reactos.org>
Date: Sat, 7 Jan 2017 16:31:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170106011023.24057-1-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/display: QOM'ify g364fb.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 06/01/2017 =E0 02:10, xiaoqiang zhao a =E9crit :
> Drop the old Sysbus init and use instance_init and
> DeviceClass::realize instead
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  hw/display/g364fb.c | 40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>

Tested-by: Herv=E9 Poussineau <hpoussin@reactos.org>

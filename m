Received: from eggs.gnu.org ([209.51.188.92]:55362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKhs-0003oL-0b
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:21:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKhq-0005K5-MI
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpKho-0005IU-Lp
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:21:08 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-44-git-send-email-pbonzini@redhat.com>
	<3e4a6b11-cd87-7596-b151-f2b86426b301@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07955b6e-275e-b421-0c68-ec84e93bc23e@redhat.com>
Date: Thu, 31 Jan 2019 23:21:00 +0100
MIME-Version: 1.0
In-Reply-To: <3e4a6b11-cd87-7596-b151-f2b86426b301@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 43/52] i2c: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 31/01/19 23:10, Philippe Mathieu-Daud=C3=A9 wrote:
>   config SMBUS
>       bool
>       select I2C
>=20
>   config SMBUS_EEPROM
>       bool
>       select SMBUS
>=20
> (or 'depends on')

Sure.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e8Lrz-00005c-Lu
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e8Lrv-0003Sp-Qi
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e8Lrv-0003SC-LS
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 03:49:23 -0400
References: <20171026135814.20773-1-richard.henderson@linaro.org>
	<20171026173758.GA2334@flamenco>
	<163ef388-2b1f-21f3-5434-286eb8f3078d@amsat.org>
	<ffb0a910-c5e6-2aa3-4a4c-b9c0a25b1b9b@amsat.org>
	<dc49bcea-13ee-b299-fd07-3e1eadfd9583@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e945351e-20d3-a93e-f969-1cfc4ed4bdba@redhat.com>
Date: Sat, 28 Oct 2017 09:48:58 +0200
MIME-Version: 1.0
In-Reply-To: <dc49bcea-13ee-b299-fd07-3e1eadfd9583@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>, David Hildenbrand <david@redhat.com>

On 28.10.2017 00:54, Paolo Bonzini wrote:
> On 26/10/2017 21:03, Philippe Mathieu-Daud=C3=A9 wrote:
>>> AFAIK the only target that is so far supposed to work with
>>> --disable-tcg is i386. The configure script however lets you try to
>>> build without TCG if the host has an alternative accelerator (e.g. KV=
M),
>>> but that build is likely to fail. [ just confirmed this with aarch64 =
]
>> What about s390x?
>=20
> s390x and ppc64 supposedly support --disable-tcg?

s390x supports --disable-tcg, but ppc64 does not support it yet.

 Thomas

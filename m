Received: from eggs.gnu.org ([2001:4830:134:3::10]:54961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1e4tm5-0004rE-Qt
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1e4tm1-0007Lq-3C
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:13:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:57318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1e4tm0-0007Gv-S2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 15:13:00 -0400
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-21-richard.henderson@linaro.org>
	<20171017235325.GA18359@flamenco>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <4ba1539d-7576-54bc-1a38-46bd6f36290d@suse.de>
Date: Wed, 18 Oct 2017 21:12:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171017235325.GA18359@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 20/50] qom: Introduce
 CPUClass.tcg_initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

Am 18.10.2017 um 01:53 schrieb Emilio G. Cota:
> On Mon, Oct 16, 2017 at 10:25:39 -0700, Richard Henderson wrote:
>> Move target cpu tcg initialization to common code,
>> called from cpu_exec_realizefn.
>>
>> Cc: Andreas F=C3=A4rber <afaerber@suse.de>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>=20
> Much cleaner!
>=20
> Reviewed-by: Emilio G. Cota <cota@braap.org>

Looks like a good approach,

Acked-by: Andreas F=C3=A4rber <afaerber@suse.de>

Thanks,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)

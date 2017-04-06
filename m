Received: from eggs.gnu.org ([2001:4830:134:3::10]:34993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwAPv-0003C7-Uo
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cwAPu-0000DX-V1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:37:51 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cwAPu-0000Cj-Oz
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:37:50 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w11so64676742wrc.3
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 09:37:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <419a5b1f-5442-0105-d5f3-e2ab08f461bd@amsat.org>
References: <1491486314-25823-1-git-send-email-peter.maydell@linaro.org>
	<419a5b1f-5442-0105-d5f3-e2ab08f461bd@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 17:37:28 +0100
Message-ID: <CAFEAcA8a4a-dm5K63uJJCWW3W2JQOrmRKWFFfiyb0_v_G_yf5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] stellaris: Don't hw_error() on
 bad register accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 6 April 2017 at 17:24, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
>
> On 04/06/2017 10:45 AM, Peter Maydell wrote:
>>      default:
>> -        hw_error("gptm_write: Bad offset 0x%x\n", (int)offset);
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "GPTM: read at bad offset 0x%x\n", (int)offset);
>
>
> use HWADDR_PRIx to remove this unnecessary casts here in following change=
s?
>
> ie: "GPTM: read at bad offset 0x%" HWADDR_PRIx "\n", offset);

I don't think either of the two is clearly better for this
sort of case where the offset is known to be small, so I opted
to leave the code the way it was already written.

> either way:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks.

-- PMM

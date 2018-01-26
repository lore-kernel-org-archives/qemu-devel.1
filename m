Received: from eggs.gnu.org ([2001:4830:134:3::10]:39816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5Ro-0001Qp-M2
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5Ro-0003TT-1B
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:57:44 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef5Rh-0003P1-1T
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:57:43 -0500
Received: by mail-ot0-x241.google.com with SMTP id p36so611596otd.10
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 06:57:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3d73ed91-c1be-4d32-e3de-b945dea52ae5@amsat.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
	<3d73ed91-c1be-4d32-e3de-b945dea52ae5@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 14:34:04 +0000
Message-ID: <CAFEAcA_9H6UROaz=H91pyeSa_X11=YJHGpgnhp2H-4hujrAs7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/6] hw/arm/virt: Check that the
 CPU realize method succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 26 January 2018 at 14:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 12/07/2017 03:14 PM, Peter Maydell wrote:
>> We were passing a NULL error pointer to the object_property_set_bool()
>> call that realizes the CPU object. This meant that we wouldn't detect
>> failure, and would plough blindly on to crash later trying to use a
>> NULL CPU object pointer. Detect errors and fail instead.
>>
>> In particular, this will be necessary to detect the user error
>> of using "-cpu host" without "-enable-kvm" once we make the host
>> CPU type be registered unconditionally rather than only in
>> kvm_arch_init().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks; I already put this patch in master (commit c88bc3e0dbe7), though.

-- PMM

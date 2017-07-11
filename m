Received: from eggs.gnu.org ([2001:4830:134:3::10]:45629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUyxn-0006TQ-Vq
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUyxk-0001ua-QC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:28:43 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUyxk-0001su-Jh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:28:40 -0400
Received: by mail-wr0-f172.google.com with SMTP id 77so8380179wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 10:28:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1572293529.49604420.1499793538326.JavaMail.zimbra@redhat.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-4-git-send-email-peter.maydell@linaro.org>
	<1572293529.49604420.1499793538326.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 18:27:19 +0100
Message-ID: <CAFEAcA9Hv_C-w9hVO2C5WYw7SFOerHPsGb1-B44fQiy2Ud+CCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: Make Cortex-M3 and M4
 default to 8 PMSA regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 11 July 2017 at 18:18, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om> wrote:
> ----- Original Message -----
>> The Cortex-M3 and M4 CPUs always have 8 PMSA MPU regions (this isn't
>> a configurable option for the hardware).  Make the default value of
>> the pmsav7-dregion property be set per-cpu, so we don't need to have
>> every user of these CPUs set it manually.  (The existing default of
>> 16 is correct for the other PMSAv7 core, the Cortex-R5.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> So until now that value was wrong for m3/m4 if I understand correctly.

Correct. (It was too high, so didn't cause a problem for
guests typically -- a guest assuming 8 memory regions would
just not use the registers associated with the extra
unexpected ones.)

thanks
-- PMM

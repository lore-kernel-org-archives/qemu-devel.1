Received: from eggs.gnu.org ([2001:4830:134:3::10]:59761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dhIAh-0000qj-OS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dhIAg-0004bi-Li
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:24:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1dhIAg-0004ay-HR
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 12:24:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id s21so9711529oie.5
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 09:24:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170814095657.549d0bc8@nial.brq.redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-5-git-send-email-imammedo@redhat.com>
	<20170814095657.549d0bc8@nial.brq.redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 14 Aug 2017 18:24:31 +0200
Message-ID: <CACXAS8DmEBwYMUz_Sun30Gdm_4w1Pdd7M3CCGamHVcydjs605A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 04/28] sparc: convert cpu models to SPARC
 cpu subclasses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Hi Igor,

On Mon, Aug 14, 2017 at 9:56 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 14 Jul 2017 15:51:55 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>
>> QOMfy cpu models handling introducing propper cpu types
>> for each cpu model.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> with this and conversion of features to properties,
>> it would be possible to replace cpu_sparc_init() with
>> cpu_generic_init() and reuse common -cpu handling
>> infrastructure.
>>
>> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>
> ping,
>
> Mark, Artoym,
>
> As SPARC maintainers, cloud you please review/test patches 4-10/28.

Will look on it on the upcoming weekend.

> +    /* SPARC cpu model names happen to have whitespaces,
> +     * as type names shouldn't have spaces replace them with '-'
> +     */

Does it also happen for non-SPARC cpu model names?

Artyom

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE29C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2DC206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 08:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="bBDlhIuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2DC206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yDG-0005Vd-9R
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 03:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yAr-0004HL-Ak
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yAq-0004IR-4E
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 03:24:09 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:60560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yAn-0004HU-35; Tue, 18 Feb 2020 03:24:05 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id C5F4D96EF0;
 Tue, 18 Feb 2020 08:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582014243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygKiNDKFDlJjJQdc23/TKopV5O6BaskA2TZKUl4cJAE=;
 b=bBDlhIuzw4lptfmAw54FsXqZtBknVOVdei250bqS6R4tCUT7joMSj54UfN9/MAykhYrBg/
 hPXGNcaJ0o2YbEEa02KHj85AlX0toNwsJ9u/FYUHHgoW0Lj2CiYtAbHTmVrtfVqrxFazRZ
 6cjq+An3Ydh79x87+m9BHym9ofElsRU=
Subject: Re: [PATCH v2 04/13] hw/arm/raspi: Introduce RaspiProcessorId enum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-5-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <6bb3c20d-9ed0-f3b0-9519-1989d13fffb0@greensocs.com>
Date: Tue, 18 Feb 2020 09:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582014243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygKiNDKFDlJjJQdc23/TKopV5O6BaskA2TZKUl4cJAE=;
 b=z9Css5ZDfnWU6L6rE0w7QMpR6no10bFjHqeuI9C+fvfh1IGaMsDL9mZK0cbamE1FQ51IZF
 ZC/bnEpzy5OmBIbpuyWKC0b5zu8t2UzSv9DrBt1gkLKH0KO9q6y7caWnznR9I0m0UwOZHu
 7LKnBN82Jl49OJAKazLxK+bCPPIpD9c=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582014243; a=rsa-sha256; cv=none;
 b=snVzuQe3UDqJoEs5X4wWX25vW55S/Tfpg+c3wB5WTY2oSMk6lpcyu/pbSeWuJuGN/80/mx
 45wPO+/ixnAuc+Y+HfSZJHr6Lm9W9M2FHEPhOQ243lRXbgpgjWLxo3DCpQEshxvNrSkm3F
 wZkfBpwF3/zoR0GQiN1Ji59Q1+V7pCI=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> As we only support a reduced set of the REV_CODE_PROCESSOR id
> encoded in the board revision, define the PROCESSOR_ID values
> as an enum. We can simplify the board_soc_type and cores_count
> methods.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index d9e8acfe3b..b628dadf34 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -69,16 +69,33 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
>  FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
>  FIELD(REV_CODE, STYLE,             23, 1);
> =20
> +typedef enum RaspiProcessorId {
> +    PROCESSOR_ID_BCM2836 =3D 1,
> +    PROCESSOR_ID_BCM2837 =3D 2,
> +} RaspiProcessorId;
> +
> +static const struct {
> +    const char *type;
> +    int cores_count;
> +} soc_property[] =3D {
> +    [PROCESSOR_ID_BCM2836] =3D {TYPE_BCM2836, BCM283X_NCPUS},
> +    [PROCESSOR_ID_BCM2837] =3D {TYPE_BCM2837, BCM283X_NCPUS},
> +};
> +
>  static uint64_t board_ram_size(uint32_t board_rev)
>  {
>      assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style =
*/
>      return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
>  }
> =20
> -static int board_processor_id(uint32_t board_rev)
> +static RaspiProcessorId board_processor_id(uint32_t board_rev)
>  {
> +    int proc_id =3D FIELD_EX32(board_rev, REV_CODE, PROCESSOR);;
You have a superfluous semicolon here.

Apart from that:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> +
>      assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style =
*/
> -    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
> +    assert(proc_id < ARRAY_SIZE(soc_property) && soc_property[proc_id]=
.type);
> +
> +    return proc_id;
>  }
> =20
>  static int board_version(uint32_t board_rev)
> @@ -88,32 +105,12 @@ static int board_version(uint32_t board_rev)
> =20
>  static const char *board_soc_type(uint32_t board_rev)
>  {
> -    static const char *soc_types[] =3D {
> -        NULL, TYPE_BCM2836, TYPE_BCM2837,
> -    };
> -    int proc_id =3D board_processor_id(board_rev);
> -
> -    if (proc_id >=3D ARRAY_SIZE(soc_types) || !soc_types[proc_id]) {
> -        error_report("Unsupported processor id '%d' (board revision: 0=
x%x)",
> -                     proc_id, board_rev);
> -        exit(1);
> -    }
> -    return soc_types[proc_id];
> +    return soc_property[board_processor_id(board_rev)].type;
>  }
> =20
>  static int cores_count(uint32_t board_rev)
>  {
> -    static const int soc_cores_count[] =3D {
> -        0, BCM283X_NCPUS, BCM283X_NCPUS,
> -    };
> -    int proc_id =3D board_processor_id(board_rev);
> -
> -    if (proc_id >=3D ARRAY_SIZE(soc_cores_count) || !soc_cores_count[p=
roc_id]) {
> -        error_report("Unsupported processor id '%d' (board revision: 0=
x%x)",
> -                     proc_id, board_rev);
> -        exit(1);
> -    }
> -    return soc_cores_count[proc_id];
> +    return soc_property[board_processor_id(board_rev)].cores_count;
>  }
> =20
>  static const char *board_type(uint32_t board_rev)
>=20


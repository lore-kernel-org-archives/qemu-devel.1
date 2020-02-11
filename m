Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1AC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF03920708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBw8MYK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF03920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Q1o-000678-VM
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Q0j-0005Wg-Kk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:31:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Q0f-0004sN-Qb
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:31:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Q0f-0004rq-Lq
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VaNKXEwMV0tDB8zCUw1L2TH6c3xOnrm+JzjJpUIyzH0=;
 b=iBw8MYK6DXZjLbTgFka26JFCGvk2ZY4YXpds1Lb71FC28dmbh7buiWGWRlCZ3iVOVfgm94
 EacYVxMPGowAZpExYbishcIZcuj48ZeFN8vAP5VsD2GLmneElsbIiN/lbEO6ytl8TYM7oO
 2CTZXUd3GJgUOAqyZ0N6/TqpVfq/7s4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-2Brn0seyPbGyVQG8GdV3Rw-1; Tue, 11 Feb 2020 02:31:01 -0500
Received: by mail-wm1-f72.google.com with SMTP id g26so959678wmk.6
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 23:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WlrsEL2kKcIqmtTlPuPKIA4paN0GzZSdk3p9FG47LyM=;
 b=L1otEdpHx6qPnZr8VUlvZOT1k4ajZTylj32e7j3tKCtHlTYfC349LcxNj+vgl3PMP+
 2jD3xhPs+nyR7Y7tLvknAwAUP38SiB6yDCHoG4vU+vWzxNcbqMdFnIAtgF8ytczzxBpr
 NDMLGhqxtd/li4r1IjNik91V8GdeYXOLsbTvqVd+6l5Dd8oiq9ty50UTmffkSIBCp2AE
 VSULe3TYhNcclIaf1up/fPNu6m9+E2IOH2RAu1MdaKDcv0n7qxgZvlg1yYtC0WHG5Vic
 Cz0u6U3w+wPzJKSjGMlG4S1VQuENPbQiXja9R2WDVcHtjQrmPxT57pK5F0qRZSpjh8sF
 VJCQ==
X-Gm-Message-State: APjAAAW0lZqCsxWfSG2c6dvGEWa7GRY9FP+cLfjlOJl8wqS4JLEC5huu
 RjKyGOEaioD85+ZXPORb4VANMy+1E/L631XODttqkBT7iFypBr/HAEoc3T8J3QZsfuAcSHTp2s+
 /aoeA+6LWgnp/8GA=
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr4013235wmk.85.1581406260559;
 Mon, 10 Feb 2020 23:31:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyA5awlkLti9E1EoerRp2XU3OIrFC9fECFJW6kI3ilaq/GlrOR9UfGGCwODf8SRl6wzVsTGVA==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr4013185wmk.85.1581406260049;
 Mon, 10 Feb 2020 23:31:00 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y1sm4091156wrq.16.2020.02.10.23.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 23:30:59 -0800 (PST)
Subject: Re: [RFC PATCH 20/66] Hexagon generator phase 1 - C preprocessor for
 semantics
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-21-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <412d6d0b-1541-daf5-454c-97327ddbf51d@redhat.com>
Date: Tue, 11 Feb 2020 08:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-21-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: 2Brn0seyPbGyVQG8GdV3Rw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:39 AM, Taylor Simpson wrote:
> Run the C preprocessor across the instruction definition files and macro =
definitoin file to expand macros and prepare the semantics_generated.pyinc =
file.  The
> resulting file contains one entry with the semantics for each instruction=
 and
> one line with the instruction attributes associated with each macro.
>=20
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/gen_semantics.c | 92 +++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 92 insertions(+)
>   create mode 100644 target/hexagon/gen_semantics.c
>=20
> diff --git a/target/hexagon/gen_semantics.c b/target/hexagon/gen_semantic=
s.c
> new file mode 100644
> index 0000000..2211ae6
> --- /dev/null
> +++ b/target/hexagon/gen_semantics.c
> @@ -0,0 +1,92 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reser=
ved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This program generates the semantics file that is processed by
> + * the do_qemu.py script.  We use the C preporcessor to manipulate the
> + * files imported from the Hexagon architecture library.
> + */
> +
> +#include <stdio.h>
> +#define STRINGIZE(X) #X
> +
> +int main(int argc, char *argv[])
> +{
> +    FILE *outfile;
> +
> +    if (argc !=3D 2) {
> +        fprintf(stderr, "Usage: gen_semantics ouptputfile\n");
> +        return -1;
> +    }
> +    outfile =3D fopen(argv[1], "w");
> +    if (outfile =3D=3D NULL) {
> +        fprintf(stderr, "Cannot open %s for writing\n", argv[1]);
> +        return -1;
> +    }
> +
> +/*
> + * Process the instruction definitions
> + *     Scalar core instructions have the following form
> + *         Q6INSN(A2_add,"Rd32=3Dadd(Rs32,Rt32)",ATTRIBS(),
> + *         "Add 32-bit registers",
> + *         { RdV=3DRsV+RtV;})
> + *     HVX instructions have the following form
> + *         EXTINSN(V6_vinsertwr, "Vx32.w=3Dvinsert(Rt32)",
> + *         ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VX,A_CVI_LATE,A_NOTE_MPY_RESO=
URCE),
> + *         "Insert Word Scalar into Vector",
> + *         VxV.uw[0] =3D RtV;)
> + */
> +#define Q6INSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +    do { \
> +        fprintf(outfile, "SEMANTICS(\"%s\",%s,\"\"\"%s\"\"\")\n", \
> +                #TAG, STRINGIZE(BEH), STRINGIZE(SEM)); \
> +        fprintf(outfile, "ATTRIBUTES(\"%s\",\"%s\")\n", \
> +                #TAG, STRINGIZE(ATTRIBS)); \
> +    } while (0);
> +#define EXTINSN(TAG, BEH, ATTRIBS, DESCR, SEM) \
> +    do { \
> +        fprintf(outfile, "EXT_SEMANTICS(\"%s\",\"%s\",%s,\"\"\"%s\"\"\")=
\n", \
> +                EXTSTR, #TAG, STRINGIZE(BEH), STRINGIZE(SEM)); \
> +        fprintf(outfile, "ATTRIBUTES(\"%s\",\"%s\")\n", \
> +                #TAG, STRINGIZE(ATTRIBS)); \
> +    } while (0);
> +#include "imported/allidefs.def"
> +#undef Q6INSN
> +#undef EXTINSN
> +
> +/*
> + * Process the macro definitions
> + *     Macros definitions have the following form
> + *         DEF_MACRO(
> + *             fLSBNEW0,,
> + *             "P0.new[0]",
> + *             "Least significant bit of new P0",
> + *             predlog_read(thread,0),
> + *             (A_DOTNEW,A_IMPLICIT_READS_P0)
> + *         )
> + * The important part here is the attributes.  Whenever an instruction
> + * invokes a macro, we add the macro's attributes to the instruction.
> + */
> +#define DEF_MACRO(MNAME, PARAMS, SDESC, LDESC, BEH, ATTRS) \
> +    fprintf(outfile, "MACROATTRIB(\"%s\",\"\"\"%s\"\"\",\"%s\")\n", \
> +            #MNAME, STRINGIZE(BEH), STRINGIZE(ATTRS));
> +#include "imported/macros.def"
> +#undef DEF_MACRO
> +
> +    fclose(outfile);
> +    return 0;
> +}
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>



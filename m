Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31206C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1C20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/rqpeqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NX4-0007Yz-N6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j2NSM-0000q4-In
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j2NSL-0000St-BU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:38 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j2NSL-0000RM-5R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:59:37 -0500
Received: by mail-ot1-x344.google.com with SMTP id 77so7310872oty.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8DZUfrsptKkjr6heg9eOVdtvAibTtpCOAnIfI86EvMQ=;
 b=X/rqpeqRsv+xmW0AE7DRaG/r9BGJ1WbpWdx5jtKHE4j0ltWsHynwpCH5u8+imLaxxL
 Yx3ROf37bdJ4GTf5wGC+w5DwwMxvfDCrqG3vBOj5z5h3yILUZ1uJiJWBkbSbQc64GYoo
 nEU7kine/yzgy7viMkXZa1Vh/eYnIJg7r4FYeUane+tq2bFBYrdz9PDDvt880qy6vvpe
 9iuDekFU0b2+O1uPy84cB6KKMeYcKBAIk8sdC+znH+UDQEE94IrzQFfFNzia2crQK7jM
 7PoZ2xIrn7jHRlVU6tKCTkY8CyvzONzGfR4fO6ftJ+GbC2XyT05Kc/B+bb+jg4a423qg
 vSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8DZUfrsptKkjr6heg9eOVdtvAibTtpCOAnIfI86EvMQ=;
 b=ftSzreG7ROwgD9LlHdKidXLMS1VSni7jv9utKnH4GvdqZH9dCAMAwq8qsjg5jDcDPJ
 FUscQ1OrGlpyRQJaFwX2C0BuD9X0ul3QUN4lFvKFymWF1uWx7BvF6RPj0F70A59isPDR
 ZDujAIRrRbxqavw0dGqXVle0grk6XNw+ut7ikUM3u4GJnUwY0K+WqpngYAcg7IEQsYPj
 rZ0dtRKma1HBK/TN87GxgnfLxCjlymdOZCtqKQifT6VKuy+bH4jmy6Pyoc6gOmqtQz4H
 +zpUM9syYIV+GDCmg2DSgi0Llcuo+LEXinrh3QiflJs6eOxIht8wJAzsJwpqs2rybyy4
 i4DA==
X-Gm-Message-State: APjAAAWj6i7/bZv41I8Mp/efRy7l5syueoFgmF7siBZ8eu5QpK48x3qE
 OIYhc5TO0CGZawRfLYP3TpKjk2EH6juFH5A1AB4=
X-Google-Smtp-Source: APXvYqy6OPVZPu94jKzuGCL2z/nb67OSUbTx2ieI548rJiToSjtiC4LKkRyjRmIWAsJAzkSoQ1HkWEDIVHPH1X5xSj0=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr14358809otb.121.1581634776279; 
 Thu, 13 Feb 2020 14:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20200213175647.17628-1-peter.maydell@linaro.org>
 <20200213175647.17628-8-peter.maydell@linaro.org>
In-Reply-To: <20200213175647.17628-8-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Feb 2020 23:59:15 +0100
Message-ID: <CAL1e-=iWXDGat9dVwNEKU1JUYTz1vc-wr2f1pTNiHP-e6zpPbA@mail.gmail.com>
Subject: Re: [PATCH v2 07/30] qapi/block-core.json: Use literal block for
 ascii art
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000130ff059e7d0b16"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000130ff059e7d0b16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell <peter.maydell@linaro.org> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The ascii-art graph

Just out of couriousity, are unicode characters allowed in rst files?

The boxes could've been rendered in a much more beautifull way using "lines
and corners" group of unicode characters.

Aleksandar

> in the BlockLatencyHistogramInfo documentation
> doesn't render correctly, because the whitespace is collapsed.
>
> Use the '|' format that emits a literal 'example' block so the graph
> is displayed correctly.
>
> Strictly the texinfo generated is still wrong because each line
> goes into its own @example environment, but it renders better
> than what we had before.
>
> Fixing this rendering is a necessary prerequisite for the rST
> generator, which otherwise complains about the inconsistent
> indentation in the ascii-art graph.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: tweaked commit message, made graph still line up
> with preceding paragraph text
> ---
>  qapi/block-core.json | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ef94a296868..db9ca688d49 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -550,13 +550,13 @@
>  #        For the example above, @bins may be something like [3, 1, 5, 2]=
,
>  #        and corresponding histogram looks like:
>  #
> -#        5|           *
> -#        4|           *
> -#        3| *         *
> -#        2| *         *    *
> -#        1| *    *    *    *
> -#         +------------------
> -#             10   50   100
> +# |      5|           *
> +# |      4|           *
> +# |      3| *         *
> +# |      2| *         *    *
> +# |      1| *    *    *    *
> +# |       +------------------
> +# |           10   50   100
>  #
>  # Since: 4.0
>  ##
> --
> 2.20.1
>
>

--0000000000000130ff059e7d0b16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">6:59 PM =C4=8Cet, 13.02.2020. Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=
=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; The ascii-art graph</p>
<p dir=3D"ltr">Just out of couriousity, are unicode characters allowed in r=
st files?</p>
<p dir=3D"ltr">The boxes could&#39;ve been rendered in a much more beautifu=
ll way using &quot;lines and corners&quot; group of unicode characters.</p>
<p dir=3D"ltr">Aleksandar</p>
<p dir=3D"ltr">&gt; in the BlockLatencyHistogramInfo documentation<br>
&gt; doesn&#39;t render correctly, because the whitespace is collapsed.<br>
&gt;<br>
&gt; Use the &#39;|&#39; format that emits a literal &#39;example&#39; bloc=
k so the graph<br>
&gt; is displayed correctly.<br>
&gt;<br>
&gt; Strictly the texinfo generated is still wrong because each line<br>
&gt; goes into its own @example environment, but it renders better<br>
&gt; than what we had before.<br>
&gt;<br>
&gt; Fixing this rendering is a necessary prerequisite for the rST<br>
&gt; generator, which otherwise complains about the inconsistent<br>
&gt; indentation in the ascii-art graph.<br>
&gt;<br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org">peter.maydell@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; v1-&gt;v2: tweaked commit message, made graph still line up<br>
&gt; with preceding paragraph text<br>
&gt; ---<br>
&gt; =C2=A0qapi/block-core.json | 14 +++++++-------<br>
&gt; =C2=A01 file changed, 7 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index ef94a296868..db9ca688d49 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -550,13 +550,13 @@<br>
&gt; =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 For the example above, @bins may be=
 something like [3, 1, 5, 2],<br>
&gt; =C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0 and corresponding histogram looks l=
ike:<br>
&gt; =C2=A0#<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 5|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 4|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0*<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 3| *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<=
br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 2| *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=
=C2=A0 =C2=A0 *<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 1| *=C2=A0 =C2=A0 *=C2=A0 =C2=A0 *=C2=A0=
 =C2=A0 *<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+------------------<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010=C2=A0 =C2=A050=C2=
=A0 =C2=A0100<br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 5|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<=
br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 4|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<=
br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 3| *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 2| *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0=
 =C2=A0 *<br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 1| *=C2=A0 =C2=A0 *=C2=A0 =C2=A0 *=C2=A0 =C2=
=A0 *<br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 =C2=A0+------------------<br>
&gt; +# |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010=C2=A0 =C2=A050=C2=A0 =
=C2=A0100<br>
&gt; =C2=A0#<br>
&gt; =C2=A0# Since: 4.0<br>
&gt; =C2=A0##<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt;<br>
&gt;<br>
</p>

--0000000000000130ff059e7d0b16--


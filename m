Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF7DC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2760E20727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2760E20727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOD4-0008Kh-CK
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBOCH-0007QH-2V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBOCF-0000tc-6O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:36:16 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:25790 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBOCE-0000sQ-Qx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:36:15 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
 by postfix.smtp1.imsva1 (Postfix) with ESMTPS id C207C2BCFD
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 20:36:12 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CF7911004A
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 20:36:12 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 715AA110045
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 20:36:12 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
 by imsva1.lgp.ehu.es (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 20:36:12 +0100 (CET)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com
 [209.85.166.176]) by smtp1 (Postfix) with ESMTPSA id 3C5362BCFD
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 20:36:12 +0100 (CET)
Received: by mail-il1-f176.google.com with SMTP id g6so9811649ilc.7
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 12:36:12 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1jiaNqVjdFsRo6KxvTDKisu1XEanVxkv4DdJKCfGFgx5Rbb5Zr
 Iju1Q3jMvhV8oJIufF4y+io8YT5iK96GlwTDdg==
X-Google-Smtp-Source: ADFU+vuUR9Z++rDuKLknwkqGVytQ6Hv+vka5G6NpLB3wPl593Pz7CtLZvlFKOiEeZtU7JEE+bydh8p5T4vhNmNiKffM=
X-Received: by 2002:a05:6e02:86:: with SMTP id l6mr6565939ilm.22.1583782570918; 
 Mon, 09 Mar 2020 12:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200309191200.GA60@669c1c222ef4>
 <20200309191846.GA65@669c1c222ef4>
 <9f03379d-f4fa-2ac4-409f-123222233cf4@redhat.com>
In-Reply-To: <9f03379d-f4fa-2ac4-409f-123222233cf4@redhat.com>
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 9 Mar 2020 20:36:00 +0100
X-Gmail-Original-Message-ID: <CAGZZdDHj6nA78YYXNOpncOTQSNqWKLwTXY_ppU+REikCQcpRtQ@mail.gmail.com>
Message-ID: <CAGZZdDHj6nA78YYXNOpncOTQSNqWKLwTXY_ppU+REikCQcpRtQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/10] qemu-binfmt-conf.sh: enforce style consistency
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008a8a4605a0711d80"
X-Greylist: ACL 184 matched, not delayed by milter-greylist-4.6.2 (smtp1
 [10.0.100.73]); Mon, 09 Mar 2020 20:36:12 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No--9.409-7.0-31-10
X-imss-scan-details: No--9.409-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10--9.408500-10.000000
X-TMASE-MatchedRID: Dy1l3ZSJ5PGgBUTSh64wSUKGB4JJ2ELXO4rmf5nWGLaqvcIF1TcLYKDC
 wNPUO2EF0esWB2EIL9A00Mq8rwW7yFrSDeyzIgwokmxZMK5pEOJ5VKhuUi/rYmz3xnx8b/qRSXA
 V7ymJFINtSh+28OqKspLbJr/vknLigdV2tHym7yD1WO1NzV/CYOKBFzn2PnofzZPrNwg8/rwsWV
 dl3YcDsEFw/oCfxuNmVuDlrI9QyGZuUAMzxboz+WY0Io4Kxb86fS0Ip2eEHnyvXSmSdlcYmuo86
 dL2DqU+zhVd8sjYP1B5zdAzex5xZj+uM+1jNiHk2Di3Jj5WoRZJZ1wWm9QydPnwiU713hjF2+as
 o3fu4y+llmRnnlZqbkmWwHVGupmcT1fnfbQzVSgFlGj+sQH7737cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp1.imsva1 [10.0.100.73]);
 Mon, 09 Mar 2020 20:36:12 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Reply-To: unai.martinezcorral@ehu.eus
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008a8a4605a0711d80
Content-Type: text/plain; charset="UTF-8"

2020/3/9 20:30, Eric Blake:

> On 3/9/20 2:18 PM, Unai Martinez-Corral wrote:
> > Spaces are removed before '; then', for consistency with other scripts
> > in the project.
> >
> > Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>
> Technically, since this change is different than what Laurent previously
> reviewed, it might have been better to drop the R-b to make sure
> everything is still okay.  But I'll let Laurent chime in, no need to
> respin just yet.
>

Thanks for clarifying. Honestly, I was not sure about how to proceed.

--0000000000008a8a4605a0711d80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">2020/3/9 20:30, Eric Blake:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 3/9/20 2:18 PM, Unai Martinez-Corral wrote:<br>
&gt; Spaces are removed before &#39;; then&#39;, for consistency with other=
 scripts<br>
&gt; in the project.<br>
&gt; <br>
&gt; Signed-off-by: Unai Martinez-Corral &lt;unai.martinezcorral@ehu.eus&gt=
;<br>
&gt; Reviewed-by: Laurent Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" t=
arget=3D"_blank">laurent@vivier.eu</a>&gt;<br>
<br>
Technically, since this change is different than what Laurent previously <b=
r>
reviewed, it might have been better to drop the R-b to make sure <br>
everything is still okay.=C2=A0 But I&#39;ll let Laurent chime in, no need =
to <br>
respin just yet.<br></blockquote><div><br></div><div>Thanks for clarifying.=
 Honestly, I was not sure about how to proceed.</div><br></div></div>

--0000000000008a8a4605a0711d80--



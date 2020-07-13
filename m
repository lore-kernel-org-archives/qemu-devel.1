Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F23FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 23:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31AEE20DD4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 23:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjQgEVlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AEE20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv7wp-0005CC-GH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 19:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jv7wG-0004ml-Le
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 19:32:48 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f]:44419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jv7wE-0006dK-Je
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 19:32:48 -0400
Received: by mail-qk1-x72f.google.com with SMTP id b4so13991674qkn.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:user-agent:to
 :references:in-reply-to:message-id:subject:date;
 bh=jB4Na2I+RzzcHynLRGT1+tYGRte+XMBUQR5alBy/49c=;
 b=qjQgEVlOS3kx4yy3VIw/CbzNbgRRBQX5gx/fy1gnYtwp1ZyKwUH0q6rF7JCGcfvgzz
 MApJgn7LvDvZI6B5/EoGQME37IjEw7S+ODRNLYrCWbf7yKiKu4dG4Kp0FnohpTOk7Cw/
 KARenFihIuGwQAahUOCYTD79DWtRhEpCsZovmVwVzwWGTzk8RoRkLUea+JUTWLziRt4D
 h7+g7tuUEJClnePTGaMwxVZVA3IdItLj2Cp/SJUkku3197GHbfKd1VVGarzWl+I6iQ6x
 O5Qs4jNMPCJa5J/BcWrk4M+NtJC9UkinNErqiOm1Gp+C8gwpU/Fj459F1qenUuW7+qku
 S+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:user-agent:to:references:in-reply-to:message-id:subject:date;
 bh=jB4Na2I+RzzcHynLRGT1+tYGRte+XMBUQR5alBy/49c=;
 b=MMc3yR++AAWkzFCc7Fy3yPQpdVJbiwERqVF0P0hN1wnHMDGWywxiFcP/jCpsTfrXwz
 cnRHZBIbi6OdSb7sPdV9Bh1iyQbsAYUj1jHICjZ3C1qSXiZkzy17sGWX2Iueo9fO2rBG
 j2yKpg1coVZPJGGa+OGzp8e832Lkijwm9xUt98DDdNYfQzwZTEcYzLgysgGRr/8irxCt
 PWLbtzk36NqGDEFdy2NT+zAVbD3GHUFPTEC0EjbzrJU6mkivIOJMRUg08Ug7nfl8pAZ8
 0TnjKstg+gUft3iOvyTxFz4i/N/TDkCt3J4lvwOtWJD3hZZMGF5sPIbh8GHtzHYGKpmW
 5/Yw==
X-Gm-Message-State: AOAM532esh8uSoia29m8fhg8kfr4lELwmH90cBgywWHuUmVH2k679U26
 IyRIZpSRihmzNiHjq7ADUls=
X-Google-Smtp-Source: ABdhPJx928G0WXzReiVq69BCMfdym+xS94njloBav+ApPREFc2DoirECNswDePxVD3t7jyawW1oR8Q==
X-Received: by 2002:a37:a78c:: with SMTP id q134mr2102716qke.368.1594683164820; 
 Mon, 13 Jul 2020 16:32:44 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r188sm19352391qkf.128.2020.07.13.16.32.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Jul 2020 16:32:43 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: =?utf-8?b?5p6X5aWV5biG?= <19210240159@fudan.edu.cn>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org
References: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
 <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
In-Reply-To: <6160dba5-fd15-2467-fe53-14c391b2ce30@redhat.com>
Message-ID: <159468002764.10357.15734052139800834298@sif>
Subject: Re: cve patch wanted
Date: Mon, 13 Jul 2020 17:40:27 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=flukshun@gmail.com; helo=mail-qk1-x72f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2020-07-13 03:16:37)
> Hi,
> =

> On 7/11/20 2:28 PM, =E6=9E=97=E5=A5=95=E5=B8=86 wrote:
> > Hello
> > =C2=A0 =C2=A0I am a student from Fudan University in China. I am doing =
research on
> > CVE patch recently. But i can not find the PATCH COMMIT of
> > CVE-2019-12247 cve-2019-12155 cve-2019-6778.Can you give me the commit
> > fix this cve?
> =

> * CVE-2019-12247
> =

> I don't know about this one, maybe related to CVE-2018-12617 fixed
> by commit 1329651fb4 ("qga: Restrict guest-file-read count to 48 MB")
> Cc'ing Michael for CVE-2019-12247.

For CVE-2019-12247 is was determined the existing limits for input to
QEMU's QMP parser make it non-exploitable:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D1712834

A patch to enforce/document some set limits rather than relying on
parser error messages (like what was done with 1329651fb4 for CVE-2018-1261=
7)
might be nice, but it doesn't appear to be a security risk.

> =

> * CVE-2019-12155
> =

> I don't have access to the information (still marked 'private'
> one year after), but I *guess* it has been fixed by commit
> d52680fc93 ("qxl: check release info object").
> Cc'ing Gerd and Prasad.
> =

> * CVE-2019-6778
> =

> This one is in SLiRP, Cc'ing Samuel and Marc-Andr=C3=A9.
>=20


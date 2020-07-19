Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109ACC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 15:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCF522B4E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 15:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o2EfKIM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF522B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxAnU-0007be-1M
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 11:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jxAmT-0006Qy-Fu
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:59:09 -0400
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:35061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jxAmQ-0007MG-TR
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1595170745; bh=cdHlr7CmdSiSEtL6iwQtXL7HWcbD60Jd02zvX8wMlAE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From:Subject;
 b=o2EfKIM8C6xC2YATqS9zHrgl5DCaCEdwoO0yqCCcIkO0b77CMHE+N3uxNlkonpRnIZmGwD3/IB1jII26j7/Uj/ou87MiLHIlvjxr9F2VTmHWGWMxtC78Rkve8oskkYJS80/wrH7qW760ejhGHmmeEdCqc/DBaHghPi8Q8oCbWggd74nLXdOpikeVQaGWXCc3OIpnFVNYVLlWQyLGvvddPOPq/FdKNL8MGkG5XaDjqGshLHKjDtyBLEUrVYa1ehh8+3ewdxTQnlJmGa87OtbzY00CvK4VlkhQUZ237e9YeVrlWW1VLHmvxLGIECl2+j9HV0DIhipVzO6IKKa7gRpCDQ==
X-YMail-OSG: r5cp5fUVM1n3ycNkIy6KZVZFLt7yt6aEtldHYHjh7bLlb7pc11YtPSlpZZnlGjn
 exmrJH21KlF7jzMOlMrzWCZ9t0.5S8OCtZu65QClSGYnc38QobWJSUIbd0Mh7cQHTiXL7mLyu2Ah
 ckPBVFFnISHvy4u4jK.PQVh9rozq.bQ_SFeUFCEN59zsu2w_1.f3E9M.vmU3D7zZCkpirYJfzABN
 tBaLYcSOuB99npFHHGnOBvhb.bvuyY6yFliWLYmSLoCBzJG4dqLL0N.NcF1wgvc5G5OoyLKv2j7p
 pvD_hwNbTf2Wgj2Gu2aYI0h3J0uKva4KXw9taS5b1YZi3L9tCe_clJY8GR9R6Yb2r9RUGKa17hcj
 Ey3b3nN6PY3.VnqtWTv40C0nELtD6IkxB1FFt_vpMossvCl1mrPXajYyDci.LHKNmg_eC4Ep3DPL
 UmBz7wdIvrwIBPESa82MEQu5sjWUyKQvonpus1uHIFQVuA_Vke1o3vD0bW0WqNaQO4E27XrzyTC2
 988hI7WEoCUdZpESJcrbosxFIP8RBudeZPF5LBr4J_hsBOUGsWp.py5gUbV5YYKTzSMcp.hL09BV
 QkSVTDJqFxEjvsnAu42XoLCimeYZn9UADdBzw_BDwDJ3eQCVxzpHuonRzEPrIdq2PfPcEplH0YQd
 ODIV0YW1K.MOYWNEqNRywJt5mH32X24.CiU_4lLDkj2etn2ipZmY4s.8qHeDgAbq5OYM1Fq4Z2yT
 WLZyyI.fmc_QyDvW6aDXlTXQD4pEZZSX5SCbNu7tFWIezRTeGqbZAPUonA42D5llUalj4c98HfVN
 VP4hgvMR1WBXhl95Q4dpan0yEASV_MDIbuu7UMxuWPOlPbHYjQeKXuS53ZHilYUBjhoys5yd0zHK
 KhYfUV4vLTSOFzdRFwKLteD1qlVbJe0e9slIT_xGjJgDZbSXw1cdE6j_hRaGp9.qnrSYKN4UAvA1
 eghf1RH7t5PD4d_APkeQUfuggwLBXWjVxKhrGHCai0fjhT4tCiNRl5XLJi.H7Bd8frMFrxeVsWWT
 v1ysVoxMKAMfuDGCI7P2iBtSHG8ABD.I3nynrrHYvAzd.CNfiAGn2dctkLKPuPoE8o03umVgJGEQ
 Wepq7fU0ZjRjy3cx2AJ5fHDVNdNjqOsdELgMsjJW47HEArfx.hjjuGCzGWtsx_9DxvEuKwKDgkei
 p95VTbx4hpKa1NnftjBiC7W1CH.32.d95MFZwoPICKlYs9VmY3OIBnxHAD.Vi8au7qr5gaNHCFyT
 leG7mofzTreArLVYi_p48Yry_0PYXJ1q6knwRTJOQadcpnvIBvn8zK1.GKB6Chpvr_uc1q35zMe9
 aLfg.ysarUZ2OHSYQYShLsLY5BPjRwkBzKKwGwXNc3G1vNUr2IMHyMMCyQCHJ7i_cbN50HzntHDE
 YKxFGIg7hlA3fwztV1qgvj0.2SpxSbjId5A--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Jul 2020 14:59:05 +0000
Received: by smtp422.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 754fdc3651c69e7d8cf7dd5e3aac7afe; 
 Sun, 19 Jul 2020 14:59:03 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id z5so9112115pgb.6
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 07:59:02 -0700 (PDT)
X-Gm-Message-State: AOAM533+lacsVt++r9yVi7vNgv7H8spCLE+dIqCd4ABXDsmY9mhrZa8a
 lLaelfJmyMs7AFmEalh1CpZeXJ+oFX1kbzMy9hU=
X-Google-Smtp-Source: ABdhPJwigyF/Ke4A+Vf8n/t8ACE/PWh68slkKosFrAMemuQtwct1Ad1AGNcSaEQe83VhcgUJDbriZuQIkDcqO2023ZI=
X-Received: by 2002:a62:a217:: with SMTP id m23mr15739309pff.291.1595170741987; 
 Sun, 19 Jul 2020 07:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
 <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
 <20200719025055.kkjjiegyn4t6x64v@function>
 <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
 <20200719111602.2xeu4ise6zlbvf4c@function>
 <CAEJNuHy7s+GqUaZ_sVgr03J6ZGzK9PwZZBsu6t0Znf6p4x6+8Q@mail.gmail.com>
In-Reply-To: <CAEJNuHy7s+GqUaZ_sVgr03J6ZGzK9PwZZBsu6t0Znf6p4x6+8Q@mail.gmail.com>
From: Ottavio Caruso <ottavio2006-usenet2012@yahoo.com>
Date: Sun, 19 Jul 2020 15:58:45 +0100
X-Gmail-Original-Message-ID: <CAEJNuHwSkLjbyFa3Lj1O19=zzV-DO_dzrBz0suvX7JXuziKOQQ@mail.gmail.com>
Message-ID: <CAEJNuHwSkLjbyFa3Lj1O19=zzV-DO_dzrBz0suvX7JXuziKOQQ@mail.gmail.com>
Subject: Re: Is traceroute supposed to work in user mode networking (slirp) ?
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@gnu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
Received-SPF: pass client-ip=66.163.190.146;
 envelope-from=pr0f3ss0r1492@yahoo.com;
 helo=sonic315-20.consmr.mail.ne1.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 10:59:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 19 Jul 2020 at 15:15, Ottavio Caruso
<ottavio2006-usenet2012@yahoo.com> wrote:
>
> On Sun, 19 Jul 2020 at 12:16, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> >
> > Ottavio Caruso, le dim. 19 juil. 2020 12:07:21 +0100, a ecrit:
> > > On Sun, 19 Jul 2020 at 03:50, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > > > Ottavio Caruso, le mar. 14 juil. 2020 12:15:48 +0100, a ecrit:
> > > > > I cannot get traceroute to work with standard udp from any of my
> > > > > guests.
> > > > >
> > > > > $ traceroute 8.8.8.8
> > > > > traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 40 byte packets
> > > > >  1  * * *
> > > >
> > > > That was because
> > > >
> > > > - libslirp was not forwarding the ttl value, thus always set to 64 hops
> > > > - libslirp was not reporting icmp errors.
> > > >
> > > > I had a try at both, and that indeed seems to be fixing the issue:
> > > > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48
> > > > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/49
> > > >
> > > > > Any clues? Is this intended behaviour? Any workarounds that don't
> > > > > involve tap/tun/bridges?
> > > >
> > > > Not without updating libslirp with the abovementioned patches.
> > >
> > > Thanks Samuel. I've added a comment on the portal, but for the benefit
> > > of qemu-devel:
> > >
> > > Applying this patch on the latest qemu (5.0.90),
> >
> > Did you also apply
> > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48 ?
>
> No, because I thought that 49 would include 48. Let me give a try and
> come back. Updates on Gitlab.

Thanks.

https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/49#note_573654

When are we going to see this imported into qemu? I'm not extremely
familiar with git modules. I assume this will one day be part of qemu
upstream?


-- 
Ottavio Caruso


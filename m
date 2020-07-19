Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F6FC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E0021775
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rex/jIsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E0021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxA8V-0006Mm-H4
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jxA6w-00056x-P3
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:16:14 -0400
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:42781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jxA6s-0002tx-Oy
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1595168169; bh=WOt8dJchIfDquG/bNZO+cYESBv6KD7jFc2tinXm5uOU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From:Subject;
 b=Rex/jIsKlkFX6JbpdYKkwxHmscKMo2Uo0XDo3YHZNG+Uva9kaDdONxBj9ZgZCaqswmnxaGaItoHQO2QkIc3zA6PS46iylwHc7lHidht9qUMiASeU397PCFwMoAlZsJ477VPKjpo3boQq56M+k0y/taA/V/590e4RyHkxeQUjwKVdNcyJ8tAiMlexYj0oE1Z2gAxpEXwrbkEZeamX3JbhV70w+sFVZbLDeOI/MMCssWYkGrAzvWFyCs055zi1x5rJ6pGglqSP3O8gYvD5LYXtOVVEOXelAiUDO4Ib2Z1Z3pOla3EG1vi2BL0jmNgBVzveKqisv9i7IgVTiNKg5vxQyw==
X-YMail-OSG: iU0imdEVM1ntpds.qxHq6bdNS0WOmSWOCXjAA5hqeZ9eFc6vTZ_8nPqIqWGefL_
 v8tXI_nkgsCQ_ml7kfoWcNr2YsDjnu16XRL8P3XfhLw6oViph9bZVTY.uO1UdQfAIFLCgSTMblu0
 1mZCXZ6Ive.Ld8MlTH5t4V8SNH8hyaYlLLQenPaw1KzMBr_0RPvGj2aSOv7ScC189UfXt1.mL.mO
 6kcE2d3HQcfa_ZsFgEF3qLVOiGeI6AoNMpRSTgMbtjzSHjBqmO_Z9WGfa6m7bsgRe9.hbyPB_Cdx
 lxout2ofP4L4_B3myMdIXWwlNlbdDCIqoQ2xi1BIxelOjLny3QHj1VpMz6LjECVXe7zkoWVdBE__
 _VZeVgx0GLrtbQX8AVxfUERgeUV5kXpGDV8om3xicLqN_Jx2TV_6FHR5uHsjO3UuYddZxPeoua0A
 pSBFJA2lGJ_UPGvQKbMmJcsyDe7xd_qbaKx_xSqiTxq4DJYaOVtC2EDj8Mgdh8L6lxv7tSRwwToM
 lYGWmWnn03V0k5DFNv..qQCDQIk4dKVvHZfp49K271otbd2oZ3UjyNopObZCuogYt9Shu3zS4Vvn
 7RtUkrvJV709QTrLmRJdmlklXb1FzPDBZ2saaB44z1bSz3OjvFTlgoQ1c120YoD9i5BHPxylwsMu
 Ncqfi7CtxEIUHs617ouqzM6id4xwt5aL.T2Hmv4F1ABzAa.nNpT5bfVgOJqfKCMP0ZaSdgAW0NLx
 CK1QiN8y3cY_lrEIiKhBidKyAqzARit9rsdcGy_1ktAHJkEdw52VdwJBOx4DtEIuLBfeCJ5UnsmM
 Ua9RklQpMPa4RwKchjd8HOUUHg1hgKcHnOY5yOBHNXr7_7GokE18zMPnzhShAKkD51rRLV74Aj6Z
 q4TDinDy4JlI6vt1HKli8Ndke2q2eP9LSivTP6ipQD_mHfnpURBUysYpIeihEFuytmchbEIhNVPo
 ldAcQPhTzXZE.VMFhJ3PYz3_4VBuU_nNy9pwlR2bWBog08GBcBx0VFNwlYlnklW6JQjoxr_e9Qlm
 Tku3QZ8uU_dPcfd4LY8k6BN05f_82NYKxFmpcDK39uwhoIGDICO1wJ4OL7t821KoqBEgyTV5mkus
 6QomwrI8IXawv_YbMqu3NHSHwHjcaX4KLmqT.yV6gm1xskXr6glhoiTXJuPpJvOOWHdZSkPbyzmo
 sxO.BtPeoE9hNt59h1qhsIKqmv_OT4ugVRCqHO73S1aBOm0lgXyp4S.3F.YjStqbj4U9bBntaqwO
 7jXMDTrPjyI1SrKKxJGnBB7Lvt0w06e9naZ.KOsqxB1BZ.HC1E_5TzftEAA9ny3guvuFyfYx6HU4
 hHHLgyvat_lfPVfxUoucMNYH3Gy3dy43V1aK.7FrqmlO8Xs5C2ypx4MLTw2N2UpCmAELMX4Atcj1
 _ctrymodhpzNKMSIP6wol8L5Zsjkzn2CucA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Jul 2020 14:16:09 +0000
Received: by smtp416.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 236211cb25ae2a4e2662dbfc9a230aa0; 
 Sun, 19 Jul 2020 14:16:07 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id b9so7499730plx.6
 for <samuel.thibault@gnu.org>; Sun, 19 Jul 2020 07:16:07 -0700 (PDT)
X-Gm-Message-State: AOAM533UYzAj7GoNxJaDI4gYX5bw5juemO7UP0xZZXW1T8YnaL52PS2I
 DPFKa5X9U4s+4Vni1gCbl6vCr657bxfUrMuXPXs=
X-Google-Smtp-Source: ABdhPJxO+fLTqnV6bFfWikJdNBb3u82fVCN+6nUsxtDmLVpj/uNRm8zkDKxwT+9Vu5rmyHWRCzibKDAr07bI4ND/PZg=
X-Received: by 2002:a17:902:a388:: with SMTP id
 x8mr14318624pla.48.1595168166736; 
 Sun, 19 Jul 2020 07:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
 <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
 <20200719025055.kkjjiegyn4t6x64v@function>
 <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
 <20200719111602.2xeu4ise6zlbvf4c@function>
In-Reply-To: <20200719111602.2xeu4ise6zlbvf4c@function>
From: Ottavio Caruso <ottavio2006-usenet2012@yahoo.com>
Date: Sun, 19 Jul 2020 15:15:50 +0100
X-Gmail-Original-Message-ID: <CAEJNuHy7s+GqUaZ_sVgr03J6ZGzK9PwZZBsu6t0Znf6p4x6+8Q@mail.gmail.com>
Message-ID: <CAEJNuHy7s+GqUaZ_sVgr03J6ZGzK9PwZZBsu6t0Znf6p4x6+8Q@mail.gmail.com>
Subject: Re: Is traceroute supposed to work in user mode networking (slirp) ?
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
Received-SPF: pass client-ip=66.163.184.200;
 envelope-from=pr0f3ss0r1492@yahoo.com;
 helo=sonic301-31.consmr.mail.ne1.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 08:17:23
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

On Sun, 19 Jul 2020 at 12:16, Samuel Thibault <samuel.thibault@gnu.org> wrote:
>
> Ottavio Caruso, le dim. 19 juil. 2020 12:07:21 +0100, a ecrit:
> > On Sun, 19 Jul 2020 at 03:50, Samuel Thibault <samuel.thibault@gnu.org> wrote:
> > > Ottavio Caruso, le mar. 14 juil. 2020 12:15:48 +0100, a ecrit:
> > > > I cannot get traceroute to work with standard udp from any of my
> > > > guests.
> > > >
> > > > $ traceroute 8.8.8.8
> > > > traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 40 byte packets
> > > >  1  * * *
> > >
> > > That was because
> > >
> > > - libslirp was not forwarding the ttl value, thus always set to 64 hops
> > > - libslirp was not reporting icmp errors.
> > >
> > > I had a try at both, and that indeed seems to be fixing the issue:
> > > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48
> > > https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/49
> > >
> > > > Any clues? Is this intended behaviour? Any workarounds that don't
> > > > involve tap/tun/bridges?
> > >
> > > Not without updating libslirp with the abovementioned patches.
> >
> > Thanks Samuel. I've added a comment on the portal, but for the benefit
> > of qemu-devel:
> >
> > Applying this patch on the latest qemu (5.0.90),
>
> Did you also apply
> https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48 ?

No, because I thought that 49 would include 48. Let me give a try and
come back. Updates on Gitlab.



-- 
Ottavio Caruso


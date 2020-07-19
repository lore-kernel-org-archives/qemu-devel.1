Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF8EC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0212065F
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZllpxWnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0212065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx7BD-0003Ut-HJ
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 07:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jx7AX-00034V-Eq
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 07:07:45 -0400
Received: from sonic313-56.consmr.mail.ne1.yahoo.com ([66.163.185.31]:34504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pr0f3ss0r1492@yahoo.com>)
 id 1jx7AV-00075m-HO
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 07:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1595156861; bh=V8fQ1xunevQsFVNnLt9cZuTzmyzLxQHZCSIxoKlSoOw=;
 h=References:In-Reply-To:From:Date:Subject:To:From:Subject;
 b=ZllpxWnCIiioull4/XhPTlGFOyLmuTYhsXb5qKrep12ObNQMDSIECD32hPDU2VaOw4RyWSt9jqOn6vhi2bP3llTSFIdJxejSVWmGzNQSE4V29ILGCrzfpk4G3g7Qq4aJufqZHBqiLtI5MvUubmTPamilkBH6icAdJM5l+LiN3b1XFQL+RSgJsZb7V2DYUwGPNq+xbNJwE/9Ds80GRjLd7gv/FLztoE3nLuU76J4L/5dcO5BXe56ZemcOocU3kMUBBNiWGOKA3VSZP7cIvXGWR7NmzHyXL+loY1QIU9/wsoiz8756LpxUMxX3f8GVycC0q/N7nYaB3nypz32QI1DS/Q==
X-YMail-OSG: Xron_pQVM1kgY8hbVED2Q53FiesD7h3sM3tzvHzSbl0Y8r2Pe0eFaDpD.5fBuKp
 k8FY2FgO06iRDAu93RVr105EFGkeIrRgy.GwBGaeSVOs6SPS5LqrU0M3GAYMbpkCxeIjjKNlD4Sl
 4sGK7jPoob_2TqN95aqWzTp_znGDInnst_CIa2OY3APPIwFaFPM3HNeTLZDsdVeVSXLdf60ivWlO
 PmdedeSVO9prSAVKFxTyW2DjqRRvO7DNMv2EGAhQpZdyZbIIM2h5gmjQaJcg4VaW9r7bIvTFlYzw
 ahF105a1d8EvuMadIUqscCiwdSQgnK_oQbsZJswyw4J1SttpU8UK4ilgR6Uh7V2SBlV5njM3ORhk
 nUiQpJqBUjkXtAqeF4PxtLAkxo7FOwehsH8z0Srt69Nw8hMOmueTPRJvv6BN7XSzDY0hKTGirwRu
 CRI0_nCZKY5KHF1tUg455WG3mxtkzZPTqqQJ11GhTRs57REfVakgSjfHBDaA.ckpd_DtxtdvTwmA
 EJqIMDbKtCJAJHHhuXtO8nWNT3.5w.RRKhxbP9PREZ9bFsR4IZl0OA8_BlcEtgOW1j0uSIgRovqW
 IwosGPO5wItRCWtxp4ymMkTiZvp20hZ1vMaYGErtUmCrswrAZe3ao00gZ0dijmdyy2JWrzU8hkCY
 FPNYhhTTu8bpXuOnfjG9gL6Er0qGe1d_eC3oW.OWork.1bKMdsf.EveMhYEG6NX_pPID8x6GhzYQ
 L3TXiuDv5BAQu8cDhYa9bj3q27jViqCR3yIUtsbVwenZmi0RlBGz2RGYucNCEsz.BOkcczBW5jun
 dbsWM.F8z19uk6E4DXDoTYKEkNGPV75Y024DSH20JEz9Bci6QIBXz2YIcFCMep2F6iKxw7uDfN3q
 kzHkCQjL5AVvmiHtN972todHjxwpFdZ5787U7OtChEICYC6Zaos8ecgr6WmIw1thcMZ34Af6rAqy
 ScTI1okD84M3eWurswk5MmMy3Cr64pYSTUsFaV9Z8bw0wiDnAW_TaVkxyJsQOtymrk_kI5rjICcC
 QAhB.3GCFr3rH9tM4zFzP_JoUTF6k8PY9G4iap103ciYbVlZJNbWE9CM8uqhF1Fka8ErgHjCYdwU
 BU6Bnnua_ikRQuZfPrdVEBUGosxofdwzxxz39OyMmAPnw7qzlBUuOV82CrgbXBrVq70m5mUOcYNa
 aJuCUx4u9cOI3080v4svOjbu9aUNoNJpM0uj0m.RpTGQwI_5UnRsEMvEtx4xEeQ.cMFxbsBkeNkE
 PRQsPGzuqdNa33zr2oFpE4y4hqKGPRW8HtENHh9Ke3mmMU4M3ZRZzf4e2JepE0sHpS2Tb2rrQ5j1
 44QMBpWHXJhRE3ZXady57o2uSyRg.MeIZJekgXzKKxZYuqnRt8rYJT3HE48e1KLMmVldozruyFKL
 UFEw5qAS0fI3rmCi87rVICaiiPtzEh1oy
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ne1.yahoo.com with HTTP; Sun, 19 Jul 2020 11:07:41 +0000
Received: by smtp427.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 7bc168f2e7551a04ca0ac65915193773; 
 Sun, 19 Jul 2020 11:07:37 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id mn17so8707792pjb.4
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2020 04:07:37 -0700 (PDT)
X-Gm-Message-State: AOAM531qYuNXAnRN0LcXihvli7Rtn30aNAi66ACuKTGVLP+KduImj+9j
 fPPqRbu7ws6ysHSc8muXRz7dpkE/ysAmZDS3/oI=
X-Google-Smtp-Source: ABdhPJwimET/B8r/acDYbkmB7x53gqEzgjAW+PK4TXbmnJyQNTY0WudqBOljxoRfx1hD5CUfoDrLMWc0t7pq6k96xtE=
X-Received: by 2002:a17:90a:8c0e:: with SMTP id
 a14mr17961379pjo.75.1595156857187; 
 Sun, 19 Jul 2020 04:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJNuHy+CqveTjiCxpjiLX-D=NczSveUSDSAZyz=D5F0XvL5QQ@mail.gmail.com>
 <CAEJNuHze25wdA_Kjw8ryi+hmg0eLP8nhZMR50_2yqXPu_Jir9A@mail.gmail.com>
 <20200719025055.kkjjiegyn4t6x64v@function>
In-Reply-To: <20200719025055.kkjjiegyn4t6x64v@function>
From: Ottavio Caruso <ottavio2006-usenet2012@yahoo.com>
Date: Sun, 19 Jul 2020 12:07:21 +0100
X-Gmail-Original-Message-ID: <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
Message-ID: <CAEJNuHyYR1Vj4VaDVPLUG1dkSdzHjzbiCqq=Q+2j1tjy7kYBCw@mail.gmail.com>
Subject: Re: Is traceroute supposed to work in user mode networking (slirp) ?
To: Samuel Thibault <samuel.thibault@gnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4
 (Java/11.0.7)
Received-SPF: pass client-ip=66.163.185.31;
 envelope-from=pr0f3ss0r1492@yahoo.com;
 helo=sonic313-56.consmr.mail.ne1.yahoo.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 07:07:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Sun, 19 Jul 2020 at 03:50, Samuel Thibault <samuel.thibault@gnu.org> wrote:
>
> Hello,
>
> Ottavio Caruso, le mar. 14 juil. 2020 12:15:48 +0100, a ecrit:
> > I cannot get traceroute to work with standard udp from any of my
> > guests.
> >
> > $ traceroute 8.8.8.8
> > traceroute to 8.8.8.8 (8.8.8.8), 64 hops max, 40 byte packets
> >  1  * * *
>
> That was because
>
> - libslirp was not forwarding the ttl value, thus always set to 64 hops
> - libslirp was not reporting icmp errors.
>
> I had a try at both, and that indeed seems to be fixing the issue:
> https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/48
> https://gitlab.freedesktop.org/slirp/libslirp/-/merge_requests/49
>
> > Any clues? Is this intended behaviour? Any workarounds that don't
> > involve tap/tun/bridges?
>
> Not without updating libslirp with the abovementioned patches.

Thanks Samuel. I've added a comment on the portal, but for the benefit
of qemu-devel:

Applying this patch on the latest qemu (5.0.90), does indeed implement
traceroute, but it only reports one hop. I've tested this on a FreeBSD
guest and a minimal DSL Linux guest:

root@FreeBSD:/home/oc # uname -sr
FreeBSD 12.1-RELEASE-p5
root@FreeBSD:/home/oc # traceroute google.com
traceroute to google.com (216.58.206.110), 64 hops max, 40 byte packets
 1  lhr25s14-in-f14.1e100.net (216.58.206.110)  20.555 ms  19.981 ms  19.042 ms
root@FreeBSD:/home/oc # traceroute 1.1.1.1
traceroute to 1.1.1.1 (1.1.1.1), 64 hops max, 40 byte packets
 1  one.one.one.one (1.1.1.1)  19.722 ms  19.171 ms  19.018 ms



-- 
Ottavio Caruso


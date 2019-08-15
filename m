Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D5CC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 19:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC932083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hgTcc8Q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC932083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyLn8-0001Bt-Ab
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 15:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyLjh-0000N2-Ae
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 15:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyLje-0001pM-P3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 15:48:37 -0400
Received: from mout.web.de ([212.227.15.4]:36283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyLjc-0001mY-05
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 15:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565898487;
 bh=+3d+zfv8SHsPOVospNIl1e3p/4YlGVQYJuMy5jWEPK4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=hgTcc8Q2FPakr4eUM24gjQfmX873MIIczF8TZsH5fzyGphIUyGCV4P5W+saCI3AWV
 rVyz0n1zS/T46s3Uw8JM87KU6+XtbhU8yuvzIgTYCVz0USahLHDhhB5fG6K1x4CVgS
 vrN0oRybsvA7QIQW7nKETvZC7rlCa7eriZs39Wus=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm4jx-1iX8Rq1mNt-00Zfxo; Thu, 15
 Aug 2019 21:48:07 +0200
Date: Thu, 15 Aug 2019 21:48:04 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190815214804.69e4334f@luklap>
In-Reply-To: <20190815185737.GC2883@work-vm>
References: <20190815200815.2cffc21b@luklap>
	<20190815185737.GC2883@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DWUfYD30txV6KVEPm3wLICZ6T2VDAsXqq7ixTciikkp6+Yeqvou
 NhJEAfPtI81vfhgPsxhgGUP24rzKsNmbe0QpDlZB7oc13Fv9smMI3JjIWN1tQrViK7RwEDD
 iiVsYD+O5RSM/76og8xiPc0swDE9s2EnDXQOHEj/Bgmi9KtlQP9F6FP05ZFZyr6wyhS9z/f
 jovNZLBUJIQf6m9KdC8mQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2TZufEPh2Vo=:+2hH2roSHqsdq+8xqwaRx4
 LCMXXzyTkoAqVEG9zGLezy3EzUL3NDhX3z6esxuvjeSqWUSI/zA+KJAnvY8Vi437M79u5SUU5
 WFnVCsXlNEtmGYKXtKIkk1bAXVLN6N8ZE+SkgYYXqLHcnf49++bygDuCv9MDjmBojcZrqvzSm
 TYT6SoDpUxBYAEmRFP9Xn5Q4YNTtOGKW6+Rr068wbIfxgJIfBF6HBQ8/695+cBV+ceTvdBGS+
 8I0scghmGB/gkhS+R9w68hZSXuTF+kIq2ohxVhbGRL/MrS3eb5WF1IIvC4l3pFh2jvdlYtIg5
 EBzknVMV/0uTvytbMgf7E/6nsnpLF0MMceoCS+yhTWZNBs5v5RzE0auBqBWWoBoAVBa1L+s80
 MFm38tetCDdM65igUa4T6sq/I2Dh5RrwqPP9ybcnOhATuYMZYy7VU3l9gcAQfZx+oqv1ToGng
 zeeOlwH73dPUmCzgIlk7sOxFoY3Fm45+6r2ZhvAX6XEtIuDzORijD4QleH8nZ18BAQ/+1E+2J
 wq+7qgBF1UWCWCZpYJRzDu3W0cElxZ6hNg8ec8jNPrnxmF21zonZIVHyIi8k8oXxDxNkWGldB
 bVLRWn5FqKZv5a0pBzKTqJGWkOv3Aawrok9QUntdEzzzDFYIGyxrwatF/dbcoFe2EGSBsOsyu
 AffT4Gxa4K8OY2h/YY9ZiOBlBZLYjZEJ2uAHNdiZJrpp75q0oaTNW95cD8kO0GZLeKGgmb8Gp
 UTAOw8mkx8bx5c0iEj8vgKXR97KcsCUsjivFvij/xM95hmuWvVoCfLNRHvH0YMNhZASTWq0nm
 iaHrAh7fv5MvrO59r7hQ9JQakNnlvfFAJUyTRHOMhEoZaZ9VIAFvrVWCFbs5zrhQf9l4HIQAR
 Ugagw2n5FevHeUMT4Qgf1fTaYnFqfVJ54cgXcellkqQ669J8/sjYlVMixNedtXZJoAPIIt20J
 +V2Bx1O4VP6uXYgVZsGNxcPL3uUUpuB/sfa0YtdS4+NPeTkpHbPJY+gwSxsf+GbZRfUg4htFn
 uHuTVn91rRpHiuI03Kbmof5c0VXrMUZdX0lZGFsrlQLUbcUTJ4KZ+B79Laux42aKBs5IZTAoM
 wvfSVKPk77YEHEOUNEkJnSeUGyOHiqzUj45OhjbiZaAek4hcrNWygFCCaSl3uoP7pN3DRlDIN
 iSPeY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: Re: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 19:57:37 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > Hello Everyone,
> > These Patches add support for continious replication to colo.
> > Please review.
>
>
> OK, for those who haven't followed COLO for so long; 'continuous
> replication' is when after the first primary fails, you can promote the
> original secondary to a new primary and start replicating again;
>
> i.e. current COLO gives you
>
> p<->s
>     <primary fails>
>     s
>
> with your patches you can do
>
>     s becomes p2
>     p2<->s2
>
> and you're back to being resilient again.
>
> Which is great; because that was always an important missing piece.
>
> Do you have some test scripts/setup for this - it would be great
> to automate some testing.

My Plan is to write a Pacemaker Resource Agent[1] for qemu-colo and
then do some long-term testing in my small cluster here. Writing
standalone tests using that Resource Agent should be easy, it just needs
to be provided with the right arguments and environment Variables.

Regards,
Lukas Straub

[1] https://github.com/ClusterLabs/resource-agents/blob/master/doc/dev-gui=
des/ra-dev-guide.asc#what-is-a-resource-agent


Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D667C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289E220771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAAc3b51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289E220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Aov-000175-Dp
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k6AnC-0006U5-Su
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:49:06 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:52471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k6AnB-0000JC-3F
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 06:49:06 -0400
Received: by mail-pj1-x102a.google.com with SMTP id kr4so2598329pjb.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 03:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=HL0h/BRBdcQnrsrQO3+8yLqL/frPagkEHltCq+CfuMU=;
 b=cAAc3b51a+iKS6mtB3UtS12jAwSL4Tj9DF2Awc54aj0D6QP4fmMmtMdLT3QMFM+I8+
 nKhuqvpGzJrmUQgzndd/S5HyhffhV6oAnVrVb/tZngG1n5uWxL9cANomqUb+7vE50aCz
 KhAPknHNTdsgxwvUPdxCusNIwU98Z59yK9vLDDYJ04prBF7XNfySTOSihasEY/wQbRqN
 d3RoJJ6du/XbAGeDZArMDKGE6spUkk+H2gxJq3XqdS3uwZn658e72pfMBLKkqURfjYgX
 IYmaRnT+11ZqnsH35DCdIiBraUu/9CjQ4HqYTE6AciIVqP3BHDoYyj/fMTQ52aSprYT1
 t7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=HL0h/BRBdcQnrsrQO3+8yLqL/frPagkEHltCq+CfuMU=;
 b=WSrvl/jknOKcmwNTHerkcwpWxRlolpQ+2Lkv3lShjHWquFP5QuZ+WPNtsX0O3i5vs2
 1bIbhVYJDWUV0HcCHq3ToAVQEP9fD0oOJi64vLloc71sCEzkBW1/q2jewL8UcgTyXsMH
 obr+nzsaOype7C/tynsm2egatQyLKej/HfeE5e+3pLeAlj77YdG7vQGs+7OajuZ+Siof
 viLjwWl2PM7c022jnu8nYy0AW0BnZVY4od9aUsOI8fEAjHNV3k/8vvex+hoE8G9FKfVq
 1rjCEZSOIceMd9abdZvxTxQRZK7CgmVG+K0+pbe4kFdKmmCxIJQY6qoXBsJVGslqM2jE
 cm1w==
X-Gm-Message-State: AOAM533IlrrBgVfyCW7Le5JsvZRBXqKB7RuBEOUMhOM4AwHbEQjqCr+F
 ecxJsSlX4jafkWsjFxTfstcMEXvYufaaMFB+edIXbde0E+w=
X-Google-Smtp-Source: ABdhPJzGDEeKcUPXuPrhGyxq4yrxBAPaFzBnCshuoHdy6hyDRxF/Xg/O+0mf9KpdqKIQyyFP6W6icD8XRQzXr7QjF68=
X-Received: by 2002:a17:90a:748:: with SMTP id
 s8mr4256843pje.112.1597315742847; 
 Thu, 13 Aug 2020 03:49:02 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 13 Aug 2020 11:48:51 +0100
Message-ID: <CAJSP0QUPUSefLvHLe3+32a4EYNgsNmvzKdVBY6rXA-kA-oEA2A@mail.gmail.com>
Subject: Call for Outreachy Mentors (December 2020 - March 2021)
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, "Oleinik,
 Alexander" <alxndr@bu.edu>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Denis Dmitriev <Denis.Dmitriev@ispras.ru>,
 Anton Yakovlev <anton.yakovlev@opensynergy.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Dear QEMU & KVM community,
QEMU will apply to participate in the Outreachy December 2020 - March
2021 internship program this year. Outreachy
(https://www.outreachy.org/) offers full-time, paid, 12-week, remote
work internships for contributing to QEMU for anyone who faces
under-representation, systemic bias, or discrimination in the
technology industry of their country.

I am currently working on securing funding for this round of internships.
Let's aim for 2-3 project ideas and I will send out an update if this changes.

Please post your project ideas on the QEMU wiki before February 1st:
https://wiki.qemu.org/Outreachy_2020_DecemberMarch

Project ideas must be suitable for 12 weeks of full-time work by a
competent programmer who is not yet familiar with the codebase. In
addition, the project idea should be:
 * Well-defined - the scope is clear
 * Self-contained - there are few dependencies
 * Uncontroversial - acceptable to the community
 * Incremental - deliverables can be produced along the way

Feel free to post ideas even if you are unable to mentor the project.
It doesn't hurt to share the idea!

I will review project ideas and keep you up-to-date on QEMU's
acceptance into Outreachy.

For more background on QEMU internships, check out this video:
https://www.youtube.com/watch?v=xNVCX7YMUL8

Stefan


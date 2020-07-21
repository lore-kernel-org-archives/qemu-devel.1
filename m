Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A25C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E3206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFFIKJQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E3206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsgQ-0003Id-UN
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxsfc-0002WJ-PL
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:51:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jxsfb-00079C-1g
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:51:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so2914581wmj.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DrIPPhQhV/GWLS/R9qmGqgg2A0UPjcVb8QkS+lfQikU=;
 b=yFFIKJQpadc1IR7obaCqtzr70eQnvKSxMUvWSybwXq1KFNpiR/Piz5fcWUHpCS0JRU
 QtUznKENgS0lNFiVO33wAL9dq46dSP2OdTIlrj7zXOyg5+RIqGiXfmNsC1d7AVHrbe7W
 WsLOdF8C0IAbGiFtES5ih91/h9osqGoMMFeP8+doEwtXJEVVtM0t2N+b9feRGSXrvcOV
 8JBmlXLMc0qyPr29iDmOrbyCLKRS+Hen+4/1swB7ZFp7wcRnZZ5hqDxQCspljWvwnZ0R
 E00BJ/4ls6HePqwf95PnsJWmP83kg73LEYrnCtSPFWqtotL19U4nhZ2wQQPZTZLlo6/V
 7OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DrIPPhQhV/GWLS/R9qmGqgg2A0UPjcVb8QkS+lfQikU=;
 b=i4tkqpPx+I9hyWv7QGdb24X1152zOmyxspzGhXYBGer5Z4ZuYtdqRGDNWe2Wgx9C/Y
 eoDuIa3Jo44E/+5goGRXdmsvy8f5ePr0P2ht+v+FewwPPh+Oa44kHv16u8h5rabyuzl6
 uFhHhjf+s6qLTH5pi4XAogxzMrszstYtTJJ0yQiDq1x76/Gk33fDBx4NbzbAFph8vKGe
 0eDRHlJY0PJWRm6P2Gp3wOEwrZsYc+GPPhe7opAnOlOJ+3rbOTCafQI17rfZVA+dDMHl
 qB4AAD76jegIkWDX4COocPIaG+SkDaJVLSK3OEXIBTnve9FBlYBtBWX7rvlSlu+SMxmg
 JtZA==
X-Gm-Message-State: AOAM531wCV0+a0EbPuiSQxVJ5p3E4GUcU0rNroj7ZRta4rIlr0gOgfWh
 K210SiNZPGdxSbyNPfGXYoAgvw==
X-Google-Smtp-Source: ABdhPJzyi84GTBlaSfmQjABP75pK7jLfJsj2iJsL/FVTBAe/rVL9qNXDtXXxXxRBs0Pd7gYtLr/kEA==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr3895682wmc.146.1595339457463; 
 Tue, 21 Jul 2020 06:50:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y77sm3874270wmd.36.2020.07.21.06.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 06:50:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BB7B1FF7E;
 Tue, 21 Jul 2020 14:50:55 +0100 (BST)
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
 <alpine.BSF.2.22.395.2007171529440.1227@zero.eik.bme.hu>
 <CAATJJ0+JV0PFcPBdr5CbMnQF2FZrSe7B0g0fGmzOobHhjOdfJg@mail.gmail.com>
 <b565376b-a269-27c1-61c5-b010db963f9f@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/5] util: add qemu_get_host_physmem utility function
In-reply-to: <b565376b-a269-27c1-61c5-b010db963f9f@linaro.org>
Date: Tue, 21 Jul 2020 14:50:55 +0100
Message-ID: <87pn8pugcg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/17/20 7:24 AM, Christian Ehrhardt wrote:
>>     > +size_t qemu_get_host_physmem(void)
>>     > +{
>>     > +#ifdef _SC_PHYS_PAGES
>>     > +    long pages =3D sysconf(_SC_PHYS_PAGES);
>>     > +    if (pages > 0) {
>>     > +        return pages * qemu_real_host_page_size;
>>=20
>>     The Linux man page warns that this product may overflow so maybe you=
 could
>>     return pages here.
>>=20
>>=20
>> The caller might be even less aware of that than this function - so maybe
>> better handle it here.
>> How about handling overflows and cutting it to MiB before returning?
>
> Indeed, the caller may be less aware, so we should handle it here.  But I=
 don't
> think truncating to MiB helps at all, because again, the caller has to ha=
ndle
> overflow.
>
> Better, I think, to saturate the result to ~(size_t)0 and leave it at
> that.

So I went for:

  size_t qemu_get_host_physmem(void)
  {
  #ifdef _SC_PHYS_PAGES
      long pages =3D sysconf(_SC_PHYS_PAGES);
      if (pages > 0) {
          if (pages > SIZE_MAX / qemu_real_host_page_size) {
              return SIZE_MAX;
          } else {
              return pages * qemu_real_host_page_size;
          }
      }
  #endif
      return 0;
  }

apparently the first case of saturating integer arithmetic outside of
the instruction emulation in QEMU :-/

--=20
Alex Benn=C3=A9e


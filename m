Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C254C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6432321906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFcGzOlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6432321906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFc9-0008Nz-J9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFFZo-0006Wh-Nf
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFFZn-00015r-Ek
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:40:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:46571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFFZn-00014y-A3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:40:15 -0400
Received: by mail-oi1-x235.google.com with SMTP id k25so13902607oiw.13
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kxIIsHuIPorDlLUxOBDcH6X4UgN2KxPMkflJuW7ONtQ=;
 b=eFcGzOlCZygJlf1p+EEVH4IuViLnoP/QXni8qNyXrUCzENWM7zKKV0FJZmVvW36cxI
 enCUfqhYuBZCVysqXCAOZAvpTWHfXSFcZscNUKL2tBucCiRkxPqyzDXvwN9NP/S01Fty
 qUzZvT9vjnuNQQxyVbgGT4JKhM74KZnXNFPTAOhcEgfRYl6TapZrMtEABkThYrKvKL8w
 fXLmpVcZpaF6t3oH9SqShvx776pSNhxaYf7LGU3jIVM90BgZvA1oerGgX6yqcXA5xUws
 DXcagrNWXVhoV60hCzyEu8GPNKo+DkEr+544xu39bsBw8ky0o8CxjRl3RSDuGf0RYSFW
 lKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kxIIsHuIPorDlLUxOBDcH6X4UgN2KxPMkflJuW7ONtQ=;
 b=lsqeoScdL00FaSiOEbEtu6uHVz3L97r38N47QtVVyBXB2B8RpKJEVuaD172XpNiyDp
 9IoRj3OKow1wnWweGCfGAfGodzR5eTreZotcZk1PrTa/bCc3g/24FdiWopTBZ2hd1DwK
 hM8HnQOPdGMqqzxIWX49dXXS4SfFPERoe6+tjWMkrB1+QGMswzapinPT8O4JT5/0jEx8
 YIawtfcvaZ1nlosXmm1Wa0MLQ+FCxqiGrx2cV4JlLHpOcKVboPJpIsGNWiTHN4hRKpTH
 VJQa9sciSx6DYyWqjwSPDcDQ84p0Hkk/GWC0iz9BUDlrseHNrSI5w5LyjpsL/5bGNAoO
 Anrw==
X-Gm-Message-State: APjAAAXb4VwlL9qsJgjZTV76D2q1Kcm8XiAK/TGWHp1HjEg/PWx8czAn
 sm0+ovGGMtpRAZCi0O2Yq12GNu+0LrKPZRMlYuJxKA==
X-Google-Smtp-Source: APXvYqySOn8nL8o0y4pwH2lFYLOib+k1N9rcK2mnv+eOyuVTiX/hfi7lheTIvR0HlFDX3ZizqjA1Hic94Gt94almVWg=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr3210521oif.98.1569926414125; 
 Tue, 01 Oct 2019 03:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131955.101131-1-borntraeger@de.ibm.com>
In-Reply-To: <20190930131955.101131-1-borntraeger@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 11:40:03 +0100
Message-ID: <CAFEAcA8ooDuLxQ8rAFX1K4v3SpKqWO462+wX6pyvmuipZ20+XQ@mail.gmail.com>
Subject: Re: [PULL 00/12] s390x qemu updates 20190930
To: Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 kvm-devel <kvm@vger.kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Sep 2019 at 14:20, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Peter,
>
> The following changes since commit 786d36ad416c6c199b18b78cc31eddfb784fe15d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190927' into staging (2019-09-30 11:02:22 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/borntraeger/qemu.git tags/s390x-20190930
>
> for you to fetch changes up to c5b9ce518c0551d0198bcddadc82e03de9ac8de9:
>
>   s390/kvm: split kvm mem slots at 4TB (2019-09-30 13:51:50 +0200)
>
> ----------------------------------------------------------------
> - do not abuse memory_region_allocate_system_memory and split the memory
>   according to KVM memslots in KVM code instead (Paolo, Igor)
> - change splitting to split at 4TB (Christian)
> - do not claim s390 (31bit) support in configure (Thomas)
> - sclp error checking (Janosch, Claudio)
> - new s390 pci maintainer (Matt, Collin)
> - fix s390 pci (again) (Matt)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


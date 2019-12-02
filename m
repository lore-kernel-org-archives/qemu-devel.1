Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B09C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9F120833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O01QHXJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9F120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibpDj-0000of-SS
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 12:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibpCY-0007jd-Gc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibpCX-0001JT-AP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:09:34 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibpCX-0001J2-4V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 12:09:33 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so97315otd.9
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 09:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4Y78fvdi+nxijk60ZCF+if/ZzczwLSeFm6rRAef9Qj0=;
 b=O01QHXJvfkH1dyybknu6mu2DdNW6FSNOKuGxWd0kQVjJnFrL0AlmiNafgzoKs7ej9v
 mkXH8sZepSEmbSUhE9+XfgouufhqNHjJvV1P+IwSN5uQ6J/Y8cR7cTC7DLBTR0dSvVzd
 RSrZLCsyfQgEHVMnJnrHmIPFjKyEv/DTdac0FSxDkuZmV4xwt0QgJEd0sEaHT2TzXlbb
 twNLsQV1iICyaZ572pXL12W2LlUZe3HW86a2MOdDKPptWWypWpyZWf/Lpksjt1yILfqZ
 oWXxBhwD9jHiy7Xe5gkm2tMEw82bo6j/53TJFn42iuQOcwiT1gXuSVbkhfOzSJB407a2
 7NPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4Y78fvdi+nxijk60ZCF+if/ZzczwLSeFm6rRAef9Qj0=;
 b=RBYIeuiH9u6/LB0LZdeVIW3wOpemMkTbyPbIFIgQBp7i1d+wSajTg+WTZVljSJRJq9
 suoAcwXW8REsM1igIr0bBzHlOUw4SKrcV+q7Dl7fN8R+aGF4KPDv4e+abGbczUNxB7SD
 0HEn3nTU8q2KWeA7d1yn3lvdnoQFV48QAkOqUqe6yEGo+YtFGX6x4meHE7YdjTqhDqoF
 1Fxpq9vLCCGaGaOeTu9KYYKllWBZ6erH84UTBebHKY4IoEXaTIz5iNZBnKHSfQFHjuXS
 69gDcXXLIDVaiozwE6y6JLSVNAGB/uA7w4OifqN5ueeAFqntLd3dRIQhxCZnjExtMCnP
 H6BQ==
X-Gm-Message-State: APjAAAVHOCZvoD5UncrZLPp/oszLNIIQvljtTAV21xewNAphr0CNMbnw
 cD1eWMeLMKlYjjAPz9wD/gJ81A/4Q4dkFOSOFpw39YgagWc=
X-Google-Smtp-Source: APXvYqyi3I6tWoAtE7pXX06ozBVIpmZJ1afzfNXGlLer9f4Ag+/GQ/owbHlhC7WWH1VSPoOdD3lsFI6WJ78EwSarBho=
X-Received: by 2002:a05:6830:2001:: with SMTP id e1mr37316otp.97.1575306572153; 
 Mon, 02 Dec 2019 09:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20191202152746.32292-1-armbru@redhat.com>
In-Reply-To: <20191202152746.32292-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 17:09:21 +0000
Message-ID: <CAFEAcA8+-rmhFMFEAgR_TLXD4N6_xM2kS9NMCqdSqN2GYJ9OpQ@mail.gmail.com>
Subject: Re: [PULL for-4.2 0/3] Error reporting patches for 2019-12-02
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 15:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> PATCH 1+2 fix a crash in virtio-net failover error handling.  Failover
> is new in 4.2.  Jens Freimann would prefer this fix to go into 4.2.
>
> PATCH 3 fixes a crash in Linux AIO initialization error handling.
> Stefan Hajnoczi thinks it's worth including in 4.2.
>
> Both fixes are straightforward.
>
> The following changes since commit fb2246882a2c8d7f084ebe0617e97ac78467d156:
>
>   .travis.yml: drop xcode9.4 from build matrix (2019-11-29 15:51:52 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-02
>
> for you to fetch changes up to cb09104ea8418d9521d9a9d36ea0527b84ce51ac:
>
>   block/file-posix: Fix laio_init() error handling crash bug (2019-12-02 16:14:41 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2019-12-02
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265B5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E154520787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFmcYgxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E154520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdVfq-0004je-4D
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdVf6-00040o-Kj
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:14:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdVf5-0008E9-KF
 for qemu-devel@nongnu.org; Tue, 26 May 2020 05:14:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id f18so15684010otq.11
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0gkgpD6owwNPiuddt5DQo5wjt3o/zb+G1NpwLyRrtas=;
 b=HFmcYgxCiNfshKgiGcAX7JSr03TA/CkMUPUzl9eQSBhHAlaUxNYaXAoXQ/n+26GMSY
 kexqqpfEJRx+/RJ63riXhex2TEV+eS0e6DGSRgftq28IP9mk0ML37aQLvb6n8sOZ2TVx
 altrQtwvMmhMNu1YtE9yIREB3cBOHO2rItzS0FaWrLGu6bFUwgDYzL+Jd7j8ySQUBLyT
 Tv4ws7VX9siD8mb+YHYjLH6/BGzOHNv+oig0KC7IkNli3VlJDtNnXEH/YLZ6Sm+FqBpg
 wOEW/T1jKMlkSYkDny9HW3zysndC/h0F9KJ+qtavxUNDwjWLCdeuqobATkHvTByv9/kM
 I8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0gkgpD6owwNPiuddt5DQo5wjt3o/zb+G1NpwLyRrtas=;
 b=VRai4leMXC27upoERM95SlwbE/LSFFv2KbaW+ZqbB2QRO1uYxcTOR5aJ4cZlNaUd0M
 12CGGOrNG8qVptqVRH9Yj2rt8WkbwNabc4bl9MdNJG2MLQ7WAolklyxHsIdEG749nUcO
 levMZAaojAgQk09pALXwQ4M+V+XChn9+T+sIdkPh14S7/3SxHFZAu4vRVovpRI7A+9Fs
 G6lcnNy/roVvKOpekV2mlbelhTnaqrYBP87FbtiUKgQWlfCh1zYgtHNYzHU4KzGW203d
 5Ip14m/3FO26gRxx4vj4+UVsnKeNvrpJPUkHLZTFgZZPrvbOdoNW5R31lA2tPxsHm5HU
 cmCg==
X-Gm-Message-State: AOAM530RfLeovfgvgOu2K5XD/x9ETusiV1XjlvKJ98WwuwdJXbiSuS12
 cSbL8h2z1bGXVn7QOMzZM571OLFLvI1XjelYivPG2g==
X-Google-Smtp-Source: ABdhPJwCzXgAM2kT5OJqlfYqy8sUQyIMYFc5mOw6Zbfx9e+KdWmofYobBksVHPsTTVQyl35ohUUlUkunVtgjBYDSD1A=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr159693otr.135.1590484453912; 
 Tue, 26 May 2020 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <229ec974-1939-31d8-3516-12e7b8fee27f@redhat.com>
 <f1c43064-7a47-3fb5-8114-ff223ad9f0d3@redhat.com>
 <20200526021145.GB698@joy-OptiPlex-7040>
In-Reply-To: <20200526021145.GB698@joy-OptiPlex-7040>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2020 10:14:03 +0100
Message-ID: <CAFEAcA_i7mfuwObvP5HBbvNyRhC0-mbbfJyr7sN14wJXhAZUbw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
To: Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 xin.zeng@intel.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 03:21, Yan Zhao <yan.y.zhao@intel.com> wrote:
> so which regions should keep ops->write and which regions should not?

Devices which never need to return a transaction failure
and which never care about transaction attributes can
continue to use ops->write (this is most devices).
It's only if you actually need to be able to say "that
transaction failed" or you need to look at the attributes
that you have to implement write_with_attrs -- there
are a lot fewer of these.

(You could argue for a refactoring where we drop the
old ->read and ->write methods on devices and then
rename read_with_attrs and write_with_attrs to read
and write, but unless we can manage to do it entirely
automatedly it seems like too much effort to me.)

thanks
-- PMM


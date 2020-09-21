Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28EC4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F47620757
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2yFnhG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRN0-0001th-IS
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRL2-0000Hv-48
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kKRL0-0004Ex-JD
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:18:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id d4so562177wmd.5
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HDGtmb0FzSdG4pRK5vqTuQi0l6jpz4LteZtknagN2Ks=;
 b=h2yFnhG4Wq+VLdirIdRdh3AEdIs6B/1KV47Q//01ZXSrtKhSqyC9/aCe7tfPJtJpmN
 VYfJIQXwUncotnbAlbWH0awpWgWZyn5SQ8AhezmwkCevzfK+IkbsPYFGrGhtN4zvIB1B
 YvMfZDuR26WUfdgMsciC7qApXyG5NJOZjsIkW9oUGUKLm8hKZAGVn9npAORvwIJw4i4E
 YkTFTMeypMy27AMxTLut2i+k5h1IVjz6l2+69BKE7cw9Rbq8sodmkQWcOHFsvYL0WKo4
 ZhfB5GtmhykcNpuvVwGMyFAH8K5HsNxkbyZ61Q2InqEYK8sIAy021EbDBGFQI8yuvj9X
 4ISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HDGtmb0FzSdG4pRK5vqTuQi0l6jpz4LteZtknagN2Ks=;
 b=X4v4VAc6Si24vjSQYDZ6UxJWzfUXW6Ko+C3rR6GJvm1BYgDxQBDcqQIfw9l+EH4QhM
 AVvh328kQyA9GWyaQjvksKYRtezwnb4ewsFLp2MGvthWJN0uQkav6lXeWzKppZAXuaGF
 MYWqYv1rp+b8+tI2f0ercK9REMF/9MXy9RQak4173O6pxlV+tYhhFYRa793nmJUX9gs7
 7GZpX4iWfeZKC6VHzhOmLVf7aElYcs8A+b3zShAzKGCuQLX9lR3UrWdCDRB5otocHum8
 YapVcqEjgGfr01yK6Iznsf0DRDJ+fmTvWWVKqSszWo59ArLmljmBHSTZykdXx2xCUQCJ
 RxXg==
X-Gm-Message-State: AOAM533eQNZpjK6UP98LjNyU9mtTUiwOl+Efwosn2Owdu3fK5/etXcYi
 Imo2SLBTF5yWBe8Vkg/BtcOqQA==
X-Google-Smtp-Source: ABdhPJzx9/QriHfkKoqu/nHfA17pN+sW+VWiNx87EznAaCvX5Gz+zw5tOyBqYua9VDAt+FKYQ7B6AA==
X-Received: by 2002:a1c:a593:: with SMTP id o141mr846474wme.88.1600715937020; 
 Mon, 21 Sep 2020 12:18:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u186sm784402wmu.34.2020.09.21.12.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 12:18:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A93C1FF7E;
 Mon, 21 Sep 2020 20:18:55 +0100 (BST)
References: <20200921174118.39352-1-richard.henderson@linaro.org>
 <20200921174118.39352-3-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 02/11] capstone: Update to upstream "next" branch
In-reply-to: <20200921174118.39352-3-richard.henderson@linaro.org>
Date: Mon, 21 Sep 2020 20:18:55 +0100
Message-ID: <87imc7ndk0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This branch contains a number of improvements over master,
> including making all of the disassembler data constant.
>
> We are skipping past the 4.0 branchpoint, which changed
> the location of the includes within the source directory.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


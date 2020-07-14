Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7CC433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7C42075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQyVBF/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7C42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNZC-0003M9-IL
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvNYO-0002vO-Hj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:13:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:40734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvNYN-00018j-2F
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:13:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id f2so22755675wrp.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mqmjr9JCh2+xBVHWyqNODiT5fEo/BMOPiQrMbt7ZtkQ=;
 b=xQyVBF/j66BjEcCpf2uv4UpWzGRg0sQnmmXMgWvg485CiRgRriAy5Z0lBTfytRal+9
 DMdEqnZOpWc00C40ri4veGimqjmbyBNDx0TYgWlXjBVxmXJWxfWs93HSO2hegmDBls+P
 22AkVrLERljtvZYZCKx9gQBrr39ICw3aMkosh/f2ceFu3N57arlh3qgBhX3Xyj87Usb6
 rd597yCEzS0+EvnFbe3jKilRoZSS1/iJgdNJmyw/hGrud4x4k4W2SusxpS7nPUTSNQrX
 2dM1D/+TdGFmrOVfJBL24pd/Wc1njv5QvHR8EqPI9/pxLCz3UC5xK7tWKN13wyjehcZg
 Ge1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mqmjr9JCh2+xBVHWyqNODiT5fEo/BMOPiQrMbt7ZtkQ=;
 b=ceTj8umcW7c21k8fE8FhdBYDRxyE2TwEKjJ7b6JsiAT93Rpr52R24IriWhnDsVHAeC
 GCEL8G9faMg8rEWY9+EYoP1iXJ7/pvFP3TaaLc05g/3hDUlKDdu8kJPVN/orlRqA0D+8
 cQ4GmsZKhfywe7RxKIBpHsxg2HagApQMSfHmcZDIFZO7beRCDDzYV9YTCx5tcjX0lTUZ
 j5msk0AuSsQlmCkG++zFWIhU+V4IzYdz6w2Q/OVhxVbpXvTn2x53T5PIq3BKuTHlCLQ1
 m8U8z5eaFv1tAPDGXdOc0trrQAfU560nL8uglcxXeJk25/tn3PZNrjDkkIGzWSwtEGHS
 1OFA==
X-Gm-Message-State: AOAM532IDokcNQNoFqxBLsbgGdOLCG5TO6DAwjIwiVyfjowafIUZYvzP
 sS2vpCOrJFrW8sH+l5Nhc4yy5luCxu8=
X-Google-Smtp-Source: ABdhPJykF8IlE/6epScq11t+YpeYVHQulE2FT9+kVf5rhYDkGIrX+A0Z1+ZLP1HaPTwX/6604EQOIw==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr6640254wrw.223.1594743189461; 
 Tue, 14 Jul 2020 09:13:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f186sm5044979wmf.29.2020.07.14.09.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:13:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7985F1FF7E;
 Tue, 14 Jul 2020 17:13:07 +0100 (BST)
References: <677CC4AB-A8CA-4A8D-9295-CAFFE518C171@icloud.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?5rKI5qKm5aej?= <shen.mengjiao3@icloud.com>
Subject: Re: How does the TB chaining works?
In-reply-to: <677CC4AB-A8CA-4A8D-9295-CAFFE518C171@icloud.com>
Date: Tue, 14 Jul 2020 17:13:07 +0100
Message-ID: <87y2nmxegc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E6=B2=88=E6=A2=A6=E5=A7=A3 <shen.mengjiao3@icloud.com> writes:

> I just see the current TB=E2=80=99s code pointer given to prologue which =
works as function call. But how to jump to the next TB to execution instead=
 exit the execution and entry the prologue again?

The first time a block is translated it will exit back to the main loop.
After the next block is translated the previous TB is patched via
tb_add_jump which calls tb_set_jmp_target to set the target TB.

Computed jumps or jumps that cross page boundaries are generally handled
via the lookup_tb_ptr helper function.=20

--=20
Alex Benn=C3=A9e


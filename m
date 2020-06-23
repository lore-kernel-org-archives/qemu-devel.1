Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BE4020706
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CS82UkBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE4020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmtl-00015J-IL
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmsj-0000dm-Cu
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:38:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmsg-0001wf-Qb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:38:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so2890298wmg.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6BkN4sx4WII6guuMnuJiMCrhXFwG8xFcWPHEEw/ercs=;
 b=CS82UkBbb7ERGS0dM0DkHpqtZWWF906qwXo5DFW8L74b8MXXrRztdZFLKd7KvhO5Rh
 1pc+nXgrYCpqAswBKRqj3L/1EoDVXhDEWEk+kilEFBEOwEnKl2dNQ9UwK33QPULAOski
 9Xwp9QU34MCr4N12hpCWWCVolEiF/DdunvvMv4r02Q9e45+XcKAqo+xOEtX+ElV3RrMc
 W12GxP7M/a6ADALTgSKK7pkw0PZPWIircToVpXSMI93X/MJJxhqBp4j4ketgly52Ulpr
 V1gyZpYQgy7yAfZ3azzMWlLT+hPOubymWuKNMTJm85hu5g/Ijr/yU7ZGqcv/hxAmUUky
 h6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6BkN4sx4WII6guuMnuJiMCrhXFwG8xFcWPHEEw/ercs=;
 b=d1AJZ0sQE6HDTJ1Gj7DBbSsrarsoJ4NA/cInsTvINxl6TklArEoza4dEp/DBxelYBx
 ynE7ie2p55cgBEJlHcbsI4anUJidmst4AjcMqPoVrh4VDwSmWc7aM2CoRrJr93PwEhxo
 UDuW0i5wfcb82zDyUmfW0o+1mi+O2My3sbKbFMpmS1XOLwm/vzW9DKDvRcBi8Qd0Zlsm
 g41ITXrYCGlv2MQb0IUmByt+wuV+RMJaKC0XOv4f+jAz5EyQMZ2MY92fwpcIfhkosxd6
 9TS36WbKmgh3HPHTl63jSJeYUQBWli3hYgoFfOaCHTDVG8GK7neOBb+OaPQ+jqlO2X6Q
 tP9w==
X-Gm-Message-State: AOAM530CokCCQ9HOU5/f5JKEGy+stzSWoOqqX+Lr9ylJrNfX+kvHPrig
 PqD8N0JyKA518p8Nk39T979r/A==
X-Google-Smtp-Source: ABdhPJyGBR3QxcYfX9IGSQRdoiZl37ApKtSkRhXj1P7BUYcEI9moIbtLc9IND1RNRmqCgg0KvcDkaQ==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr6816339wma.129.1592933925175; 
 Tue, 23 Jun 2020 10:38:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm1099072wru.9.2020.06.23.10.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:38:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7E811FF7E;
 Tue, 23 Jun 2020 18:38:42 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-25-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 24/25] Remove return value from reginfo_dump
In-reply-to: <20200522023440.26261-25-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 18:38:42 +0100
Message-ID: <87v9jh7kd9.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


Richard Henderson <richard.henderson@linaro.org> writes:

> No uses actually checked the error indication.  Even if we wanted
> to check ferror on the stream, we should do that generically rather
> than per arch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e


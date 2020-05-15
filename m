Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D4720727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4qUKqOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D4720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZe3u-0007nh-6B
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe3G-0007O9-RT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:23:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZe3F-0008O9-OZ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:23:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id l17so4444888wrr.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qqXDdCQ3ckyXSmG8R13rlRlNYQGZftPGPxDnAFlaEeA=;
 b=I4qUKqOchqkv+e9VkXpedu5dfyxpUqC3nlitGjfA/E5FQnTqWQisQ4PXWQaNSX5n8S
 ue+GPlwLFVCn+Pifm1ZdVSNUl9uSrDqY6OYQEDu7M6HFYR9UY/xL6Jg0/CJcrjj6vZD1
 5VZxrIQ4oSAwiLjhUMGTlHBtlgFEr5eRURdHtxQzw+Tt9Vv3UnCGBALNMkZJqFgDRiWM
 MvO+okJwRXw/5k8hkcK3+xj3Xqr780dCqB8pm7wW/A+bbVv+0VU1iNickT7R3idky5ve
 MoIVzZo+2k4qS1dMsHqquchkLzt6O1HxkKoAfzAIFlPQ8O/VqVnX7Et9pB+9SE02uvAQ
 ukMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qqXDdCQ3ckyXSmG8R13rlRlNYQGZftPGPxDnAFlaEeA=;
 b=G72dWd5nPBCcDxg7FpzMismeXS3OsKjSOuzP/V2mhEavNiouEOYz+cNGNylhOOj2a3
 YmcSAH0TLjyUTaRhMlSBiQ/yjGoEtVGeQqxdtbJNkx1t8zvtBio6NDGxKnldK4G07uxA
 q7oDiwm5YAiRhwE4v4YZaGtv3aXHfnkrroXXgJc2aTFhH4jjqVNygAOVbDXAxrALrsK5
 GHhP8MUUaP9ITphZGBWTCoTnhJ02EZ/n+YCBD893WJTYU85Y7qJjmcN6u8nucgftsNQs
 Ml3fcz6NmwNvQtchZdgckXg7S6li5k9lIGO38AceMyWIsjH9iJaQ2/MqmBnAowzro6X8
 uMCA==
X-Gm-Message-State: AOAM531IH1qnmUGbNszx1TKR8MQDt/sGYC0jgc9tDIUKExDjIAHbWERP
 bNchP6VZZk4OltQb4h0PtNIFZA==
X-Google-Smtp-Source: ABdhPJxcJ0VVEI7gbr2eaPpdST6WVk+EP+cBovwNiuOwlpmuBec6kF+oJJXkfy/Ypz7rm9buPdHYTA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr5289267wru.62.1589563389208;
 Fri, 15 May 2020 10:23:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x184sm4510607wmg.38.2020.05.15.10.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:23:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE6D71FF7E;
 Fri, 15 May 2020 18:23:06 +0100 (BST)
References: <20200512193340.265-1-robert.foley@linaro.org>
 <20200512193340.265-2-robert.foley@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v6 1/9] tests/vm: Add configuration to basevm.py
In-reply-to: <20200512193340.265-2-robert.foley@linaro.org>
Date: Fri, 15 May 2020 18:23:06 +0100
Message-ID: <87zha9az9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added use of a configuration to tests/vm/basevm.py.
> The configuration provides parameters used to configure a VM.
> This allows for providing alternate configurations to the VM being
> created/launched. cpu, machine, memory, and NUMA configuration are all
> examples of configuration which we might want to vary on the VM being cre=
ated
> or launched.
> This will for example allow for creating an aarch64 vm.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
<snip>
> @@ -61,19 +86,30 @@ class BaseVM(object):
>      # 4 is arbitrary, but greater than 2,
>      # since we found we need to wait more than twice as long.
>      tcg_ssh_timeout_multiplier =3D 4
> -    def __init__(self, debug=3DFalse, vcpus=3DNone):
> +    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone):
>          self._guest =3D None
<snip>
>                                     else logging.WARN))
> -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs, config=3Dcon=
fig)

Given the number of times I've just had to fix merge failures with the
patches I've just sent I wonder if we should just pass args as a while
to vmcls and be done with it?

>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
>                  sys.stderr.writelines(["Image file exists: %s\n" % args.=
image,


--=20
Alex Benn=C3=A9e


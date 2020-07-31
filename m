Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8320FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D89D2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9wLsEV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D89D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1XE8-0002At-Gx
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1XD9-0001EX-HR
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:44:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1XD7-0001gn-3V
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:44:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id x5so8898989wmi.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1NYpUqU0m8gseMafnU6ZZ9hI2VDqh8nRMV7j1ON+eBM=;
 b=q9wLsEV1Rk86emsF/ZMka41GeXSH8p2UuNxu72NK83TrraoBOj3KbElFDqyWMg1Y2g
 j8+WWomQ3hG03JaVGL7Bhmm0jpbWFfAhnVv5wr9afd9LWsDuoy57zt2jtf7n4HCFenNG
 S85eCT7lkHJhQztLKwwXArDfMi2EmCLZ36ZFzeSG1qK63Tnq3BN7uA/TbDS06o4PpFvl
 pQ1h9esrDazcp3tURnh1t+RofCZAjt149XtCdfM2+xT+XZ3rFt1MU9/vF5i7q1/lc7vd
 JqD9po/Kd3CQQhRU7oPS2q3PBy4eMa/ZE625Ijs+kfu6j+QvY1FeO5AOInX4b2YoBeWo
 pVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1NYpUqU0m8gseMafnU6ZZ9hI2VDqh8nRMV7j1ON+eBM=;
 b=dYHhNWYTTpjpXZhOpM6KFmg8UQLzg4gKO5S9+O14NY4QdnbXwbadhGwhdgSbragIWY
 T5eICncx/esVXx1DpUHVhtrzP0flMIZOWHRwUXOPJVrIQjz9lZcqjqNLI364839EZH9b
 pxBMps3wyMpCSulLmjVq73dl3MXHJPH/KKMU3I4F0Lf7J1X/Ws32K0qEhMePvefzXre3
 mhFnQ92q/9W1mXqpE+QZpn8/2PvMQExfppzZ5khcsQxMuJ3l+JCcVu+CNOyrvIu6WpUB
 Kr/LkM6eMBXJk1fgpJDpfY80PXCF95yC0fhLbXcvG5GOqKRlFEwwFEr2K/tSFsSv8xJa
 VVKA==
X-Gm-Message-State: AOAM532+l6N3FQ1JB5ImyMon/DeMlYeV2UWe0ndH+ASeB2XGTdkvVTg1
 KJuUF5rGgTS860RTSAZisOVIvw==
X-Google-Smtp-Source: ABdhPJwhf6SCj36hK7ZvgS64rGdD6hgF4XvKN/y4k6M39iiUOCVksDr6o5wKsJmPgR7W23rm4JetFQ==
X-Received: by 2002:a7b:c5c5:: with SMTP id n5mr4404346wmk.103.1596210278258; 
 Fri, 31 Jul 2020 08:44:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w64sm12242643wmb.26.2020.07.31.08.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 08:44:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2DCB81FF7E;
 Fri, 31 Jul 2020 16:44:36 +0100 (BST)
References: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Pincus, Josh" <Josh.Pincus@windriver.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
In-reply-to: <DM6PR11MB4331B490586462DE7353E0B8F9710@DM6PR11MB4331.namprd11.prod.outlook.com>
Date: Fri, 31 Jul 2020 16:44:36 +0100
Message-ID: <87ft973d0b.fsf@linaro.org>
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
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "zhabin@linux.alibaba.com" <zhabin@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pincus, Josh <Josh.Pincus@windriver.com> writes:

> Hi,
>
>=20=20
>
> We were looking into a similar enhancement for the Virt I/O MMIO transpor=
t and came across this project.
>
> This enhancement would be perfect for us.

So there is certainly an interest in optimising MMIO based virtio and
the current read/ack cycle adds additional round trip time for any trap
and emulate hypervisor. However I think there is some resistance to
making MMIO a re-implementation of what PCI already gives us for "free".

I believe the current questions that need to be addressed are:

  - Clear definitions in the spec on doorbells/notifications

    The current virtio spec uses different terms in some places so it
    would be nice to clarify the language and formalise what the
    standard expects from transports w.r.t the capabilities of
    notifications and doorbells.

  - Quantifying the memory foot-print difference between PCI/MMIO

    PCI gives a lot for free including a discovery and IRQ model already
    designed to handle MSI/MSI-X. There is a claim that this brings in a
    lot of bloat but I think there was some debate around the numbers.
    My rough initial experiment with a PCI and non-PCI build with
    otherwise identical VIRTIO configs results in the following:

    16:40:15 c.282% [alex@zen:~/l/l/builds] review/rpmb|=E2=80=A6 + ls -l a=
rm64/vmlinux arm64.nopci/vmlinux
    -rwxr-xr-x 1 alex alex 83914728 Jul 31 16:39 arm64.nopci/vmlinux*
    -rwxr-xr-x 1 alex alex 86368080 Jul 31 16:33 arm64/vmlinux*

    which certainly implies there could be a fair amount of headroom for
    an MMIO version to implement some features. However I don't know if
    it's fully apples to apples as there maybe unneeded PCI bloat that a
    virtio-only kernel doesn't need.


What are the features you are most interested in?

> Has there been any progress since Feb, 2020?  It looks like the effort
> might have stalled?

I can't speak to the OP's but there is certainly interest from others
that are not the original posters.


--=20
Alex Benn=C3=A9e


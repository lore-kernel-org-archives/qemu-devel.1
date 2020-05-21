Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E912C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3312072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnaZsjep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3312072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboyk-00044J-2I
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jboRu-0006tQ-TA
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:53:40 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jboRs-0008WR-1f
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:53:38 -0400
Received: by mail-ej1-x641.google.com with SMTP id h21so9675835ejq.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+1miga9ogLLOn2cfQOxdPsZTYfR25BOk5zO9I4zkgD4=;
 b=bnaZsjepusapG0fevePVmrop/yXv5IYsl2UPExN3y5J09TIAjWbEa4dv+eOjbIfy8i
 PAalLt3NF78IhELeNRpPCXNDXiB9+oOv2F7p9jnDqDy0nrqU5OSF2wYjiXYqcv5ieiGP
 Vvm6i5TEkkARK+HVW4F1QzEMyTfn2OIMmq5/DXEXF20oiRab1XhDrUwrZYz8IlU0ju4x
 s5nS67WABE5Hk7X04uEkiNVF7rgNNI7rMX+wCfFgL06KRhbacA9umoFnovXYibg4UeYP
 Kx1jonrooizOw1qB2KDD9bi9w800DD+tps1t5aJYKseRrVpEljHKbCFAWnSTWXmqYlp/
 cAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+1miga9ogLLOn2cfQOxdPsZTYfR25BOk5zO9I4zkgD4=;
 b=Ve9IF1vxGwEBQE1JUywxzmMU/H+/sgCBdCqxtFXNmQzhaWl/8Au0b6fSfa3TZDZ2Pl
 T6RN2PoIddLXnvRqScDC0wK8hyXkvW4Et5CTd1EUW9xcwIqaXaIVahNACNfJug6ceZXz
 36tL69qprnk/Gut4LDkGCowBqoyv7EjH37g8h8/Oiq0ToGZnTSZeRf7xwk0CGyt5W7PQ
 nrljm2cog3M16XdAi9lv5MPVg9H+hYje1fACS6NaSNK4aPvH/u/k9q3je6nw9DwoNGVM
 Lqr2CaIJeyPak11vNy+UhYGujXQQkLo3rYKdyVsQ5KUgKwoAPM7QwAviJgt8AzUH/X2V
 yvPA==
X-Gm-Message-State: AOAM5309e/KZ35jeoHg40P+j/Yq6x2xc5ergu77xoydk7n4bSCvRk5Fw
 5ixoGRrgIPG7OE7lQergXpO12g==
X-Google-Smtp-Source: ABdhPJx559UsZdeJN/Ry5rUuejQTYgmW2mEAHfAgUE+rCpqfXTovXiFZeGeQJtBFFI5FFeLtfWcQfA==
X-Received: by 2002:a17:907:39b:: with SMTP id
 ss27mr4353887ejb.209.1590080013627; 
 Thu, 21 May 2020 09:53:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w11sm4771711edf.32.2020.05.21.09.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:53:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5AA3A1FF7E;
 Thu, 21 May 2020 17:53:31 +0100 (BST)
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <5ddc4ca4f32bfab8971840e441b60a72153a2308.1578407802.git.jan.kiszka@siemens.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC][PATCH v2 2/3] docs/specs: Add specification of ivshmem
 device revision 2
In-reply-to: <5ddc4ca4f32bfab8971840e441b60a72153a2308.1578407802.git.jan.kiszka@siemens.com>
Date: Thu, 21 May 2020 17:53:31 +0100
Message-ID: <877dx5fcvo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This imports the ivshmem v2 specification draft from Jailhouse where the
> implementation is about to be merged now. The final home of the spec is
> to be decided, this shall just simplify the review process at this
> stage.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  docs/specs/ivshmem-2-device-spec.md | 376 ++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 376 insertions(+)
>  create mode 100644 docs/specs/ivshmem-2-device-spec.md
>
> diff --git a/docs/specs/ivshmem-2-device-spec.md b/docs/specs/ivshmem-2-d=
evice-spec.md
> new file mode 100644
> index 0000000000..d93cb22b04
> --- /dev/null
> +++ b/docs/specs/ivshmem-2-device-spec.md
> @@ -0,0 +1,376 @@
> +IVSHMEM Device Specification
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +** NOTE: THIS IS WORK-IN-PROGRESS, NOT YET A STABLE INTERFACE
> SPECIFICATION! **

Has there been any proposal to the OASIS virtio spec to use this as a
transport for VirtIO?

--=20
Alex Benn=C3=A9e


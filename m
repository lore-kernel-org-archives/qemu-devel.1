Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779A9C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411382074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpLH9wwg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411382074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02AB-0006MP-G6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k029L-0005w8-Er
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:22:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k029J-0006JR-C8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:22:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id 88so14669186wrh.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PJtv9+b4qef2V2ddA3Ij4b7HKuwebvVv0UYsG1HebhY=;
 b=LpLH9wwgF2Cy9jhKSAZpRcWejV2RF0BwExuO6OP95H7V7eEkw0k0crQIw8kmYQ5uqI
 sog0nVQB4+4+OLzyHftZ8ngklY7eW0MWzQ4pwX8jLDDP1zyIvtjG4IRPhYZZ2eW8Rfo8
 CQXBL70BIMmD/xmHjtlCr1Ya7L58GPOcFGRttEolrVB2bPyJTV0tHDm99achWMQAbsDy
 IFOc4Yzb/faYi5/Z6CcD2F7Qs7q4NgdQSjibiSPm3Nxu5JajcK2weL15/yDlVTJkr1lM
 HzJ+/H1LtMCGGeyjP+/tBVtWSuF6kfLhX5TlJ9Vty8YO7rvv1sRWbW5KoI5Fp56e5Lo6
 rqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PJtv9+b4qef2V2ddA3Ij4b7HKuwebvVv0UYsG1HebhY=;
 b=BA5ViTQltPBUruLT1XLXV0WBR1u1JhLKB2s8M4eFv9UnZwRwmZ2Cba3Uzx/enTn7kr
 UBEI2l02LDHTfiv1+8FAtw1zOuUfKCAbJA2XSeJSTMg3ddv6+IHcgRlobwIcsSLayO51
 0j1zXwqQbt9dUPm18HSEB7IG+Me1dnsYtt0RlP28VPw965Ba4PosLguNlq/7WsAKYBSo
 K8E9QNgkgovfrSp8Fx8VXG0pyMeVD+9ZL1Eh9geInBltkGQcEh6EaGYxgZ5kOBIO8JYE
 HINuYC4yknmvBEu9G1uEtP+j+a/7rsm4MAjxH6geFn5O2XeGO7wuVEQqma1l6WXNegrZ
 DpkQ==
X-Gm-Message-State: AOAM531F4e1O+oMFrtT805Oz7otJNHg7LYQ/SchclQOf/hAdvGXIGyST
 05A5QZxqzGS1KiWh3plc80SKtQ==
X-Google-Smtp-Source: ABdhPJxn1TV9ljTjA0sDmdsrf/iqlWwUQ4uLBLFn80ei1d5r6fV+HideVSzN8QDgf06+k0LXrDSAfQ==
X-Received: by 2002:a05:6000:118c:: with SMTP id
 g12mr19870255wrx.212.1595852551660; 
 Mon, 27 Jul 2020 05:22:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q2sm8442957wro.8.2020.07.27.05.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:22:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F7791FF7E;
 Mon, 27 Jul 2020 13:22:29 +0100 (BST)
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <CAJSP0QU78mAK-DiOYXvTOEa3=CAEy1rQtyTBe5rrKDs=yfptAg@mail.gmail.com>
 <874kq1w3bz.fsf@linaro.org>
 <20200727101403.GF380177@stefanha-x1.localdomain>
 <87h7tt45dr.fsf@linaro.org>
 <20200727073311-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
In-reply-to: <20200727073311-mutt-send-email-mst@kernel.org>
Date: Mon, 27 Jul 2020 13:22:29 +0100
Message-ID: <87eeox406y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Jag Raman <jag.raman@oracle.com>, Andra-Irina Paraschiv <andraprs@amazon.com>,
 kvm <kvm@vger.kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Alexander Graf <graf@amazon.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Michael S. Tsirkin <mst@redhat.com> writes:

> On Mon, Jul 27, 2020 at 11:30:24AM +0100, Alex Benn=C3=83=C2=A9e wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > On Tue, Jul 21, 2020 at 11:49:04AM +0100, Alex Benn=C3=83=C2=A9e wrote:
>> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
<snip>
>> >> Another thing that came across in the call was quite a lot of
>> >> assumptions about QEMU and Linux w.r.t virtio. While our project will
>> >> likely have Linux as a guest OS we are looking specifically at enabli=
ng
>> >> virtio for Type-1 hypervisors like Xen and the various safety certifi=
ed
>> >> proprietary ones. It is unlikely that QEMU would be used as the VMM f=
or
>> >> these deployments. We want to work out what sort of common facilities
>> >> hypervisors need to support to enable virtio so the daemons can be
>> >> re-usable and maybe setup with a minimal shim for the particular
>> >> hypervisor in question.
>> >
>> > The vhost-user protocol together with the backend program conventions
>> > define the wire protocol and command-line interface (see
>> > docs/interop/vhost-user.rst).
>> >
>> > vhost-user is already used by other VMMs today. For example,
>> > cloud-hypervisor implements vhost-user.
>>=20
>> Ohh that's a new one for me. I see it is a KVM only project but it's
>> nice to see another VMM using the common rust-vmm backend. There is
>> interest in using rust-vmm to implement VMMs for type-1 hypervisors but
>> we need to work out if there are two many type-2 concepts backed into
>> the lower level rust crates.
>>=20
>> > I'm sure there is room for improvement, but it seems like an increment=
al
>> > step given that vhost-user already tries to cater for this scenario.
>> >
>> > Are there any specific gaps you have identified?
>>=20
>> Aside from the desire to limit the shared memory footprint between the
>> backend daemon and a guest not yet.
>
> So it's certainly nice for security but not really a requirement for a
> type-1 HV, right?

Not a requirement per-se but type-1 setups don't assume a "one userspace
to rule them all" approach.

>> I suspect the eventfd mechanism might just end up being simulated by the
>> VMM as a result of whatever comes from the type-1 interface indicating a
>> doorbell has been rung. It is after all just a FD you consume numbers
>> over right?
>
> Does not even have to be numbers. We need a way to be woken up, a way to
> stop/start listening for wakeups and a way to detect that there was a
> wakeup while we were not listening.
>
> Though there are special tricks for offloads where we poke through
> layers in order to map things directly to hardware.
>
>> Not all setups will have an equivalent of a Dom0 "master" guest to do
>> orchestration. Highly embedded are likely to have fixed domains created
>> as the firmware/hypervisor start up.
>>=20
>> >
>> > Stefan
>>=20
>>=20
>> --=20
>> Alex Benn=C3=83=C2=A9e


--=20
Alex Benn=C3=A9e


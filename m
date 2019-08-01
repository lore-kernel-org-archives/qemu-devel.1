Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C8D20838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C8D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht6bY-0004Es-OV
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 04:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1ht6aG-0002Y7-6A
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ht6aF-0002Dq-5f
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:37:12 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ht6aE-0002DY-VT
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:37:11 -0400
Received: by mail-wm1-f51.google.com with SMTP id p74so63654999wme.4
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 01:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=tu77pY91e8IDhsm8pzyNgtGF7powaZ9q5eD5tgj/rM4=;
 b=FlWCvZBiFvGQiuvV6RzMQ/HLVPS8vkvPYYLGu3+9EUC+oG8XoNze8Qk3PnjSjcPLGy
 zUNh0UgTifSe3ScBNUOR+u/YUNWYhOAAjXOOuRNR9hNxo6AK4jcp/DwcDuiKZyta6vTv
 9BaV3kbl27lvMcCyxA9LaEULbXUyXp42H6S2VHbp25tTq+Eq2RM9uuqOhxN/kojAGDSY
 r7nlyczgsX/09VvX2RLHSCYVCJfWNd62eVFRBL8/KS/3KV94aAPXD+vQ+qrw6Xj8AQ9Z
 aKqfgzg18UmsrAKrn5GU/EzquVloMxsIAdqRxvxrVxdiSYC8lMl9+hOQJKIF+wDFkE6F
 M3BQ==
X-Gm-Message-State: APjAAAVD3ggumgb3AF1czhVMSpeIAQImOMd3drKxvF5AlI+RYtmKkyLf
 +vCOLeM13+6Pupqbka2WcfcjdrVlwxE=
X-Google-Smtp-Source: APXvYqxdEEFLXVM1q3B8IGrxnEWxTLZKtsZP2H8H3PK5BHRabX7dkBluC5c4nt5WyjcVDBA6qJ3Frw==
X-Received: by 2002:a1c:9813:: with SMTP id a19mr111772811wme.11.1564648629564; 
 Thu, 01 Aug 2019 01:37:09 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id t6sm79961136wmb.29.2019.08.01.01.37.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 01:37:08 -0700 (PDT)
References: <20190729125755.45008-1-slp@redhat.com>
 <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
In-reply-to: <932a0c3c-b6cb-540f-ca07-1559c8fe9049@redhat.com>
Date: Thu, 01 Aug 2019 10:37:04 +0200
Message-ID: <871ry55ljj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.51
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Laszlo Ersek <lersek@redhat.com> writes:

> On 07/29/19 14:57, Sergio Lopez wrote:
>> Implement the modern (v2) personality, according to the VirtIO 1.0
>> specification.
>>=20
>> Support for v2 among guests is not as widespread as it'd be
>> desirable. While the Linux driver has had it for a while, support is
>> missing, at least, from Tianocore EDK II, NetBSD and FreeBSD.
>
> That's right; not only are there no plans to implement virtio-mmio/1.0
> for OVMF (to my knowledge), I'd even argue against such efforts.

That's good to know, because I was planning to work on that (the changes
are quite small, actually) in a couple weeks. ;-)

> OVMF is a heavy-weight guest firmware, which I see entirely out of scope
> for "micro VMs". And so virtio-mmio/1.0 would seem like a needless &
> unwelcome complication, from the OVMF maintainership perspective.
>
> (This should not be construed as an argument against "micro VMs" -- I
> always say, identify your use case, then pick the right components for
> it. I never try to convince people to use OVMF indiscriminately.)
>
>> For this reason, the v2 personality is disabled, keeping the legacy
>> behavior as default. Machine types willing to use v2, can enable it
>> using MachineClass's compat_props.
>
> This approach makes me happy (with the understanding that edk2 guest
> firmware is not going to target the new machine type(s) in question).
>
> Thanks!
> Laszlo


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1CpLAACgkQ9GknjS8M
AjVT4RAAqJ4UgjOZ8/Jr21AvnmMtUbjUMegLVtcUVfI+N2qMP8J9fX49yjD65GOp
OfrfN4YpfTJN1xex5fzc11ezQzQbTL72S9izSXUYBvRAx1xO4FsZ+x/r0hJlFmJl
yall57aHbBFLE2XJfGJvc43EkHrQFg3sqPwx/IHdbK40IYvyn1NUEddhihy/6Hvi
DABu4YtFWbVn/db2fnyFBJ+2Vj+T3LZvOFum4K+DVVlq8rnOMZaeVFuYBTAgXq7v
+4aLvdO9ibaqCRIuPYSEaZd5fuPNlRlXSh7zrr9G/sVEsZlKdv5mKNWhQkzWWipb
eR/ZiEU9gEmJ1LTLMIrQQu2ZixM84fluGi6kCSyJru/0CsPL8hCsDnb8jBSUrwIY
sOp0nuYD1ybJZWUswtSUgji8itTf+7GlQTrffb/joS0NDXmDiN1IfhVoOqVQVzUK
ij2rm7ScOyc3ZZnTkMLAIu94le2+DuuoRMPo6n3o/1HfPXNQaKwJapIS30I2jfx7
8x1+7wMBXHyZjCL4cgDB27SbTKiIfXUOd/t53Jk7lQeLyS0WzPS6cCLpH1AVatK8
SdwbUOkf0vT34yTEEkcMfZqttdaut5tQ8zUmZkrN72PpYjnI+LdhoQoo9s+59WIX
GCOgGodVmkWBgAXe99chz5UJuIA6Z1GTkUX50WmNPseCL6FtY78=
=KqYf
-----END PGP SIGNATURE-----
--=-=-=--


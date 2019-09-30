Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F0C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB63B216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 10:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB63B216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEsqM-00070f-2Q
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 06:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iEsp6-0005mE-Ap
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iEsp4-0002JR-2Z
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:22:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iEsp3-0002It-PA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 06:22:30 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 643D14E908
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 10:22:28 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s25so3730268wmh.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=gkviwrPRM28/SKeFSXpxkiSX22uaPzaZiKGGwAwdsxU=;
 b=JNuTMSWNAZwy273ibZvsYttgxHRerBy5lxyKTg0EaZsMsE5i9IL0166hYkN09ySplu
 zGZvZv7KxNV3BASJiQbqpInDIMPMEVndNc2AC9drQH9xZDG1TAXz6XsZOZs0LSweBmEH
 fmnvFXNsMsMMs8L6MdYN3SUvgFChJWGpi7bFdA4Fo6wgOM9+4b85yG42jWnwMcvzH5Mi
 q8hu/PH4XcGNXcBRRjcM09X0WB9w7qUYxzDTJVT8IIeO1imfANVXyNTiQ1QzRO1s+8Eb
 beiGOxMNUvEP54VL5xo1Ic60eFnAq8BX+nHiGS9U2CVMfc/YFBzLM6SaAzufYWj8/5A0
 gnXA==
X-Gm-Message-State: APjAAAVKe5A/ld17BJHBj1ji8vkPAdib7Fn9s8N8m2RcLONGixIPqzun
 HghPb+T+6K9yp3JjSOeaxEZdXI6P+QiYc9iVACIg03wV3zE4/uUl5y61jPb+/lXgtA83nTWKuV+
 V+f68lb3mlAOC9p4=
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr12241442wrx.51.1569838947107; 
 Mon, 30 Sep 2019 03:22:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJEOMZQC2HKmhf0OcLNAorVG0ufkpJ6epnIRNZLLdM5I1tZ9uzP7d2USim2CqyTfbDkZbuRA==
X-Received: by 2002:a05:6000:105:: with SMTP id
 o5mr12241417wrx.51.1569838946904; 
 Mon, 30 Sep 2019 03:22:26 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id d78sm15480844wmd.47.2019.09.30.03.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 03:22:26 -0700 (PDT)
References: <87blv2i5ha.fsf@redhat.com> <87lfu6kuyo.fsf@linaro.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: alex.bennee@linaro.org
Subject: Re: Arch info lost in "info cpus"
In-reply-to: <87lfu6kuyo.fsf@linaro.org>
Date: Mon, 30 Sep 2019 12:22:22 +0200
Message-ID: <878sq6hyn5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 mihajlov@linux.vnet.ibm.com, imammedo@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Sergio Lopez <slp@redhat.com> writes:
>
>> Hi,
>>
>> Commit 137b5cb6ab565cb3781d5337591e155932b4230e (hmp: change
>> hmp_info_cpus to use query-cpus-fast) updated the "info cpus" commit to
>> make it more lightweight, but also removed the ability to get the
>> architecture specific status of each vCPU.
>>
>> This information was really useful to diagnose certain Guest issues,
>> without the need of using GDB, which is more intrusive and requires
>> enabling it in advance.
>
> You can always enable the gdbserver from the HMP when you need it.
>
>> Is there an alternative way of getting something equivalent to what
>> "info cpus" provided previously (in 2.10)?
>
> info registers
>
> should give you a full dump of the CPU state including the PC.
>

Both methods are less convenient that what we had before. Perhaps it'd
be reasonable adding a flag to "info cpus" to give users the options of
having the same behavior as before?

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2R114ACgkQ9GknjS8M
AjUSIQ//eIojGiTDmWEPUfV77nIqXCSvk8/TFVuv2SoaSpFcqVJlWZ00Z4pMtN0f
m2mfNiSRARLLzLt9ghG+qezLxHg1LSVllVizRxu4+DHLPimEyDF/eKtZD6lalrcj
fx9irYjBl4PpG1sBSf4Sp5M+7EpZy+B4Dbveslzi4LeI7gtkUq2v8LpRofRHolLv
5zWj6b/1QkCVkOI3YOE/ywoH2gt9Nng41v0e0g4dLsiMMou2na78NHSxRjbOZdbm
Gd2SQLNKa+qAWqZo+6fB1XeLMBWdjmN72pSFja6E9nDWDn1dYIVq5IneTMSxUHbK
op7nOjlyDwue3Dn6JbhIoYRHS745ggDzO+1OshE19q9HIpn2LRSJBZQlE4yJ2K02
pH7hgcG3z4AMaRyyJAuBF7Rx1dlK/zNiZtw6C5M9D/tsTH9GgUACEyOkUpswTP91
JDHaBUv9hZIY/yWzf035hWtWyfpBfDnQB9EvFuOz5qOCfiHmugFp/HY75jbEIijv
PYSvu3VpIwmPXmRwDiIlt8zZUH1Z+uyXPRJOnIzWtaqHIC7g5aqSrINBgBOCLo6J
qxrB38GyfPvSrlAX8HomGE6YioZ05prfLhnwZpZAnyhlPcS107w2JD/niqOHAP5J
W5km1vyXAMh2XVvGfEKTZVuSd7szJVykZXUNWLGwyjV+F24veYg=
=74gL
-----END PGP SIGNATURE-----
--=-=-=--


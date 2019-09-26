Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E54BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BD3207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSgV-0004lr-UZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iDSdZ-0000n3-6I
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iDSdX-0002Tk-5b
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iDSdW-0002Pk-Rj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:12:43 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38D56121D
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 12:12:39 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id k184so1092467wmk.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 05:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=wN9I+pQTOykWj2CrD7IK9V1z8ICLlfPqN2VP1BP9wIY=;
 b=m7rtNIoh1Dy1Zicx5T7hjfYEnAJYFeR0HBd7VcVzIuOal/pWsjxTwygmL3R8SclO9s
 kflrgyCpYNOP2N51XfXLlFXRQ3D8otCSMHyuGPeVdvYeOfKxmx8IHDoPXIiFi+gq1MCQ
 NpE8KZ8iu9s3OiWco9ZR+f6sbnHg2ALug8Uq3TPpk5x7+q5UsPmDyW9VDHjZAtCQnB+R
 bnCTplIWwgClJo4LYe1ud5WI4lLYYQSaFc0TY9b2f923l1Y0TZxr5GJwFUFC025Pnb76
 U5ZGzo3uMeFhQUTuaEipIossF8PaUXc/vXpky1diKa/KDC0yhTve/ZwlQnoZkBvRX839
 aSXQ==
X-Gm-Message-State: APjAAAVPsQEu1lOWI6sOFVfY4iMfHxnOxYb7vB9ExkDOvxY7niApZ3CK
 LZwlvmDCNftU2XiSq4QXT4nu5vTjQy/Qv7dyrAJ4BU58CFsOQMAPbPyO4aYY1pBMNrIZzz7LDZm
 C3pYRkTU4tjuOxtk=
X-Received: by 2002:adf:f790:: with SMTP id q16mr2649432wrp.164.1569499957911; 
 Thu, 26 Sep 2019 05:12:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8j93qOeT9kouAyo+bvdFtag/p+jF4N3iabs8WR/gC642ne//Z6Besjyuwo9T0IgNq8roODg==
X-Received: by 2002:adf:f790:: with SMTP id q16mr2649412wrp.164.1569499957694; 
 Thu, 26 Sep 2019 05:12:37 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id y13sm7051284wrg.8.2019.09.26.05.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 05:12:36 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
 <d70d3812-fd84-b248-7965-cae15704e785@redhat.com> <87o8z737am.fsf@redhat.com>
 <92575de9-da44-cac4-5b3d-6b07a7a8ea34@redhat.com> <87k19v2whk.fsf@redhat.com>
 <b02ada95-9853-ff21-cc14-ca0acf48782a@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <b02ada95-9853-ff21-cc14-ca0acf48782a@redhat.com>
Date: Thu, 26 Sep 2019 14:12:24 +0200
Message-ID: <87impf2r4n.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/09/19 12:16, Sergio Lopez wrote:
>>> If KVM is in use, the
>>> LAPIC timer frequency is known to be 1 GHz.
>>>
>>> arch/x86/kernel/kvm.c can just set
>>>
>>> 	lapic_timer_period = 1000000000 / HZ;
>>>
>>> and that should disabled LAPIC calibration if TSC deadline is absent.
>> Given that they can only be omitted when an specific set of conditions
>> is met, I think I'm going to make them optional but enabled by default.
>
> Please do introduce the infrastructure to make them OnOffAuto, and for
> now make Auto the same as On.  We have time to review that since microvm
> is not versioned.

OK, sounds like a good idea to me.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2MqygACgkQ9GknjS8M
AjX7gBAAuIOhcJCSJRb3fNUsv+ppkFbFvve9QMXGpPDOPxNoUi4xqFkUXgTagi8y
sIBrbXsFjS0Aj/12Cle8xEuTASy0eSwCrGP1r030YhatqkDNrEhAlyRL6pmj6C2P
cibVfVQGmdd2CYwibnLuaOY4fQIfVZICbBAPHAPQT+dO6i7z1hN2RmhhsHs5qn2k
/YL87sTRx3oNC7Qzu5kwMcVLZeKtVKdQEYGcAGxD6++zH5tgz3luzTZyPODPk/Iy
ZIsqiC211A6jAld63V3bPad0Xv1LNV2HUh1rz+7KXTUMMtR+Awjq5XGg5CY7ri0i
vJ1kleICMA/Ap4eXrEdJ2CxyCFcanWejNaPnRphdqd2oxOvDnusDwRYBTnEWlCw4
6TQ3mcxRS29SVpSGmAVSnZqKb3NQ8xVrJkwhNjVxpTe+jZOwR+EnboJ3An91AhZ4
UaYbTa3gL9ihgkMiC1oYwkC8DHGnGC/0zJHkMeOvKBnLwa0U4aJPJ1jMJ8fQilqR
aS5utqGbNq4ynlipKoAthhOBk6rIR+n1GMBWiUEK/InC4GMGcdAbYsK6hW07tQMZ
ZEwwaz8cLOtUMeZVmJT0SvYeK7NRl9BjEndIf4XPD2iYFVWYLWa1p4x4a2V67x8W
eO+Q6H5KnKqKKAwpyiskPSGnIrgjnVjhVwS/JjxesUE6Dg7UTJA=
=5cKk
-----END PGP SIGNATURE-----
--=-=-=--


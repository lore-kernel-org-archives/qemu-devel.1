Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2809C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84A621783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84A621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFeqf-0002hP-Oe
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFepR-0001Yr-NH
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFepQ-0005FW-QW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:38:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFepQ-0005F3-I0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:38:04 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9786C85543
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 13:38:03 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f63so2102150wma.7
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=upaONc1tg8FH/B+Hq5snypMNaYk/YaDs6TBwQMCMyJQ=;
 b=b4lvdrSCxc6TtqpnfLwXfS21bbnVqzdYCm1fgEMkLV+HB/KleZM9uQLrLNAYcIlNSJ
 B1oRzkSzD05gl/oe8s/od9rZ+Pt59BWjE3/KhtkO2UOexqWypfs/T/An1drOC0VfJeZK
 u4VmojbcZg4vtvnVlS1DQHufIkZL/qEm5nojl1DxoWCY6N9n2+3td/BzLfHIqTJ2DCcO
 OxV+ggcTrdtztKCR6cyq/MsNBkiH4MUF5Njvc16LRqZgzdr38LktAj/VRQXfw9KR3PPi
 hDPktctZIAZw9Ho6kobEF4u822cDzGYup8/zF2ei/Vo9l8vNhElrhuV0CpgWntbSRsI3
 vb2g==
X-Gm-Message-State: APjAAAXGixTHyRdaP2K504hhpmaHxWU/9gkakw8cXh0FIU4Jjq5eTwtj
 hz96neE1C23JftMHtGiZmhZ1RZi5a+MOyM1X2wpTbIdRo08mvVO6eBvF8ExJkLgjQ15Aa+0BbmY
 kE6BR1wAXm8Ios/Q=
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr2941743wru.227.1570023482266; 
 Wed, 02 Oct 2019 06:38:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAMLFio/Oh6G3FlBWgyZ+7aPkwl2MZYgpfZ1sLvv8d3IZsr83SEPGTdRuaZckyqL5K3rzBXA==
X-Received: by 2002:a5d:4f11:: with SMTP id c17mr2941708wru.227.1570023482039; 
 Wed, 02 Oct 2019 06:38:02 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id c8sm15966321wrr.49.2019.10.02.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 06:38:01 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-10-slp@redhat.com>
 <f604f346-b799-4465-d5ed-0a0f6ff719cd@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 09/10] docs/microvm.rst: document the new microvm
 machine type
In-reply-to: <f604f346-b799-4465-d5ed-0a0f6ff719cd@redhat.com>
Date: Wed, 02 Oct 2019 15:37:59 +0200
Message-ID: <87zhijfetk.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, lersek@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/10/19 13:31, Sergio Lopez wrote:
>> +- LAPIC (in userspace by default)
>
> Note that LAPIC should be in kernel by default.  The userspace LAPIC is
> slow (cannot use APIC virtualization in recent Intel and AMD processors)
> and probably somewhat buggy.

Thanks for catching this. It's a copy/paste bug in the doc. The default
mode is irqchip_split = true, so the LAPIC is in the kernel and the
IOAPIC in userspace. I'll fix it.

Cheers,
Sergio.

>> +- IOAPIC (in userspace by default)


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2UqDcACgkQ9GknjS8M
AjWGfhAAnl4q088wKEq4zZ4Apxr9anmxNI6QnLBhH0QmzIHlC4CaeiB4aT2+7gD5
YWbDKPeQR/+xndqmYueWmHgxDETS0ho0J7IEWj7xZgcx8h/+RCo9w509Onx4dtkx
HhdQsDmaMLfJ6rFKHDaTm8Uw8dVrGtUiaDvGKuGwPoj5wdIx/iFVhQSvsV2fhacW
bzEWLcSOovB6IZ2LSHJn/m4JYQ4I4MI9EYHhvW+pND85iVsQ2EauKC8of+3GXlef
p/dk9olMDwPahge4CVaYzM2P9fyZYTZ5MX1YbMTV7U3x7X0HGICrzXNm1552qGnp
0ZF7FeBN+MNLonCj+JIXdL/m0qsyECwFxA8AgtKLps4V1zjnPRNgiJZgzX5i8Q8D
vISXtXbp7hBKUiqCrPLoSwO6SSaG7NjJBYMG/MNExY1gl5ZxyLamvaxoyB9b/KXk
RLna/ZtR8oSP89zUXhQEpWTM3jahFNmZRZ3nkGxpJ88qC1BTWvfu4V1Ou5D/Rm73
kcco0HIQS1mOQSDfMUN2kHbE5crGwENuMVYYUuVu4Mc7w6xrDz+Jxg321kyKcdN8
CoetqgKWGhplVT50nXDqW7eFuW7V7l4JmPy6+1nYcY+nAXoJCI+lsS/ElZCU5ZXj
1IGBl8gL+oHB8tYFYp7gg0nBiZXJzMeNxRNOHVQRhB2m84HXydk=
=MEZr
-----END PGP SIGNATURE-----
--=-=-=--


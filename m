Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE2C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5996E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5996E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqgs-0005lB-7L
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgqIl-0001WV-Cd
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgqIg-00035D-1V
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:58431)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgqIX-0002yh-LC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:48:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MEmIl-1hnDGz3Ved-00GHGf; Fri, 28 Jun 2019 14:47:31 +0200
To: Fam Zheng <fam@euphon.net>
References: <156171539473.6332.3788894025347542150@c4a48874b076>
 <f1ff093c-cb64-a54e-778e-eb18a0fdddb2@vivier.eu>
 <20190628124117.2lltlf7yiwlwy4j4@debian>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4d6b26bf-6f20-f809-9e9c-f706dfd21e35@vivier.eu>
Date: Fri, 28 Jun 2019 14:47:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628124117.2lltlf7yiwlwy4j4@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o0CRN3jvgRdvwplWDwGd1Wsi/RmpSco+pBhTixPqOqW3CXoyUfg
 RISsnG/MysrgTmdL16mlDCnZ5tLynzZ+qUvQdmL7lZ6gpBG87OVhfaXRhE5mP/+cmeh0Udw
 l0fQ2vSz/GQSPpjGda93fejidn2mnPo7vmAtcR2+mYSRTTV2G7ZLJgv9I2/QQWaQ25sAvMz
 VlbYuRmIXFxt+aURsqXjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7rVLu118HwQ=:wHggIGFEufGwPMkHqfN6Hd
 Q434b4VIUKz/oQG9SwGn9v6Z3A+gLOUXdLANY+4jhOtO3ApNkyMX+eXsQxhsTTFkI33RiUgKe
 mODTJmWJdZsFXVZSc2/Ya5jwpaJvlEjjVDqBTth6F6+wBjnMAOG6mGSY73dgDVGB2H2wAVpq1
 BmrsYqH7GxO1sNz6G30WmLlauUkeZuMCWAlQiloQnHBUAZieZuIGOAX3B4UCV3NCKQBNj/mGr
 LOCaxQjv5ZPj6FcnXYdy1xsTIpIk225kXug27HBblUSqAfjy5h0cxEnowLkscam1LX8KyoKrI
 37ZNkPfiw1cr5g2onOiuXfTc35m3JSvJZUnVs4mpwcn8mSLUANsOJY/L7jAcwyIZlyeuzSR+Z
 5IY1mDAOIlN5EP4gc8Kz/LOoQzzxb1f7NWKQm6bMfBdOJhHIbxzxRS+4P6oKYJ9gecgRQ7Hfb
 jFQKPeHUbT4gd61EJNNyA88/ZPRcuMCeVl8HHZzhpzQSNbAxoF+xkqcFwYypxPBgmO7e2mtcm
 UQf295dugFT1ztTKUIvHjfbPYs18NjPhxBo3Alk89EBF6rQwqxKap/3ZyUsk3zDIgyay389CK
 cE0bYX86FMrbHN2Dgpm/5fEK7uYOQPPtfF/b5+jVbK6npTBRkbMcxbtWxz9d6ZoRfIS6ee4HN
 FdCNj43luhn9JiOKfHPgAxOe1haEVmCWemRsYTNdVUUisHCKQJvNCi7mPZUK+N9yaNIaRIB9x
 1udPmsuxTwr/K64GSuziDB+5wYDRDIsxGdxWX0LShq21Hi67urstyK7Zqlg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [Patchew-devel] [PATCH v15 0/5] linux-user: A set
 of miscellaneous patches
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
Cc: "patchew-devel@redhat.com" <patchew-devel@redhat.com>,
 aleksandar.markovic@rt-rk.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 28/06/2019 à 14:41, Fam Zheng a écrit :
> On Fri, 06/28 14:15, Laurent Vivier wrote:
>> Dear Patchew developers,
>>
>> Le 28/06/2019 à 11:49, no-reply@patchew.org a écrit :
>>> Patchew URL: https://patchew.org/QEMU/1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series failed build test on s390x host. Please find the details below.
>>
>> To debug this kind of problem (at least to reproduce it), it may be
>> interesting to know the OS release of the target build environment
>> (glibc version, gcc version, ...) on which the build fails.
>>
>> Is this possible to add this in the mail (or in the logs)?
> 
> I've moved the env/rpm/uname commands before the actual testing commands, so
> the information can be collected even upon failures.

Thank you Fam.

From the v16 log, I can see s390x runs Fedora 30 (v15 works fine on
debian/sid s390x)

Laurent


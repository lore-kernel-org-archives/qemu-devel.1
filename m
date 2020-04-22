Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CECDC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CF12073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWozpicH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJIy-0005Kz-7l
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJIA-0004ui-Ld
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJI9-0004X0-8z
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:36:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJI8-0004NX-N9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YCICKn8ccUSIRwuMZcRt8Brh25YqxBPY5bIUmZFINMw=;
 b=VWozpicHng2XPiDnpkhk/b//vXig4blQpIrd4R0NSWoFfeYlonB9akOTRi/Q7R86gMibbt
 mon6H2oCl+D0NzciXZYBfaVJ4ap/o+o1NLuOFXff27Rzlub4vvgCvtQTcHAcURKH/9Jxz3
 mZobp8B4O4md4zPKKrTkx1YNvtYs854=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-7PZMTP15MqOckd6klpyIcw-1; Wed, 22 Apr 2020 13:36:01 -0400
X-MC-Unique: 7PZMTP15MqOckd6klpyIcw-1
Received: by mail-wr1-f72.google.com with SMTP id d17so1401307wrr.17
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=9GxnlF09OqcJtuyItFc6Lbh3eHhs0MhwIWaQoEb6Pes=;
 b=XrUSP9sDuSHK1PDYA7AAXgxsArDtjLhVJK78lb6X1TOGTO6wDfS0O4aOzgAFMUk3cX
 oFJf+K1f1EflqOI//iM8mwpW64MzCTG8tagi3UPr8eBQFjdET3iAoF5zMG/Jwu7xGIJH
 vdEMghR1/uFqCtZ9O33pkzBJZCf0L1lwtDmXDEsRjS3MaCJHL5KVL7gNFilygT1MsrO2
 kUrizMXFihCB0cwRoW9wCA0CNf2Opy+Pf7mbbT0i4Xj3+PLaqArOpIO/0xwM48tSpAjd
 YhOtC/rS+hASfGKOpURzIFWVrJnglAqy1Bu/pTeGZH6xyg+NaMPkdjZI/FM29EkqELBv
 I61w==
X-Gm-Message-State: AGi0PubJS5kqAd/fwtbkChxw2E8kwkH6hobAJNK9JoaCrDVx/koHr3rO
 gW8eywT6sFPPsIvlnEUXDiP2i5polOHPDg4rd6z/8y7zqFmk7IzB8Su1eINg0v2mUdHJZp4QOG2
 8rsBzDm4CU+a53jM=
X-Received: by 2002:a5d:628e:: with SMTP id k14mr113289wru.293.1587576960235; 
 Wed, 22 Apr 2020 10:36:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPvQeN68BbE8C1/0385bNhH8onbw2fHWv0chzkZfnw1An1/IaYs8Hx1VE26WUv9nwC/+Dalg==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr113265wru.293.1587576959900; 
 Wed, 22 Apr 2020 10:35:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446?
 ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
 by smtp.gmail.com with ESMTPSA id u30sm9509976wru.13.2020.04.22.10.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 10:35:58 -0700 (PDT)
Subject: Re: FYI GitHub pull request / issue tracker lockdown bot
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200403142213.GO559148@redhat.com>
 <20200422160103.GG47385@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e82e609a-7de8-53c6-428f-e138e0f32533@redhat.com>
Date: Wed, 22 Apr 2020 19:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422160103.GG47385@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lRJdi4y8jiXKHR6AEvrsAyclkJyulbU8D"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRJdi4y8jiXKHR6AEvrsAyclkJyulbU8D
Content-Type: multipart/mixed; boundary="fBwT3LbuJTHR0YUUI1WwgeudAreBMTSPp"

--fBwT3LbuJTHR0YUUI1WwgeudAreBMTSPp
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/04/20 18:01, Stefan Hajnoczi wrote:
> On Fri, Apr 03, 2020 at 03:22:13PM +0100, Daniel P. Berrang=E9 wrote:
>> QEMU, like libvirt, has a github.com project which contains automated
>> read-only mirrors of QEMU repositories.
>>
>>   https://github.com/qemu/
>>
>> An unfortunate side effect of this is that some users will try to open
>> pull requests against these mirrors. These get ignored until eventually
>> someone notices and closes the request. QEMU has had about 90 prs opened
>> over the years.
>>
>>   https://github.com/qemu/qemu/pulls
>>
>> The same applies to the issue tracker, but fortunately github lets
>> projects disable this feature, which QEMU has done.
>>
>> I have recently discovered that there is a nice 3rd party bot for github
>> which can autorespond to pull requests with a friendly comment, close th=
e
>> request, and then lock it to prevent further comments.
>>
>>   https://github.com/apps/repo-lockdown
>>
>> I'm setting this up for libvirt and it was suggested QEMU can probably
>> benefit from it too as an example see:
>>
>>   https://github.com/libvirt/test/issues/2
>>   https://github.com/libvirt/test/pull/3
>>
>>
>> Configuration just requires creation of a ".github/lockdown.yml" file
>> which provides the friendly message to add to the merge requests. This
>> can be either done per-repository, or a special repo can be created
>> called ".github" and this will apply to all repos within the project.
>>
>> Ideally each repo would have a CONTRIBUTING.md file created too, since
>> both GitHub and GitLab will direct users to this file for guidelines
>> on how to contribute.
>>
>> I don't have time right now to do this for QEMU, so consider this email
>> a friendly suggestion for some other interested person to do for QEMU...

Philippe did it on April 6!

Thanks,

Paolo



--fBwT3LbuJTHR0YUUI1WwgeudAreBMTSPp--

--lRJdi4y8jiXKHR6AEvrsAyclkJyulbU8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6ggH4ACgkQv/vSX3jH
roMFaAf+MomyHvBx3i58PToiirlXsdJzIasJiMNofdwWtSfvABHkuL8bFNXNg2nu
IzrU6UMNZCFST42/KbtFmhjya8ZW7yuT+l5gIt2jWpnrSM4yzdKt96euuIYiOEhT
BoMHpC0yGLs0pl1mySn1fpFufMuCZIdAf6ZNL6OkQeUe08IQwjSnTCUOBFbi17yM
hntHkU0etuIZMRgJDbTqTScTFiLo+W3UKeMOjeuhUdVuBe1FGQieUmq7IOctooRZ
Hf/GPloiP17i+5k/3zruvRpPQdSUO17hUO6nXLHSOnWrU0Yv0wF6tafULG7ba79q
BDd7TDnjoJqtMfkMakG9elNy4cen3A==
=yxiB
-----END PGP SIGNATURE-----

--lRJdi4y8jiXKHR6AEvrsAyclkJyulbU8D--



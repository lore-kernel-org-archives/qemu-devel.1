Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28480C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD26F2065E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="xI1jDcgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD26F2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECLf-0004gF-46
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kECKz-00040P-7i
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:05:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kECKx-0000iz-1b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:05:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id w2so6211158wmi.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Fh/WYkpBp18gzFyMkabdP5m0LNIP2BX5P2+KYMc7kp8=;
 b=xI1jDcgxl2rA3MHzrNf8767pqP6Ne08yQSBKw8SF7xFnRuTsIpti5W08KgmyhTdij9
 8WvRgCKKpSl/JY06/G3oOm9MAd5NQMhE4ElkBRNe0YgWblAFQUcjecY8OvQh1XhKHEEC
 Wt0qrHVGyeBKEbKaFGGDhwfixHxUMFqkq29jyc/odMGSEuXgYqN+o4iMXKz/OkIEi+bk
 FXE8ek6frtyiVPPSeyBc6crlw3Y8mQOZv3luKbozcWSbR6EDuMRbaodn/39k8XGT6+GQ
 BzU5EmYfKnVlhqipZ40T7i7fl/Gc9BE5NQcipzzjXbOA0MsVQLM0pQAjOsi4K4nApB3u
 1bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Fh/WYkpBp18gzFyMkabdP5m0LNIP2BX5P2+KYMc7kp8=;
 b=a/EBIHGICcOFEy+v+nfYCp9wpkwbdJIQm8uiY7mhP4k6YmTmxi2CLmJideFf3QZMIs
 ajYLA8VdmmArZWeyUFMPHwUynfWrIurfqR7dB9gH9AFnrLnyE1EFFSA1IDx098RwdPMV
 qsy+xV9BjeMzgUD7TIUKgtYrcYYYTVeQ414iVtyEDqgo6gmbEacBvmcAoc8bc5kW4hEL
 zJRFHmMwT9hGwdZHKZAEyLzkGWhPWdDEFEwkfFziCHeA59ybNEYC+yV5/MG4d+ratm/G
 ujaRTp8zyaIfHsnRLRyYK32L+MI3/rGiL78/uG8ANV1cHov+T4lI+mcZqwpdDPrrK2oe
 EO2g==
X-Gm-Message-State: AOAM531H0W5fIH5HXzTPegIYsjR7yY0D4UDOwb5xPv81Y6/v6QwfYRA2
 F5tJDnsL5kAaV3HvoeaF4t2aXJVn1cFrTiFN3WeM9VEmUiA=
X-Google-Smtp-Source: ABdhPJwoGPpcUs7iuEIXg3JKjtuz4fkJW4jMEUwNcelTWhLXcBLrE0/MdRsdnFpbc08HxgqsLfR7Zg6AyoPOpXwoIP4=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr7901256wme.102.1599228304726; 
 Fri, 04 Sep 2020 07:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200904124404.9894-1-ani@anisinha.ca>
 <2ba66be7-d4f2-6994-7794-c07fbb50151f@redhat.com>
 <CAARzgwwwbxqwxdni4rANsDF-f5HytcdM9NC9R8X7X0bqJSeVPw@mail.gmail.com>
In-Reply-To: <CAARzgwwwbxqwxdni4rANsDF-f5HytcdM9NC9R8X7X0bqJSeVPw@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 4 Sep 2020 19:34:53 +0530
Message-ID: <CAARzgwxR3yhyrqxcM+WVhHkSTmhsw9xVWLqupb4FModkzXQSzg@mail.gmail.com>
Subject: Re: [PATCH v2] i440fx/acpi: disable hotplug of cold plugged bridges
 regarldless of hotplug switch
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 4, 2020 at 7:09 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Sep 4, 2020, 18:59 +0530, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>, wrote:
>
> Hi Ani,
>
>
> On 9/4/20 2:44 PM, Ani Sinha wrote:
>
> Cold plugged bridges should not be hot unpluggable, even when their hotpl=
ug
>
> property (acpi-pci-hotplug-with-bridge-support) is turned off. However, w=
ith
>
> the current implementaton, windows would try to hot-unplug a pci bridge w=
hen
>
> it's hotplug switch is off. This is regardless of whether there are devic=
es
>
> attached to the bridge. When devices are attached to the bridge, the brid=
ge
>
> is ultimately not hot-unpluggable. We have a demo video here:
>
> https://youtu.be/pME2sjyQweo
>
>
> In this fix, we identify a cold plugged bridge and for cold plugged bridg=
es,
>
> we do not add the appropriate amls and acpi methods that are used by the =
OS
>
> to identify a hot-unpluggable pci device. After this change, Windows does=
 not
>
> show an option to eject the PCI bridge. A demo video is here:
>
> https://youtu.be/kbgej5B9Hgs
>
>
> While at it, I have also updated a stale comment.
>
>
> This change is tested with a Windows 2012R2 guest image and Windows 2019 =
server
>
> guest image running on Ubuntu 18.04 host. This change is based off of ups=
tream
>
> qemu master branch tag v5.1.0.
>
>
> Can you add a test reproducer?
>
>
> Looking at tests/qtest/virtio-rng-test.c it shouldn't be that
>
> hard / time consuming.

I think this test is hotplugging a bridge through the qmp command.
This test does not apply here as we are talking about cold plugged
bridges and making sure cold plugged bridges are not ejectable.
If you have a test infra to test such a case, please let me know.

>
> I can add a unit test. If you look at the disassembled DSDT table, you ca=
n easily see that it=E2=80=99s adding the EJ0 method for the slot in which =
the bridge is attached.

The unit test will capture this change perfectly. It will compare the
generated AML against expected AML and fail if they don't match.


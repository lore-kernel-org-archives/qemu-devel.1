Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF154C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C568521743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C568521743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlXY-0000AD-Rj
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 11:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hnlXP-0008C7-9J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hnlXO-0000En-Do
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:08:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hnlXO-0000EP-8O
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:08:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E2B030C1322;
 Wed, 17 Jul 2019 15:08:09 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-5.ams2.redhat.com
 [10.36.117.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CAAB19C4F;
 Wed, 17 Jul 2019 15:08:05 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
 <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
 <7b45c073-8653-28e0-9d06-9e3aaa6dc460@redhat.com>
 <CAFEAcA8RZuzv=KkATMozxfp8MTsCOPPsK7mN6oCJq_TfwWiPMA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <97ca4042-a224-7480-cc94-b58c687c353a@redhat.com>
Date: Wed, 17 Jul 2019 17:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RZuzv=KkATMozxfp8MTsCOPPsK7mN6oCJq_TfwWiPMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 17 Jul 2019 15:08:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/17/19 15:46, Peter Maydell wrote:
> On Wed, 17 Jul 2019 at 14:36, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>> I still wonder why this didn't assert on Peter's setup.
>=20
> My setup does not assert because my host kernel correctly
> provides the ID register values to QEMU. Laszlo's appears
> to be providing all-zeroes, which then obviously breaks
> assertions being made about the sanity of those ID register
> values...

OK. Can you suggest a location that I should check in the host kernel?

Thanks!
Laszlo


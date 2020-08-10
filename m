Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB0CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 05:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB44206B2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 05:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vayavyalabs.com header.i=@vayavyalabs.com header.b="nVnnU7/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB44206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vayavyalabs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k502E-0003KS-W3
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 01:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k501h-0002uv-3o
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 01:07:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:40476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pratikp@vayavyalabs.com>)
 id 1k501f-00035L-N2
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 01:07:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id l2so6877178wrc.7
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2020 22:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vayavyalabs.com; s=vayavyalabs;
 h=mime-version:from:date:message-id:subject:to;
 bh=Jf6hwqmhdU+zWqBxBXEAKSQy/nnfMqs7OmAjX1yAVS0=;
 b=nVnnU7/p8814+aIO3oqAAQIM/RvmITSzBmDjDU6lT1I1IiR8LiU11JgUoMP6qhL+AU
 EbRyJqznouKi8r7okRGDP5v+HbtqfQpSfyxLTPOI4rmJTAkUOLqkwoTs2QNjRpfQPAaQ
 ZT27sttd90LJvNTuMSeuc8LOFJ01951mRWwrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Jf6hwqmhdU+zWqBxBXEAKSQy/nnfMqs7OmAjX1yAVS0=;
 b=RHWpq2oEhfVMJU45w6BdCK63EYOoePKS38jo6mdV9VyoeX2WteO7aRwZKVa++/Fanj
 vsJA+/l/AaoVRCOkBsBdx9UWgGoqZFsNzfT3+A9NRlx9RveQjETGUI/9H6WvGjJfYc2e
 73Y7JLf/LisSpD5Ohb8e3eAOviMIkP7tv6R4oNpIRso/C7XzcLLusQRJc7JV11hyiGYj
 QBY31FMC5bF0GOXjqM+uIkuJ8NaXUqLlamwXq9n7AeHf6dS9ds+KYpg3ZcIptY0YiB9k
 k4HEWaeDCyaNW5ePK5DI4R55BB7DFEpnhw7hmiB798TW0BzaXlYu1Org2xgutf6mn+a2
 6bog==
X-Gm-Message-State: AOAM533CVT6OngCKrP7E1mjqD2IewvPvgVzhDgaQ9zjxSbS7Z5/QviBY
 Udrf4qYRVZcdnTS6NQjny8Rrc89rGhnByq9Tz++VSjeJXco=
X-Google-Smtp-Source: ABdhPJysrFbmC/kQ6Z/+EqLHl2dmCWFGCCYJwRGhpmUDErvpjHHG/OZ0rTRRWFpGL3m13QnWRYn12A6UoQGf1ss6Koc=
X-Received: by 2002:adf:f847:: with SMTP id d7mr21598520wrq.328.1597036028542; 
 Sun, 09 Aug 2020 22:07:08 -0700 (PDT)
MIME-Version: 1.0
From: Pratik Parvati <pratikp@vayavyalabs.com>
Date: Mon, 10 Aug 2020 10:36:57 +0530
Message-ID: <CA+aXn+GrFDssmZWBCL0gh3QLX5BMhmgTQUywLSSQn=cpF2P1ZQ@mail.gmail.com>
Subject: QEMU Library support
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002cd9a605ac7eed89"
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pratikp@vayavyalabs.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002cd9a605ac7eed89
Content-Type: text/plain; charset="UTF-8"

Hi team,

Lately, I have been working on QEMU modeling and interfacing it into the
existing platform. What actually I wanted to check is; whether QEMU
supports library that gives developers a clean interface to develop and
integrate peripheral model in to QEMU. I know of the Greensocs SystemC
bridge - but that was quite difficult to work with in past.

Regards,
Pratik

--0000000000002cd9a605ac7eed89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi team,<div><br></div><div>Lately, I have been working on=
 QEMU modeling and interfacing it into the existing platform. What actually=
 I wanted to check is; whether QEMU supports library that gives developers =
a clean=C2=A0interface to develop and integrate peripheral model in to QEMU=
.=C2=A0I know of the Greensocs SystemC bridge - but that was quite difficul=
t to work with in past.=C2=A0</div><div><br></div><div><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr">Regards,<div>Pratik</div></div></div></div></div></div>

--0000000000002cd9a605ac7eed89--


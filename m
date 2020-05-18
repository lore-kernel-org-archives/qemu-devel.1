Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A44C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C253620709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MY2c9cKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C253620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadOO-0004qo-QL
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jadNc-0004OQ-Ac
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:52:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jadNb-0008Rr-5z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 06:52:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id 50so11231091wrc.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KKaJycH9ldaNylg4RL1pvGHC/XfDNmX+7xB4rUbxumQ=;
 b=MY2c9cKKtA/pN1mz7eHqkrvyl/2LvJfKYrYMMui/JS4gCv7cMUbG2XsRVdBovVQuUZ
 jCFj88/+ls+DlhUW3Y4YsMcqBXyO91X2CXeas0wweP2v8O8hJpamSNbhlhMtOfEty4Z5
 tBIF8CijWWdgCoJXDTb9aWP/5PSATYZCBlOvsGb0jhyza7OL4fL4nBGvQkaL4jxXHG3R
 lQg3FHETL6v12k0QHRcLvLdcLY7+FpFlQVyBhUA3/wwcJ0dZIQgWvi+8SSEMsQxsL/3a
 fH14a4k/A+atuoN0eOR5GuG72BrhBXPKllQqAPyuwTJk4nj+cqdWgeIr+Xm3y9JKDbnS
 HOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KKaJycH9ldaNylg4RL1pvGHC/XfDNmX+7xB4rUbxumQ=;
 b=F9yYE5rWP7ujVSQelIrzIBVnn9cvFxt6rlMauXkb+omAFPT/5AhBE0NABi3LHtmpJ0
 dZFFrEbbTftfY1p2Aq1RfQFbFYL3Ia/CWuRID7ylpLTS60jlKoCMEkqMqmRz4smTEe/O
 tJ49OfiaI35hKgPzg6x7u5APxW0YkxHGMzVg0Or9GmDg8eAcB6MLS93Fy3AszE7+cB+U
 UbWGQJaiRfuMJCycW/YmVQTAFqIC7ddnBiCKA08uWt4FrgCOy5bkW54wqVl9DvdvdtYk
 e1webN1w6Uvd9dVLWoUKkIBtD+Q6duMW+CS3f9duOD0rVCS2Zuxqh3KeV0+R3bzkq0wA
 n1sA==
X-Gm-Message-State: AOAM531iAq7elUDuRIc8ZLP38MPtUmmC6Tjm1/gdNOxIdkHUusxOyT1D
 oOOTWR3z59g1Ia30KTmO1xjQLg==
X-Google-Smtp-Source: ABdhPJzGtuKGvuHn7Hs3tsAJJSKRxigc5+3w+z9Bi7Q7gD24mVhzFYsaQVYK0ZRRinZqLcoxNVvUkQ==
X-Received: by 2002:adf:a3c5:: with SMTP id m5mr20400762wrb.390.1589799137524; 
 Mon, 18 May 2020 03:52:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t71sm16503679wmt.31.2020.05.18.03.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 03:52:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 758D41FF7E;
 Mon, 18 May 2020 11:52:15 +0100 (BST)
References: <9d75f1f6-3440-8dec-9266-4841362844d0@gmail.com>
 <CAFEAcA-yTm7h_EGZ4_iKVGJ0GMFinWOyQXyKsYgs8s933Bnn1Q@mail.gmail.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] Various questions about TCG implementation, DRM patches
 dealing with pointers over guest-host barrier.
In-reply-to: <CAFEAcA-yTm7h_EGZ4_iKVGJ0GMFinWOyQXyKsYgs8s933Bnn1Q@mail.gmail.com>
Date: Mon, 18 May 2020 11:52:15 +0100
Message-ID: <877dx9ldls.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Catherine A. Frederick" <agrecascino123@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 18 May 2020 at 00:23, Catherine A. Frederick
> <agrecascino123@gmail.com> wrote:
>> Hi, I've been patching TCG for my own purposes recently and I was
>> wondering a few things. That being:
>>
<snip>
>> - I've been implementing an instruction scheduler(list scheduler, with
>> priority given to most successors) for TCG and currently if I replace
>> instructions in s->ops(the TCG context) I get a crash later in
>> tcg_reg_alloc_op, even if the instruction stream is identical. Is there
>> anything else I need to move when I do this?
>
> This one's out of my field of knowledge; Richard might know.

I'm a little unclear in what is happening here. For TCG plugins we
insert dummy ops into the stream so they can be replaced or removed at a
later phase in the translation.

>> - Is insn_start necessary to have in order(and what does it do?)? These
>> currently are serializing instructions in my scheduler and significantly
>> limit my reordering as they create lots of dependencies every few
>> instructions.
>
> The primary purpose of insn_start is to save information about the
> current instruction in a metadata
<snip>
> Finally, I haven't checked, but I suspect the new TCG plugin APIs
> implicitly assume that code for each insn is generated serially,
> ie that a plugin can do "for each instruction" type work on a
> callback that hangs off the insn_start op.

Spoiler alert: Yes it does ;-)

--=20
Alex Benn=C3=A9e


Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FB822288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUb9a+65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FB822288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXtV-0003k6-LY
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXsn-0003Je-R6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:54:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXsl-000084-Pr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:54:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id b79so3133107wmb.4
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Xo2xv+zF5NO/fS89ubpJ+prjmYFNpyi3Uo5iYF+lzqI=;
 b=tUb9a+65C3OxtYepAv6a0ZCAYtHRjpm+E+YOZhod+tnWpu+Q+RXLCFdtLsR2eJD4xx
 jKJf0W8bNzrTHMyGrnEye4cUsaQokrK4KbudlpmZ80juT9jZV3onM1G2etApj0thEMtY
 FfqwuXK1BN08SSHdAmmN1YdVKvc9OeM2MOUOOXnnCnNpz+D8qkkP567wNUeLBHiWg6Qq
 cDTWEBIBR9GnmFyneCqrdLj3WTSv5i6jqDwU72Y47re9D7/XEY6Qlt0JvkYvwqSCoDEH
 efdUajE8W+1XPpTa2WAcWHau6HLCyLoOlPP8NNvMYocVTPP5RnxI9qC0Qo2ZRekR4x90
 piVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Xo2xv+zF5NO/fS89ubpJ+prjmYFNpyi3Uo5iYF+lzqI=;
 b=MmZkgpEmaaRS+q4IzGBKfw8q6FHDm4/VC4MEmMpqXx3KcBZE+k/qGAufCUfdoi33DJ
 5l/nn3UmU0dUn7p8zkoDCcV7J2BT1RPYne+9FbQGAmvxzFQqeu5bM3CyB9wo74INROSQ
 hEIDhNnKYrNXFuuDwvqDn+FX3Xv/BsES6IHBq7GadTligO5UBFdaCyYOPeToE2h02mR0
 jNmfuXZOmI8AfQAj9wbS8xlR0SqFEcZvCWmm5MvZ8PikhJ1grEH14ld/S7wudeByensg
 nSULIrqLJUIIyT193xMWbs6RBafdmRmAW4gz44UeszWByuRkdFo34vDaKoUVPAmDE0YH
 yxGQ==
X-Gm-Message-State: AOAM530PDi+O2IIJ8wubsrw1lWLzeWr1B6+RUCbNK4aWW2PRFVJoSA1a
 rR9Sjt7QMm2FWSbSPcwYJtd4UA==
X-Google-Smtp-Source: ABdhPJwg67Dm7Qdv1daeKnirYKrXnm0w3pI3/LZr+aJhMJ7qTH4VPfxYgPsggrG/N1U+YDYt4jgQ+A==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr4752556wme.96.1600264437199; 
 Wed, 16 Sep 2020 06:53:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b187sm5545498wmb.8.2020.09.16.06.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 06:53:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85FE81FF7E;
 Wed, 16 Sep 2020 14:53:55 +0100 (BST)
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <495bd2bd-4f38-8fe2-e758-82acbecd0d04@redhat.com>
 <436800a3-7645-52f7-5fea-134d883c0a7b@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Python 3.5 EOL; when can require 3.6?
In-reply-to: <436800a3-7645-52f7-5fea-134d883c0a7b@redhat.com>
Date: Wed, 16 Sep 2020 14:53:55 +0100
Message-ID: <87d02lzv2k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 16/09/2020 09.53, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 9/16/20 9:43 AM, Markus Armbruster wrote:
>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>> already does for its Python parts.
>>>
>>>
>>> [*] https://www.python.org/downloads/release/python-3510/
>>=20
>> Not answering your question, but it would help to start a table
>> of "oldest package released" versions, with our supported distributions
>> as columns and package names as row.
>>=20
>> This way when new distributions are released (and oldest dropped from
>> our side) we can add/remove a column and see the oldest version we aim
>> to support.
>
> That's quite a bit of extra work - I think it's enough to look up the
> versions on repology instead, e.g.:
>
> https://repology.org/project/python/versions

Hmm are there any magic runes to limit the list to only the distros we
care about?

--=20
Alex Benn=C3=A9e


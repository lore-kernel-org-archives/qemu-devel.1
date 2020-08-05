Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3D02177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9CmIRzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3D02177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GTS-0000c3-D3
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3GSj-00085d-7E
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:15:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3GSh-0002Hj-GO
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:15:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id r4so37160737wrx.9
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xlR8qnt0jhjCdt8eier9+rUjNGqwZoSBy91ZV6lYB+Q=;
 b=S9CmIRzGCqpYATNZF0BAtQoOTNnN9+iPkNC/zHKMzTzZePqM9f0S6GHKgRYm1HZ2DP
 CsDQ2V0UGX6Az4JEsLR0T9QFBf8mDPw+377t0uwxK/QmXABNjDSaZcxpCMfpQ9sjzS6q
 LKmPCh3qgw8milPDb1UNjDUvZqrbAYxiHIRbj3fCVaxDMi5dkF9L39aL9ClKWW+Erg9Q
 8Y4Og5lunRJ/P9L8h3HLPNAxqCsEAJRsOxCamJIGYDlnmjvxeu73yaMHf43nFZpkUZB5
 AnNc+Fz4Y2ipAuH5o2AFlxTcX3LPBtOAnzlZV3Xb10GGPOL5Nvo1wsVCBBXEqvBFUubY
 hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xlR8qnt0jhjCdt8eier9+rUjNGqwZoSBy91ZV6lYB+Q=;
 b=pmarXEjvU+aHNIqQ3H+gVAhdlFvjM1iiWcQ1vgW5AOV7tY100j3o0d1i5tO3NeZ5sf
 QhgnMTbnFkbg4Y8EDUVVBfSjX5vmPviUO6leXLiIPKdcQ/DBrHasvm8opgz6ftbtcQNz
 5EbAdYY2WQ+7f3kJSwrHWZmf7m7TimrgBndcuwJ5cjcHjqVEDr5Ecneut4LFjwD3D3L+
 DZCuXitMnm76AlEdBwymCTBcx0YO1vb385NHEp3gwy5FRMa2A6V2QyPKv6ASMWYVIyF6
 SxAgJyDZeCcOW1272m8Is7jDYKY+zUJqhflqp/5QG+aXgCYly4IYNWTCxvpPgMbIv8OM
 wdBA==
X-Gm-Message-State: AOAM532hh4V0rLSu3Y/Hw3XPw+0iTzdYK2MiGCzlB+6ZaaqyxHoMxI+w
 KKPD+Ba8LJpV6WrnPNXrJlUe1Q==
X-Google-Smtp-Source: ABdhPJxUxMusktRW6ohdj2oC0nT6dI8m6IScDU69zDxEK/9gjHNTHCGquwA6XtVPfPlN2A4sqPifmA==
X-Received: by 2002:adf:8282:: with SMTP id 2mr2128558wrc.76.1596622553273;
 Wed, 05 Aug 2020 03:15:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o7sm2096732wrv.50.2020.08.05.03.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 03:15:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 857C51FF7E;
 Wed,  5 Aug 2020 11:15:50 +0100 (BST)
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
 <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
 <874kph4gj2.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
In-reply-to: <874kph4gj2.fsf@dusky.pond.sub.org>
Date: Wed, 05 Aug 2020 11:15:50 +0100
Message-ID: <871rklmm95.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 05/08/20 09:36, Markus Armbruster wrote:
>>> There's also the longer term pain of having to work around git-blame
>>> unable to see beyond the flag day.
>>
>> Do you really use "git blame" that much?  "git log -S" does more or less
>> the same function (in a different way) and is not affected as much by
>> large code movement and transformation patches.
>
> C-x v g
>
> When that doesn't work, I fall back to git-log -S in a shell.

Yep, I'm another that uses blame in the first instance (or magit-blame
inside emacs). My usual fallback after that is git log -p and liberal
use of / which is very inefficient.

--=20
Alex Benn=C3=A9e


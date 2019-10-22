Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4310521872
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc9UdxhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4310521872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsUz-00036A-Fq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMsTm-00027Z-SQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMsTk-0007U8-I3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:37:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMsTk-0007Tg-79
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:37:32 -0400
Received: by mail-wm1-x342.google.com with SMTP id q70so9670038wme.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hQ+UA6Kn5QiEP5dUKDIG7lKPbk1haJyju97ftKoL6uU=;
 b=Cc9UdxhYYm1UPum8LTHEQB/PjDuZMerrSPgCWb38aMzHCF+FW/+qFhGZvXTtrXxJq6
 gN5rKsazaf38klPSTbmDbwJ/uIzQwkjNnGPlxnOxIQh6LkyhLnXJbpIGjwUBujNaWPs1
 tn8nLnVwz23fDtf3DuZSxJcwzT7U7hCYbidHqwB9i6tUsKv7vXeRmj4APRn7rs0FSDwV
 NvamArtmhsuC+S+8ZjvmVDxJ28wvw+1kxyAfU+4cucoDMsmXidwoy4rc0qXAGfhSBlKL
 r/YQ+5eie9s92QGArDtgnVyAkL8zOubJP0/YbMmMEgZHYyif/Gu8cfr4Cwy8YIn91tGz
 UCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hQ+UA6Kn5QiEP5dUKDIG7lKPbk1haJyju97ftKoL6uU=;
 b=Ammk0BplXjiFcWucBq9LESXBvDdmS4h43Z2FBCAWuJR7+BnnHddGYmS/oBDc66kWPr
 blV/Rz5hnvnVnbGBrLQE71K9jv+Ut63NGQa4lV2BFEN9kqy1xkir8A4/uyjdiMcfGjtU
 Bw2dyctr9c8lRe8kyzW2WJmTeMbiMt8vxXPNU7iZPJhwDS5ODC+7O0rKijSvYw4zn4O8
 0tS1ahqjgGjPUsxSLcHxI5sYy7kNSmSw7Wmn+1cHO0skYHJG7XUGeVSz6KXDeXV80Jgr
 sJP9VkKNwyyVF5Kt4ZtyYqM5o941fwodfv4yHuavtqLnfgWgKMem/xAgcEL97yI8t1ds
 mKMQ==
X-Gm-Message-State: APjAAAVUOkrFUjmf8gKHwtHUY++ZLszzf4H1OFj3PTjUo7FRXGAp3SXh
 3eewBUZg92VwajR6gA5Vw+WU9w==
X-Google-Smtp-Source: APXvYqxr1OrEGjBxM4J4gO8+3eaUCkh1ldzpSq6wAro7mkNxTtJUg8zULegiELCIiMLkl4Nlv8P4Og==
X-Received: by 2002:a1c:1b06:: with SMTP id b6mr1041570wmb.3.1571744250593;
 Tue, 22 Oct 2019 04:37:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l22sm14466971wrb.45.2019.10.22.04.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 04:37:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 28E861FF87;
 Tue, 22 Oct 2019 12:37:29 +0100 (BST)
References: <20191017131615.19660-1-alex.bennee@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH for 4.2 v6 00/54] Support for TCG plugins
In-reply-to: <20191017131615.19660-1-alex.bennee@linaro.org>
Date: Tue, 22 Oct 2019 12:37:29 +0100
Message-ID: <87imohvwna.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: aaron@os.amperecomputing.com, cota@braap.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is the latest iteration of the TCG plugins series. From the document=
ation:
>
>   QEMU TCG plugins provide a way for users to run experiments taking
>   advantage of the total system control emulation can have over a guest.
>   It provides a mechanism for plugins to subscribe to events during
>   translation and execution and optionally callback into the plugin
>   during these events. TCG plugins are unable to change the system state
>   only monitor it passively. However they can do this down to an
>   individual instruction granularity including potentially subscribing
>   to all load and store operations.
>
> This is mostly a adding signoffs and some patch re-organisation and
> splitting. For reference the longer notes about what API tweaks didn't
> make it into this iteration can be found in the previous series:
>
>   Subject: [PATCH for 4.2 v5 00/55] Support for TCG plugins
>   Date: Mon, 14 Oct 2019 11:48:53 +0100
>   Message-Id: <20191014104948.4291-1-alex.bennee@linaro.org>
>
> Changes of note:
>
>   - now use gmodule to load symbols instead of dlsym
>   - re-jigged translator_ld to avoid creating more alias functions
>   - moved configure change to final place
>   - moved additional API bits to before examples
>   - merged api changes to examples into final single commit versions
>   - tweaked hwaddr API to talk of device_offset
>
> Most of the checkpatch formatting complaints I think are overly picky
> given the attempt to make table look nice or not wrap for the sake of
> going one character over. I've included a checkpatch patch to stop
> bothering me about (foo, /* empty */) comments. As ever there are more
> details bellow the ---
>
> Only a few more un-reviewed patches before I can send the PR:
>
>    02 - trace add mmu_index to mem_info
>    37 - plugin expand the plugin_init function to include
>    39 - plugin add qemu_plugin_outs helper
>    54 - scripts chec.pl don t complain about foo em

Ping?

I've made two minor changes which you can currently see in:

  https://github.com/stsquad/qemu/tree/plugins/plugins-v7

I've made a tweak to translator_ld which takes advantage of the cputlb
cleanup:

  Subject: [PATCH v2] cputlb: ensure _cmmu helper functions follow the nami=
ng standard
  Date: Mon, 21 Oct 2019 16:09:10 +0100
  Message-Id: <20191021150910.23216-1-alex.bennee@linaro.org>

and I've added a MAINTAINERS entry. I didn't think it was worth spamming
the list before I sent my PR. Let me know if you want a final v7
posting to the list.

--
Alex Benn=C3=A9e


Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C66C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AD62074B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERygOQXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AD62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZio-0002X7-57
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNZhZ-0001bJ-PD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:51:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNZhX-0000cO-K1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:51:13 -0400
Received: by mail-wr1-x442.google.com with SMTP id m6so1268079wrn.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
 :date:mime-version:content-transfer-encoding;
 bh=lM+/BgmuWO6moAFZiSWSS55wC0y1yrlpFzdAELZ8Eks=;
 b=ERygOQXyQT+MF2uZWNLylWYDdGdLchvL0cLn+GwWs5E+zbV7BeuE4FcCFuvsspar7E
 XfQjl+HiA78MwsCyUuIkZu5WXJMDV3dngyF31Qag4g+mgL7NhRGrhznegFhEA7lxyZvP
 px999u4LCUdnpnWXuIpM+fqXfyDlXrp+02qz3Fid7ibmynHC1/FgRlsXIcwDqZL12YZe
 3RPBvf6MHgqkoRbUPTQAFjwC/Axd02ZxQ1IgGeXOVv+Wp17ZHYxzkhl75KjW6lAbHXyy
 KAb9ZT15prEeNeJVN/vxsPbi4DnoIxwg3U3eG/NFS3OxYz2OajqS0q5KFmQrV1uup29V
 v4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :message-id:in-reply-to:date:mime-version:content-transfer-encoding;
 bh=lM+/BgmuWO6moAFZiSWSS55wC0y1yrlpFzdAELZ8Eks=;
 b=LXKz5tGo2wmkS1SnIZox+0x4r6/wM3hk76bZAC6YuSQ0twPqts5AvnntT0I7sxNca2
 qX3EbHDH5jtOoCP9dsVUxG2dLccmWVFLSpQjUv273anN2tmtcGy6ZY0tRztuol2TXeTN
 Mr379OdIyG1KUGyeCvb/xOQLM7AAAU3THEOxnTAaLvUMbSgE1+SRChoNFfdYU7687DCI
 9wJtLWL9bGOkjJPijVnfxEBcjHgNPLxARoac+PwsK8da8fmZi7kphWYfHg3/zEF8ubH1
 9PY7Z9/WvY7AodkQJtt6EfHBS0S6cp0unvO6pSA7ocnX5buLQKXgDfbgHfZ0GMcSHihG
 vQAA==
X-Gm-Message-State: AOAM533BL/6ZSVptDbHrCWJZ8MoSpR0HRqRV55Y1FBe76AQPUy+wtYV9
 /R57Wl30U71VxrDkBPCyv9sDawgz0KqZDg==
X-Google-Smtp-Source: ABdhPJxAx3+8Ggon/EYGvOT+uC3crebbWC0/KZNeMDrIuPxulxuGuE5A0BC2wMh0fH1A/awfdzx0qA==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr2601262wrp.390.1601463068823; 
 Wed, 30 Sep 2020 03:51:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u17sm2497104wri.45.2020.09.30.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 03:51:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2F4721FF7E;
 Wed, 30 Sep 2020 11:51:07 +0100 (BST)
References: <20200925154027.12672-1-alex.bennee@linaro.org>
 <20200925154027.12672-4-alex.bennee@linaro.org>
 <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 03/15] meson: move libmpathpersist test
Message-ID: <87ft70pgpq.fsf@linaro.org>
In-reply-to: <f5fc27fa-0c02-b1a9-7f29-dd48aa40fd6a@redhat.com>
Date: Wed, 30 Sep 2020 11:51:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/09/20 17:40, Alex Benn=C3=A9e wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>=20
>> This is the first compiler/linker test that has been moved to Meson.
>> Add more section headings to keep things clearer.
>>=20
>> [thuth: Add check for mpathpersist.found() before showing mpathpersist_n=
ew_api]
>>=20
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20200918103430.297167-3-thuth@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>
>
> This is not the latest version of the series, can you drop patches 2
> and 3?

Hmm so now I'm seeing failures in the bionic builds thanks to libmpath:

  Linking target qemu-pr-helper
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `free_config'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dlog'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `strlcpy'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `mpath_connect'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `mpath_disconnect'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `select_reservation_key'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `free_pathvec'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_get_maps'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `select_all_tg_pt'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `find_mp_by_alias'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `send_packet'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `cleanup_prio'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `pathinfo'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `disassemble_map'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_mapname'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `recv_packet'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `vector_alloc'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_get_status'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `pathcount'
  /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpersist.so: undef=
ined reference to `cleanup_checkers'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `set_max_fds'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `disassemble_status'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_map_present'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_is_mpath'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_lib_release'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `get_udev_device'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_get_map'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `dm_lib_exit'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `free_multipathvec'
  /usr/bin/ld: /usr/bin/../lib/gcc/x86_64-linux-gnu/9/../../../libmpathpers=
ist.so: undefined reference to `load_config'
  clang: error: linker command failed with exit code 1 (use -v to see invoc=
ation)
  make: *** [Makefile.ninja:2150: qemu-pr-helper] Error 1
  make: *** Waiting for unfinished jobs....

Is this detection ordering issue? It happens on master as well but isn't
currently picked up by CI because nothing is running Focal yet.

--=20
Alex Benn=C3=A9e


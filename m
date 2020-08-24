Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B13C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321ED206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="bAyREune"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321ED206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADNG-0003zS-1e
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kADLz-0003Ob-W9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:21:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kADLy-0001Xc-0e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:21:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id s20so3483803wmj.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=z3N+sHXH4xnNVsdGuqjSm7hHX+cWbiH9KUTQyCZ93Xw=;
 b=bAyREune3tE1kGMyefLXKxWvV+ny60Sa7AsdUsBMr1Qh23hHF6n0AByKKXn1cKsnBL
 YEtTyxedEHFutwX70Czn5TLBwsctOz8jz8mgDKlmCm9B/IMvFAdFloMbxwYjcQq/SVei
 EZz0S24qbX84h4zNqWh8WQF3+gBGSxfKWe960WA0szMPR8/WeBzv223CvQYG5tapNcs5
 3H1XvM2Gp095VctSEL8MF8TWMxjvSB7mboPTGTpjE/HaR0ow/gWNiv7Vz8HTrVjgST8D
 TVRjkZS+dUPejcBj42wx4dl2qKRar4srZHkMe85vR4DpfyrWssEQR1jK8+TWOmrsP4tf
 3J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=z3N+sHXH4xnNVsdGuqjSm7hHX+cWbiH9KUTQyCZ93Xw=;
 b=ZxuHSdNsvyK3ktLPw2D415d6vFPbMjI8Hvea5YrnwRlRPSHXzYrD2LP9UFNnlc0Q1S
 1BVTK5LkSRxPdELTVPGQ5w5ifK9fCVHAt2e4mcRKFEdSL2wAvVPtnVqFzykmKgcbRgzf
 YtFpmzkpaTa90w3F6dRAKdO8Zzwkm7NqIubDgiH6wWEDISDa+Xo2nUNuePgQEgxvs1jf
 h0iJLDe48UCcoKcJ0y0NHSjXBwwVSyzJs4+bsS0rthcezhFM2mARLHLrXpvpy4Kch3Cd
 HqNHrkhj04ytKbafehhGF9q6D9AhooumNus8V0g3S+25I5kmhRh3zDx9fclbugWpl01d
 1bjQ==
X-Gm-Message-State: AOAM5332SL2I3bV+ucC8MFhIj0b9i8L34BGFvVBnHB3x4KGaB+un8VHB
 U/c7uPRHhgJeoBPBJOaU+BRryA==
X-Google-Smtp-Source: ABdhPJwnc1etMTEUgkDc1FJ+L+SfiUW8Okw9+sUaQ9WIRzyJLxxCuLlndHIfkkSYuNJ0SdsCzzHFcQ==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr5836586wmc.22.1598278899286;
 Mon, 24 Aug 2020 07:21:39 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id o2sm23349992wrh.70.2020.08.24.07.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:21:38 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 49b6382c;
 Mon, 24 Aug 2020 14:21:37 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 5/9] block/curl: Allow the blocksize to be specified
 by the user
In-Reply-To: <87a6ykqizn.fsf@dusky.pond.sub.org>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
 <20200818110845.3825105-6-david.edmondson@oracle.com>
 <87a6ykqizn.fsf@dusky.pond.sub.org>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Mon, 24 Aug 2020 15:21:36 +0100
Message-ID: <m2pn7g15vz.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::342;
 envelope-from=dme@dme.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Monday, 2020-08-24 at 15:19:24 +02, Markus Armbruster wrote:

> David Edmondson <david.edmondson@oracle.com> writes:
>
>> Rather than a fixed 256kB blocksize, allow the user to specify the
>> size used. It must be a non-zero power of two, defaulting to 256kB.
>
> Nitpick: any power of two is non-zero.  Scratch "non-zero".

Indeed.

>> Signed-off-by: David Edmondson <david.edmondson@oracle.com>
>> ---
> [...]
>> diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
>> index bc38b9df38..ee504ee41a 100644
>> --- a/docs/system/device-url-syntax.rst.inc
>> +++ b/docs/system/device-url-syntax.rst.inc
>> @@ -194,6 +194,13 @@ These are specified using a special URL syntax.
>>        Add an offset, in bytes, to all range requests sent to the
>>        remote server.
>>  
>> +   ``blocksize``
>> +      The size of all IO requests sent to the remote server. This
>> +      value may optionally have the suffix 'T', 'G', 'M', 'K', 'k' or
>> +      'b'. If it does not have a suffix, it will be assumed to be in
>> +      bytes. The value must be a non-zero power of two.  It defaults
>> +      to 256kB.
>> +
>>     Note that when passing options to qemu explicitly, ``driver`` is the
>>     value of <protocol>.
>>  
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index d6f5e91cc3..cd16197e1e 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3764,10 +3764,14 @@
>>  # @proxy-password-secret: ID of a QCryptoSecret object providing a password
>>  #                         for proxy authentication (defaults to no password)
>>  #
>> +# @blocksize: Size of all IO requests sent to the remote server; must
>> +#             be a non-zero power of two (defaults to 1 256kB)
>
> Scratch "non-zero".
>
> "(defaults to 1 256kB)" confuses me.  Do you mean "(defaults to 256kB)"?

Yes, thanks for catching it.

> Please add "(since 5.2)".

Will do.

>> +#
>>  # Since: 2.9
>>  ##
>>  { 'struct': 'BlockdevOptionsCurlBase',
>>    'data': { 'url': 'str',
>> +            '*blocksize': 'int',
>
> Should we use 'size' rather than 'int'?

Yes.

>>              '*timeout': 'int',
>>              '*username': 'str',
>>              '*password-secret': 'str',

dme.
-- 
But are you safe Miss Gradenko?

